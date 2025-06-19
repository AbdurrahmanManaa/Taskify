import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/presentation/widgets/settings_section.dart';
import 'package:taskify/core/widgets/option_item.dart';
import 'package:taskify/generated/l10n.dart';

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({
    super.key,
    this.profileOnTap,
    this.connectedAccountsOnTap,
  });
  final Function()? profileOnTap;
  final Function()? connectedAccountsOnTap;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: S.of(context).accountSectionTitle,
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
            S.of(context).profileOptionItem,
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
            S.of(context).connectedAccountsOptionItem,
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
