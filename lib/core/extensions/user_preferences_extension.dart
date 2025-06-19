import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_fonts.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_scheme.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_theme_mode.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_language.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_icon_badge_style.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_lock_type.dart';
import 'package:taskify/features/home/domain/entities/preferences/auto_lock_after.dart';
import 'package:taskify/generated/l10n.dart';

extension AppThemeModeX on AppThemeMode {
  String label(BuildContext context) {
    switch (this) {
      case AppThemeMode.light:
        return S.of(context).appThemeModeLight;
      case AppThemeMode.dark:
        return S.of(context).appThemeModeDark;
      case AppThemeMode.system:
        return S.of(context).appThemeModeSystem;
    }
  }
}

extension AppLanguageX on AppLanguage {
  String label(BuildContext context) {
    switch (this) {
      case AppLanguage.english:
        return S.of(context).appLanguageEnglish;
      case AppLanguage.arabic:
        return S.of(context).appLanguageArabic;
    }
  }
}

extension AppIconBadgeStyleX on AppIconBadgeStyle {
  String label(BuildContext context) {
    switch (this) {
      case AppIconBadgeStyle.number:
        return S.of(context).appIconBadgeStyleNumber;
      case AppIconBadgeStyle.dot:
        return S.of(context).appIconBadgeStyleDot;
    }
  }
}

extension AppLockTypeX on AppLockType {
  String label(BuildContext context) {
    switch (this) {
      case AppLockType.none:
        return S.of(context).appLockTypeNone;
      case AppLockType.pin:
        return S.of(context).appLockTypePin;
      case AppLockType.password:
        return S.of(context).appLockTypePassword;
    }
  }
}

extension AutoLockAfterX on AutoLockAfter {
  String label(BuildContext context) {
    switch (this) {
      case AutoLockAfter.immediately:
        return S.of(context).autoLockAfterImmediately;
      case AutoLockAfter.tenSeconds:
        return S.of(context).autoLockAfterTenSec;
      case AutoLockAfter.thirtySeconds:
        return S.of(context).autoLockAfterThirtySec;
      case AutoLockAfter.sixtySeconds:
        return S.of(context).autoLockAfterSixtySec;
    }
  }

  Duration get duration {
    switch (this) {
      case AutoLockAfter.immediately:
        return Duration.zero;
      case AutoLockAfter.tenSeconds:
        return const Duration(seconds: 10);
      case AutoLockAfter.thirtySeconds:
        return const Duration(seconds: 30);
      case AutoLockAfter.sixtySeconds:
        return const Duration(seconds: 60);
    }
  }
}

