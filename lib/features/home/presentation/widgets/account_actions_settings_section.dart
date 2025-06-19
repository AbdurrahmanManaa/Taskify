import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/presentation/widgets/settings_section.dart';
import 'package:taskify/core/widgets/option_item.dart';
import 'package:taskify/generated/l10n.dart';

class AccountActionsSettingsSection extends StatelessWidget {
  const AccountActionsSettingsSection(
      {super.key, this.signOutOnTap, this.deleteAccountOnTap});

  final Function()? signOutOnTap;
  final Function()? deleteAccountOnTap;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: S.of(context).accountActionsSectionTitle,
      widgets: [
        const SizedBox(height: 20),
        OptionItem(
          onTap: signOutOnTap,
          leading: Icon(
            Icons.logout_outlined,
            size: 30,
            color: AppColors.errorColor,
          ),
          title: Text(
            S.of(context).signOutOptionItem,
            style: AppTextStyles.medium18.copyWith(color: AppColors.errorColor),
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
            S.of(context).deleteAccountOptionItem,
            style: AppTextStyles.medium18.copyWith(color: AppColors.errorColor),
          ),
        ),
      ],
    );
  }
}
