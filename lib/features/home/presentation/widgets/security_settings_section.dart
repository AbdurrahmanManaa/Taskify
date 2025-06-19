import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/presentation/widgets/settings_section.dart';
import 'package:taskify/core/widgets/option_item.dart';
import 'package:taskify/generated/l10n.dart';

class SecuritySettingsSection extends StatelessWidget {
  const SecuritySettingsSection(
      {super.key, this.changePasswordOnTap, this.appLockOnTap});
  final Function()? changePasswordOnTap;
  final Function()? appLockOnTap;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: S.of(context).securitySectionTitle,
      widgets: [
        const SizedBox(height: 20),
        OptionItem(
          onTap: changePasswordOnTap,
          leading: Icon(
            Icons.security,
            size: 30,
            color: AppColors.primaryLightColor,
          ),
          title: Text(
            S.of(context).changePasswordOptionItem,
            style: AppTextStyles.medium18
                .copyWith(color: AppColors.primaryLightColor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.primaryLightColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Divider(),
        ),
        OptionItem(
          onTap: appLockOnTap,
          leading: Icon(
            Icons.fingerprint,
            size: 30,
            color: AppColors.primaryLightColor,
          ),
          title: Text(
            S.of(context).appLockOptionItem,
            style: AppTextStyles.medium18
                .copyWith(color: AppColors.primaryLightColor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.primaryLightColor,
          ),
        ),
      ],
    );
  }
}
