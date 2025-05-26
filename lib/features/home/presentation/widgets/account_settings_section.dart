import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/presentation/widgets/settings_section.dart';
import 'package:taskify/core/widgets/option_item.dart';

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({
    super.key,
    this.profileOnTap,
    this.connectedAccountsOnTap,
    this.deleteAccountOnTap,
  });
  final Function()? profileOnTap;
  final Function()? connectedAccountsOnTap;
  final Function()? deleteAccountOnTap;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Account',
      widgets: [
        const SizedBox(height: 20),
        OptionItem(
          onTap: profileOnTap,
          leading: Icon(
            Icons.account_circle,
            size: 30,
            color: AppColors.primaryLightColor,
          ),
          title: Text(
            'Profile',
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
          onTap: connectedAccountsOnTap,
          leading: Icon(
            Icons.link,
            size: 30,
            color: AppColors.primaryLightColor,
          ),
          title: Text(
            'Connected accounts',
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
          onTap: deleteAccountOnTap,
          leading: Icon(
            Icons.person_off,
            size: 30,
            color: AppColors.errorColor,
          ),
          title: Text(
            'Delete Account',
            style: AppTextStyles.medium18.copyWith(color: AppColors.errorColor),
          ),
        ),
      ],
    );
  }
}
