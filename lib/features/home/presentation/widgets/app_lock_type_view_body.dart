import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/custom_wrapper_container.dart';
import 'package:taskify/core/widgets/option_item.dart';

class AppLockTypeViewBody extends StatefulWidget {
  const AppLockTypeViewBody({super.key});

  @override
  State<AppLockTypeViewBody> createState() => _AppLockTypeViewBodyState();
}

class _AppLockTypeViewBodyState extends State<AppLockTypeViewBody> {
  bool isCurrentLockType = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          CustomAppbar(title: 'App Lock Type'),
          const SizedBox(height: 40),
          CustomWrapperContainer(
            child: Column(
              children: [
                OptionItem(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(AppRoutes.pinLockType);
                  },
                  title: Text(
                    'PIN',
                    style: AppTextStyles.medium22,
                  ),
                  subtitle: isCurrentLockType
                      ? RichText(
                          text: TextSpan(
                            text: 'Medium-high security, ',
                            style: AppTextStyles.regular16.copyWith(
                              color: AppColors.bodyTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: 'Current lock type',
                                style: AppTextStyles.regular16.copyWith(
                                  color: AppColors.primaryLightColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          'Medium-high security',
                          style: AppTextStyles.regular16.copyWith(
                            color: AppColors.bodyTextColor,
                          ),
                        ),
                ),
                Divider(),
                OptionItem(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(AppRoutes.passwordLockType);
                  },
                  title: Text(
                    'Password',
                    style: AppTextStyles.medium22,
                  ),
                  subtitle: isCurrentLockType
                      ? RichText(
                          text: TextSpan(
                            text: 'Medium-high security, ',
                            style: AppTextStyles.regular16.copyWith(
                              color: AppColors.bodyTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: 'Current lock type',
                                style: AppTextStyles.regular16.copyWith(
                                  color: AppColors.primaryLightColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          'High security',
                          style: AppTextStyles.regular16.copyWith(
                            color: AppColors.bodyTextColor,
                          ),
                        ),
                ),
                Divider(),
                OptionItem(
                  title: Text(
                    'None',
                    style: AppTextStyles.medium22,
                  ),
                  subtitle: isCurrentLockType
                      ? RichText(
                          text: TextSpan(
                            text: 'Medium-high security, ',
                            style: AppTextStyles.regular16.copyWith(
                              color: AppColors.bodyTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: 'Current lock type',
                                style: AppTextStyles.regular16.copyWith(
                                  color: AppColors.primaryLightColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          'No security',
                          style: AppTextStyles.regular16.copyWith(
                            color: AppColors.bodyTextColor,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
