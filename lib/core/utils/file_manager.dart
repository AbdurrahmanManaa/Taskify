import 'dart:developer';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:taskify/core/services/file_picker_service.dart';
import 'package:taskify/core/services/supabase_storage_service.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/utils/endpoints.dart';

class FileManager {
  static Future<String> _getLocalFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }

  static Future<String> _getPublicFilePath(String fileName) async {
    Directory downloadsDirectory;
    if (Platform.isAndroid) {
      downloadsDirectory = Directory('/storage/emulated/0/Download');
    } else {
      downloadsDirectory = await getApplicationDocumentsDirectory();
    }
    return '${downloadsDirectory.path}/$fileName';
  }

  static Future<String?> downloadFile(String filePath) async {
    try {
      String fileName = p.basename(filePath);
      final localFilePath = await _getLocalFilePath(fileName);

      if (await File(localFilePath).exists()) {
        log('File already exists locally: $localFilePath');
        return localFilePath;
      }

      final response = await SupabaseStorageService().downloadFile(
        path: filePath,
        bucket: Endpoints.taskAttachmentsBucket,
      );

      final file = File(localFilePath);
      await file.writeAsBytes(response);

      log('File downloaded to: $localFilePath');
      return localFilePath;
    } catch (e) {
      log('Download error: $e');
      return null;
    }
  }

  static Future<void> openFile(String filePath) async {
    final result = await OpenFile.open(filePath);
    if (result.type != ResultType.done) {
      log('Failed to open file: ${result.message}');
    }
  }

  static Future<String?> moveFileToPublic(String internalFilePath) async {
    try {
      String fileName = p.basename(internalFilePath);
      String publicFilePath = await _getPublicFilePath(fileName);
      File publicFile = File(publicFilePath);

      if (await publicFile.exists()) {
        log('File already exists in public folder: $publicFilePath');
        return publicFilePath;
      }

      File internalFile = File(internalFilePath);
      if (await internalFile.exists()) {
        await internalFile.copy(publicFilePath);
        await internalFile.delete();
        log('File moved to public folder: $publicFilePath');
        return publicFilePath;
      }

      return null;
    } catch (e) {
      log('Error moving file to public: $e');
      return null;
    }
  }
}

class FileUtils {
  static String formatFileSize(int sizeInBytes) {
    if (sizeInBytes >= (1024 * 1024)) {
      return '${(sizeInBytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } else {
      return '${(sizeInBytes / 1024).toStringAsFixed(2)} KB';
    }
  }

  static Future<int> getFileSizeInBytes(String filePath) async {
    try {
      return await File(filePath).length();
    } catch (e) {
      return 0;
    }
  }

  static String getFileType(String fileName) {
    final extension = p.extension(fileName).toLowerCase();

    if ([
      '.png',
      '.jpg',
      '.jpeg',
      '.gif',
      '.bmp',
      '.webp',
      '.tiff',
      '.svg',
      '.ico',
      '.heif',
      '.heic',
      '.raw',
      '.nef',
      '.cr2'
    ].contains(extension)) {
      return 'image';
    } else if ([
      '.mp4',
      '.mov',
      '.avi',
      '.mkv',
      '.flv',
      '.wmv',
      '.webm',
      '.mpg',
      '.mpeg',
      '.3gp',
      '.ts'
    ].contains(extension)) {
      return 'video';
    } else if ([
      '.pdf',
      '.doc',
      '.docx',
      '.txt',
      '.xlsx',
      '.ppt',
      '.pptx',
      '.csv',
      '.html',
      '.css',
      '.json',
      '.xml',
      '.md'
    ].contains(extension)) {
      return 'document';
    } else if (['.zip', '.rar', '.7z', '.tar', '.gz', '.xz', '.iso']
        .contains(extension)) {
      return 'archive';
    } else {
      return 'unknown';
    }
  }

  static IconData getIconForFileExtension(String fileExtension) {
    String ext = fileExtension.startsWith('.')
        ? fileExtension.substring(1)
        : fileExtension;

    switch (ext.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
      case 'webp':
      case 'tiff':
      case 'svg':
      case 'ico':
      case 'heif':
      case 'heic':
      case 'raw':
      case 'nef':
      case 'cr2':
        return Icons.image;
      case 'mp4':
      case 'mov':
      case 'avi':
      case 'mkv':
      case 'flv':
      case 'wmv':
      case 'webm':
      case 'mpg':
      case 'mpeg':
      case '3gp':
      case 'ts':
        return Icons.video_library;
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'docx':
      case 'doc':
      case 'txt':
      case 'ppt':
      case 'pptx':
      case 'xlsx':
        return Icons.description;
      case 'csv':
        return Icons.table_chart;
      case 'html':
      case 'css':
      case 'json':
      case 'xml':
      case 'md':
        return Icons.code;
      case 'zip':
      case 'rar':
      case '7z':
      case 'tar':
      case 'gz':
      case 'bz2':
      case 'xz':
      case 'tar.gz':
      case 'tar.bz2':
      case 'iso':
        return Icons.archive;
      default:
        return Icons.insert_drive_file;
    }
  }
}

Future<void> pickFilesAndValidate(
  BuildContext context,
  Function(List<File>) onFilesPicked, {
  FileType fileType = FileType.any,
  List<String>? allowedFileExtensions,
}) async {
  List<File>? pickedFiles = await FilePickerService().pickMultipleFiles(
    context: context,
    type: fileType,
    allowedExtensions: allowedFileExtensions,
  );

  if (pickedFiles != null && pickedFiles.isNotEmpty) {
    int totalSizeInBytes = 0;
    for (File file in pickedFiles) {
      totalSizeInBytes += await FileUtils.getFileSizeInBytes(file.path);
    }

    if (totalSizeInBytes > 50 * 1024 * 1024) {
      buildSnackbar(context, message: 'File size should be less than 50 MB');
    } else {
      onFilesPicked(pickedFiles);
    }
  }
}
