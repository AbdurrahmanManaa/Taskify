import 'package:flutter/material.dart';
import 'package:taskify/core/utils/file_manager.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';

class AttachmentItem extends StatelessWidget {
  const AttachmentItem({
    super.key,
    required this.fileName,
    required this.fileExtension,
    this.fileSize,
    this.trailing,
  });
  final String fileName, fileExtension;
  final String? fileSize;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: AppColors.borderColor,
        ),
      ),
      tileColor: AppColors.scaffoldLightBackgroundColor,
      leading: Icon(
        FileUtils.getIconForFileExtension(fileExtension),
        color: AppColors.primaryLightColor,
      ),
      title: Text(
        fileName,
        style: AppTextStyles.regular16,
      ),
      subtitle: fileSize != null
          ? Text(
              fileSize!,
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.bodyTextColor,
              ),
            )
          : null,
      trailing: trailing,
    );
  }
}
