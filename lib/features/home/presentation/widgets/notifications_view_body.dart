import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/generated/l10n.dart';

class NotificationsViewBody extends StatelessWidget {
  const NotificationsViewBody({super.key});

  Column _emptyNotificationsPlaceholder() {
    return Column(
      children: [
        Lottie.asset(
          AppAssets.animationsEmpty,
          filterQuality: FilterQuality.high,
          frameRate: FrameRate(120),
        ),
        Text(
          'It\'s empty here, add some tasks to get notifications',
          style: AppTextStyles.regular16.copyWith(color: AppColors.greyColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomAppbar(title: S.of(context).notificationsAppBar),
            _emptyNotificationsPlaceholder(),
          ],
        ),
      ),
    );
  }
}
