import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:taskify/core/functions/show_language_selection_modal_sheet.dart';
import 'package:taskify/core/functions/show_theme_mode_selection_modal_sheet.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/generated/l10n.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) async {
    final prefs = HiveService.preferencesNotifier.value;
    await HiveService().setUserPreferences(
      prefs.copyWith(isOnboardingSeen: true),
    );
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.signIn, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final bodyStyle =
        AppTextStyles.regular18.copyWith(color: AppColors.greyColor);

    final pageDecoration = PageDecoration(
      pageMargin: const EdgeInsets.only(top: 60),
      contentMargin: const EdgeInsets.only(top: 60),
      titleTextStyle: AppTextStyles.semiBold24,
      bodyTextStyle: bodyStyle,
      titlePadding: const EdgeInsets.only(
        bottom: 30,
        left: 16,
        right: 16,
      ),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 16),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: _introKey,
      scrollPhysics: BouncingScrollPhysics(),
      globalHeader: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            IconButton(
              onPressed: () async {
                await showThemeModeSelectionModalSheet(context);
              },
              icon: Icon(Icons.dark_mode),
            ),
            IconButton(
              onPressed: () async {
                await showLanguageSelectionModalSheet(context);
              },
              icon: Icon(Icons.language),
            ),
          ],
        ),
      ),
      pages: [
        PageViewModel(
          title: S.of(context).onBoardingTitle1,
          body: S.of(context).onBoardingBody1,
          image: Image.asset(AppAssets.imagesOnBoarding1),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: S.of(context).onBoardingTitle2,
          body: S.of(context).onBoardingBody2,
          image: Image.asset(AppAssets.imagesOnBoarding2),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: S.of(context).onBoardingTitle3,
          body: S.of(context).onBoardingBody3,
          image: Image.asset(AppAssets.imagesOnBoarding3),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skipOrBackFlex: 0,
      animationDuration: 300,
      nextFlex: 0,
      showBackButton: false,
      skip: Text(
        S.of(context).skip,
        style: AppTextStyles.semiBold20
            .copyWith(color: AppColors.primaryLightColor),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: AppColors.primaryLightColor,
        size: 30,
      ),
      done: Text(
        S.of(context).getStarted,
        style: AppTextStyles.semiBold20
            .copyWith(color: AppColors.primaryLightColor),
      ),
      curve: Curves.easeInOut,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10, 10),
        activeColor: AppColors.primaryLightColor,
        color: AppColors.inActiveColor,
        activeSize: Size(30, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
