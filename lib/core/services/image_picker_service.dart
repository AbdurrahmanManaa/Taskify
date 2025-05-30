import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taskify/core/functions/build_snackbar.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();
  Future<File?> pickImage(
      {required ImageSource source, required BuildContext context}) async {
    PermissionStatus status;
    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
    } else if (source == ImageSource.gallery) {
      status = await Permission.photos.request();
    } else {
      return null;
    }
    if (!status.isGranted) {
      XFile? response = await _picker.pickImage(source: source);
      if (response != null) {
        File? imageFile = File(response.path);
        return imageFile;
      } else {
        return null;
      }
    } else {
      if (!context.mounted) return null;
      buildSnackbar(
        context,
        message:
            'Permission Denied, Permission to access the $source was denied. Please enable it in the settings.',
      );
      openAppSettings();
    }
    return null;
  }
}
