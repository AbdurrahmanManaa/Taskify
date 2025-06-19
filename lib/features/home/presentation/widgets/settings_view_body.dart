import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/extensions/user_preferences_extension.dart';
import 'package:taskify/core/functions/get_scheme_primary_color.dart';
import 'package:taskify/core/functions/show_language_selection_modal_sheet.dart';
import 'package:taskify/core/functions/show_theme_mode_selection_modal_sheet.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/option_item.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/features/home/domain/entities/edit_user_entity.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_fonts.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_icon_badge_style.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_language.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_scheme.dart';
import 'package:taskify/features/home/presentation/views/app_lock_view.dart';
import 'package:taskify/features/home/presentation/views/connected_accounts_view.dart';
import 'package:taskify/features/home/presentation/views/edit_user_view.dart';
import 'package:taskify/features/home/presentation/views/profile_view.dart';
import 'package:taskify/features/home/presentation/widgets/account_actions_settings_section.dart';
import 'package:taskify/features/home/presentation/widgets/account_settings_section.dart';
import 'package:taskify/features/home/presentation/widgets/edit_user_view_body.dart';
import 'package:taskify/features/home/presentation/widgets/preferences_settings_section.dart';
import 'package:taskify/features/home/presentation/widgets/security_settings_section.dart';
import 'package:taskify/generated/l10n.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  Future<void> _fontSelection(BuildContext context) {
    final prefs = HiveService.preferencesNotifier.value;
    final font = prefs.appFont;
    final language = prefs.appLanguage;
    final fontLabel = font.label(context);
    final List<AppFonts> fontsToShow = AppFonts.values.where((item) {
      return language == AppLanguage.arabic ? item.isArabic : !item.isArabic;
    }).toList();

    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).showFontSelectionModalSheetTitle,
                style: AppTextStyles.medium24.copyWith(
                  color: AppColors.primaryLightColor,
                ),
              ),
              const Divider(),
              Flexible(
                child: ListView.separated(
                  itemCount: fontsToShow.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final selectedFont = fontsToShow[index];
                    final selectedFontlabel = selectedFont.label(context);

                    return OptionItem(
                      onTap: () async {
                        final updated = prefs.copyWith(appFont: selectedFont);
                        await HiveService().setUserPreferences(updated);
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      },
                      title: Text(
                        selectedFontlabel,
                        style: AppTextStyles.medium18,
                      ),
                      subtitle: Text(
                        S.of(context).fontSelectionModalSheetDescription,
                        style: TextStyle(
                          fontFamily: fontLabel,
                          fontSize: 18,
                        ),
                      ),
                      trailing: selectedFont == font
                          ? Icon(Icons.check,
                              color: AppColors.primaryLightColor)
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> _badgeStyleSelection(BuildContext context) {
    final prefs = HiveService.preferencesNotifier.value;
    final badgeStyle = prefs.appIconBadgeStyle;

    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).showBadgeSelectionModalSheetTitle,
                style: AppTextStyles.medium24
                    .copyWith(color: AppColors.primaryLightColor),
              ),
              Divider(),
              OptionItem(
                onTap: () async {
                  final updated = prefs.copyWith(
                    appIconBadgeStyle: AppIconBadgeStyle.dot,
                  );
                  await HiveService().setUserPreferences(updated);
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
                leading: Icon(
                  Icons.circle,
                  size: 30,
                  color: AppColors.errorColor,
                ),
                title: Text(
                  S.of(context).BadgeStyleSelectionOption1,
                  style: AppTextStyles.medium18,
                ),
                trailing: badgeStyle == AppIconBadgeStyle.dot
                    ? Icon(
                        Icons.check,
                        color: AppColors.primaryLightColor,
                      )
                    : null,
              ),
              Divider(),
              OptionItem(
                onTap: () async {
                  final updated = prefs.copyWith(
                    appIconBadgeStyle: AppIconBadgeStyle.number,
                  );
                  await HiveService().setUserPreferences(updated);
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
                leading: Icon(
                  Icons.looks_one,
                  size: 30,
                  color: AppColors.errorColor,
                ),
                title: Text(
                  S.of(context).BadgeStyleSelectionOption2,
                  style: AppTextStyles.medium18,
                ),
                trailing: badgeStyle == AppIconBadgeStyle.number
                    ? Icon(
                        Icons.check,
                        color: AppColors.primaryLightColor,
                      )
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> _schemeColorSelection(BuildContext context) {
    final prefs = HiveService.preferencesNotifier.value;
    final appScheme = prefs.appScheme;
    final schemeLabel = appScheme.label(context);

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 1,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Text(
                  S.of(context).showSchemeColorSelectionModalSheetTitle,
                  style: AppTextStyles.medium24
                      .copyWith(color: AppColors.primaryLightColor),
                ),
                Divider(),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: AppScheme.values.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (context, index) {
                      final scheme = AppScheme.values[index];
                      final schemeColor = getSchemePrimaryColor(
                        context,
                        scheme,
                      );

                      return OptionItem(
                        onTap: () async {
                          final updated = prefs.copyWith(
                            appScheme: scheme,
                          );
                          await HiveService().setUserPreferences(updated);
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                        leading: CircleAvatar(
                          backgroundColor: schemeColor,
                          radius: 15,
                        ),
                        title: Text(
                          schemeLabel,
                          style: AppTextStyles.medium18,
                        ),
                        trailing: appScheme == scheme
                            ? Icon(Icons.check,
                                color: AppColors.primaryLightColor)
                            : null,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _signOut(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.scaffoldLightBackgroundColor,
        title: Text(S.of(context).signOutDialogTitle),
        content: Text(S.of(context).signOutDialogDescription),
        actions: [
          TextButton(
            child: Text(
              S.of(context).cancelModalSheetButton,
              style: TextStyle(color: AppColors.primaryLightColor),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              S.of(context).confirmModalSheetButton,
              style: TextStyle(color: AppColors.primaryLightColor),
            ),
            onPressed: () async {
              await context.read<UserCubit>().signOut();
            },
          ),
        ],
      ),
    );
  }

//! Adjust this method to remove attachments from storage first and then update paths in tables then delete user!.
  Future<void> _deleteAccount(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.scaffoldLightBackgroundColor,
        title: Text(S.of(context).deleteAccountDialogTitle),
        content: Text(S.of(context).deleteAccountDialogDescription),
        actions: [
          TextButton(
            child: Text(
              S.of(context).cancelModalSheetButton,
              style: TextStyle(color: AppColors.primaryLightColor),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              S.of(context).deleteModalSheetButton,
              style: TextStyle(color: AppColors.primaryLightColor),
            ),
            onPressed: () async {
              // await supabase
              //     .from(Endpoints.usersTable)
              //     .delete()
              //     .eq('id', supabase.auth.currentUser!.id);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = Provider.of<ScrollController>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomAppbar(
              title: S.of(context).settingsAppBar,
              showBackButton: false,
            ),
            const SizedBox(height: 20),
            AccountSettingsSection(
              profileOnTap: () {
                pushScreenWithoutNavBar(
                  context,
                  ProfileView(),
                );
              },
              connectedAccountsOnTap: () {
                pushScreenWithoutNavBar(
                  context,
                  ConnectedAccountsView(),
                );
              },
            ),
            const SizedBox(height: 20),
            SecuritySettingsSection(
              changePasswordOnTap: () {
                pushScreenWithoutNavBar(
                  context,
                  Provider.value(
                    value: EditUserEntity(
                      userEntity: context.read<UserCubit>().userEntity,
                      mode: EditProfileType.password,
                    ),
                    child: const EditUserView(),
                  ),
                );
              },
              appLockOnTap: () {
                pushScreenWithoutNavBar(
                  context,
                  AppLockView(),
                );
              },
            ),
            const SizedBox(height: 20),
            PreferencesSettingsSection(
              appIconBadgesOnTap: () async {
                await _badgeStyleSelection(context);
              },
              appThemeModeOnTap: () async {
                await showThemeModeSelectionModalSheet(context);
              },
              appSchemeOnTap: () async {
                await _schemeColorSelection(context);
              },
              appLanguageOnTap: () async {
                await showLanguageSelectionModalSheet(context);
              },
              appFontOnTap: () async {
                await _fontSelection(context);
              },
            ),
            const SizedBox(height: 20),
            AccountActionsSettingsSection(
              signOutOnTap: () async {
                await _signOut(context);
              },
              deleteAccountOnTap: () => _deleteAccount(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
