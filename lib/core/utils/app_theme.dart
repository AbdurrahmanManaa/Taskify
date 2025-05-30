import 'package:flutter/material.dart';
import 'package:taskify/core/functions/build_border.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.scaffoldLightBackgroundColor,
    fontFamily: 'Poppins',
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerColor,
      thickness: 1.5,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primaryLightColor),
        iconColor: WidgetStateProperty.all(Colors.white),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primaryLightColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(double.infinity, 54),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        elevation: WidgetStateProperty.all(0),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.inputDecorationLightFillColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.scaffoldLightBackgroundColor,
      labelTextStyle: WidgetStatePropertyAll(
        AppTextStyles.regular16.copyWith(color: Colors.black),
      ),
      elevation: 5,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(15),
      suffixIconColor: AppColors.greyColor,
      prefixIconColor: AppColors.greyColor,
      hintStyle: AppTextStyles.regular17.copyWith(color: AppColors.greyColor),
      errorStyle: AppTextStyles.regular14.copyWith(color: AppColors.errorColor),
      filled: true,
      fillColor: AppColors.inputDecorationLightFillColor,
      border: buildBorder(),
      enabledBorder: buildBorder(),
      focusedBorder: buildBorder(Colors.blue),
      errorBorder: buildBorder(AppColors.errorColor),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return AppColors.primaryLightColor;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryLightColor;
        }
        return Colors.white;
      }),
      trackOutlineColor: WidgetStateProperty.all(AppColors.primaryLightColor),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryLightColor;
        }
        return Colors.grey;
      }),
      overlayColor: WidgetStateProperty.all(
        AppColors.primaryLightColor.withAlpha(26),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.scaffoldDarkBackgroundColor,
    fontFamily: 'Poppins',
    dividerTheme: const DividerThemeData(
      color: Colors.white,
      thickness: 1,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primaryDarkColor),
        iconColor:
            WidgetStateProperty.all(AppColors.scaffoldDarkBackgroundColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primaryDarkColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(double.infinity, 54),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        elevation: WidgetStateProperty.all(0),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.inputDecorationDarkFillColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.scaffoldDarkBackgroundColor,
      labelTextStyle: WidgetStatePropertyAll(
        AppTextStyles.regular16.copyWith(color: Colors.black),
      ),
      elevation: 5,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(15),
      suffixIconColor: AppColors.greyColor,
      prefixIconColor: AppColors.greyColor,
      hintStyle: AppTextStyles.regular17.copyWith(color: AppColors.greyColor),
      errorStyle: AppTextStyles.regular14.copyWith(color: AppColors.errorColor),
      filled: true,
      fillColor: AppColors.inputDecorationDarkFillColor,
      border: buildBorder(),
      enabledBorder: buildBorder(),
      focusedBorder: buildBorder(Colors.blue),
      errorBorder: buildBorder(AppColors.errorColor),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return AppColors.primaryDarkColor;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryDarkColor;
        }
        return Colors.white;
      }),
      trackOutlineColor: WidgetStateProperty.all(AppColors.primaryDarkColor),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryDarkColor;
        }
        return Colors.grey;
      }),
      overlayColor: WidgetStateProperty.all(
        AppColors.primaryDarkColor.withAlpha(26),
      ),
    ),
  );
}
