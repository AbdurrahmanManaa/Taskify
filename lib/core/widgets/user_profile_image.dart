import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_assets.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
    required this.size,
    this.imageUrl,
    this.broderWidth = 2,
  });
  final String? imageUrl;
  final double size;
  final double broderWidth;

  @override
  Widget build(BuildContext context) {
    return AdvancedAvatar(
      size: size,
      foregroundDecoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryLightColor,
          width: broderWidth,
        ),
      ),
      child: ClipOval(
        child: (imageUrl != null && imageUrl!.isNotEmpty)
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                height: size,
                width: size,
              )
            : Image.asset(
                AppAssets.imagesUserDefaultIcon,
                fit: BoxFit.cover,
                height: size,
                width: size,
              ),
      ),
    );
  }
}
