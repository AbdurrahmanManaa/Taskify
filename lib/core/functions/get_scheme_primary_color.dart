import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:taskify/core/extensions/user_preferences_extension.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_scheme.dart';

Color getSchemePrimaryColor(
  BuildContext context,
  AppScheme scheme,
) {
  final schemeData = FlexColor.schemes[scheme.flexScheme]!;
  final brightness = Theme.of(context).brightness;

  return brightness == Brightness.dark
      ? schemeData.dark.primary
      : schemeData.light.primary;
}
