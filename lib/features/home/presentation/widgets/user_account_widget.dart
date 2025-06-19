import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/domain/entities/user_identity_entity.dart';
import 'package:taskify/generated/l10n.dart';

class UserAccountWidget extends StatelessWidget {
  const UserAccountWidget({
    super.key,
    required this.userIdentityEntity,
    required this.isConnected,
  });

  final UserIdentityEntity userIdentityEntity;
  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    final providerName =
        userIdentityEntity.providerIcon.split('/').last.split('.').first;
    final displayProvider =
        providerName[0].toUpperCase() + providerName.substring(1);
    final email = userIdentityEntity.userIdentity?.identityData?['email'] ??
        S.of(context).notConnected;

    return Row(
      children: [
        SvgPicture.asset(
          userIdentityEntity.providerIcon,
          height: 40,
          width: 40,
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              email,
              style: AppTextStyles.medium18,
            ),
            Text(
              displayProvider,
              style: AppTextStyles.medium16
                  .copyWith(color: AppColors.bodyTextColor),
            ),
          ],
        ),
      ],
    );
  }
}
