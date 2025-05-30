import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taskify/core/functions/build_snackbar.dart';

class FilePickerService {
  Future<List<File>?> pickMultipleFiles(
      {required BuildContext context,
      FileType? type,
      List<String>? allowedExtensions}) async {
    PermissionStatus status = await Permission.storage.request();

    if (!status.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: type ?? FileType.any,
        allowedExtensions: type == FileType.custom ? allowedExtensions : null,
      );

      if (result != null) {
        return result.paths.map((path) => File(path!)).toList();
      }
    } else {
      if (!context.mounted) return null;
      buildSnackbar(
        context,
        message:
            'Permission Denied, Storage permission is required to select files.',
      );
      Future.delayed(
        const Duration(seconds: 1),
        () async {
          await openAppSettings();
        },
      );
    }
    return null;
  }
}