extension AppSchemeX on AppScheme {
  String label(BuildContext context) {
    switch (this) {
      case AppScheme.material:
        return S.of(context).appSchemeMaterial;
      case AppScheme.materialHc:
        return S.of(context).appSchemeMaterialHc;
      case AppScheme.blue:
        return S.of(context).appSchemeBlue;
      case AppScheme.indigo:
        return S.of(context).appSchemeIndigo;
      case AppScheme.hippieBlue:
        return S.of(context).appSchemeHippieBlue;
      case AppScheme.aquaBlue:
        return S.of(context).appSchemeAquaBlue;
      case AppScheme.brandBlue:
        return S.of(context).appSchemeBrandBlue;
      case AppScheme.deepBlue:
        return S.of(context).appSchemeDeepBlue;
      case AppScheme.sakura:
        return S.of(context).appSchemeSakura;
      case AppScheme.mandyRed:
        return S.of(context).appSchemeMandyRed;
      case AppScheme.red:
        return S.of(context).appSchemeRed;
      case AppScheme.redWine:
        return S.of(context).appSchemeRedWine;
      case AppScheme.purpleBrown:
        return S.of(context).appSchemePurpleBrown;
      case AppScheme.green:
        return S.of(context).appSchemeGreen;
      case AppScheme.money:
        return S.of(context).appSchemeMoney;
      case AppScheme.jungle:
        return S.of(context).appSchemeJungle;
      case AppScheme.greyLaw:
        return S.of(context).appSchemeGreyLaw;
      case AppScheme.wasabi:
        return S.of(context).appSchemeWasabi;
      case AppScheme.gold:
        return S.of(context).appSchemeGold;
      case AppScheme.mango:
        return S.of(context).appSchemeMango;
      case AppScheme.amber:
        return S.of(context).appSchemeAmber;
      case AppScheme.vesuviusBurn:
        return S.of(context).appSchemeVesuviusBurn;
      case AppScheme.deepPurple:
        return S.of(context).appSchemeDeepPurple;
      case AppScheme.ebonyClay:
        return S.of(context).appSchemeEbonyClay;
      case AppScheme.barossa:
        return S.of(context).appSchemeBarossa;
      case AppScheme.shark:
        return S.of(context).appSchemeShark;
      case AppScheme.bigStone:
        return S.of(context).appSchemeBigStone;
      case AppScheme.damask:
        return S.of(context).appSchemeDamask;
      case AppScheme.bahamaBlue:
        return S.of(context).appSchemeBahamaBlue;
      case AppScheme.mallardGreen:
        return S.of(context).appSchemeMallardGreen;
      case AppScheme.espresso:
        return S.of(context).appSchemeEspresso;
      case AppScheme.outerSpace:
        return S.of(context).appSchemeOuterSpace;
      case AppScheme.blueWhale:
        return S.of(context).appSchemeBlueWhale;
      case AppScheme.sanJuanBlue:
        return S.of(context).appSchemeSanJuanBlue;
      case AppScheme.rosewood:
        return S.of(context).appSchemeRosewood;
      case AppScheme.blumineBlue:
        return S.of(context).appSchemeBlumineBlue;
      case AppScheme.flutterDash:
        return S.of(context).appSchemeFlutterDash;
      case AppScheme.materialBaseline:
        return S.of(context).appSchemeMaterialBaseline;
      case AppScheme.verdunHemlock:
        return S.of(context).appSchemeVerdunHemlock;
      case AppScheme.dellGenoa:
        return S.of(context).appSchemeDellGenoa;
      case AppScheme.redM3:
        return S.of(context).appSchemeRedM3;
      case AppScheme.pinkM3:
        return S.of(context).appSchemePinkM3;
      case AppScheme.purpleM3:
        return S.of(context).appSchemePurpleM3;
      case AppScheme.indigoM3:
        return S.of(context).appSchemeIndigoM3;
      case AppScheme.blueM3:
        return S.of(context).appSchemeBlueM3;
      case AppScheme.cyanM3:
        return S.of(context).appSchemeCyanM3;
      case AppScheme.tealM3:
        return S.of(context).appSchemeTealM3;
      case AppScheme.greenM3:
        return S.of(context).appSchemeGreenM3;
      case AppScheme.limeM3:
        return S.of(context).appSchemeLimeM3;
      case AppScheme.yellowM3:
        return S.of(context).appSchemeYellowM3;
      case AppScheme.orangeM3:
        return S.of(context).appSchemeOrangeM3;
      case AppScheme.deepOrangeM3:
        return S.of(context).appSchemeDeepOrangeM3;
      case AppScheme.blackWhite:
        return S.of(context).appSchemeBlackWhite;
      case AppScheme.greys:
        return S.of(context).appSchemeGreys;
      case AppScheme.sepia:
        return S.of(context).appSchemeSepia;
      case AppScheme.shadBlue:
        return S.of(context).appSchemeShadBlue;
      case AppScheme.shadGray:
        return S.of(context).appSchemeShadGray;
      case AppScheme.shadGreen:
        return S.of(context).appSchemeShadGreen;
      case AppScheme.shadNeutral:
        return S.of(context).appSchemeShadNeutral;
      case AppScheme.shadOrange:
        return S.of(context).appSchemeShadOrange;
      case AppScheme.shadRed:
        return S.of(context).appSchemeShadRed;
      case AppScheme.shadRose:
        return S.of(context).appSchemeShadRose;
      case AppScheme.shadSlate:
        return S.of(context).appSchemeShadSlate;
      case AppScheme.shadStone:
        return S.of(context).appSchemeShadStone;
      case AppScheme.shadViolet:
        return S.of(context).appSchemeShadViolet;
      case AppScheme.shadYellow:
        return S.of(context).appSchemeShadYellow;
      case AppScheme.shadZinc:
        return S.of(context).appSchemeShadZinc;
    }
  }

  FlexScheme get flexScheme => FlexScheme.values[index];
}

extension AppFontsX on AppFonts {
  String label(BuildContext context) {
    switch (this) {
      case AppFonts.inter:
        return S.of(context).appFontsInter;
      case AppFonts.orbitron:
        return S.of(context).appFontsOrbitron;
      case AppFonts.archivo:
        return S.of(context).appFontsArchivo;
      case AppFonts.playfairDisplay:
        return S.of(context).appFontsPlayfairDisplay;
      case AppFonts.caveat:
        return S.of(context).appFontsCaveat;
      case AppFonts.cairo:
        return S.of(context).appFontsCairo;
      case AppFonts.changa:
        return S.of(context).appFontsChanga;
      case AppFonts.elMessiri:
        return S.of(context).appFontsElMessiri;
      case AppFonts.ibmPlexSansArabic:
        return S.of(context).appFontsIbmPlexSansArabic;
      case AppFonts.notoKufiArabic:
        return S.of(context).appFontsNotoKufiArabic;
    }
  }

  bool get isArabic {
    return this == AppFonts.cairo ||
        this == AppFonts.changa ||
        this == AppFonts.elMessiri ||
        this == AppFonts.ibmPlexSansArabic ||
        this == AppFonts.notoKufiArabic;
  }
}
