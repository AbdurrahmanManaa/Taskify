// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(length) => "المرفقات (${length})";

  static String m1(length) => "التصنيفات (${length})";

  static String m2(onString) => "كل شهر (${onString})";

  static String m3(interval, onString) =>
      "كل ${interval} شهر(شهور) (${onString})";

  static String m4(interval, days) => "كل ${interval} أسابيع في ${days}";

  static String m5(interval, onString) => "كل ${interval} سنة (${onString})";

  static String m6(unit) => "كل ${unit}";

  static String m7(interval, units) => "كل ${interval} ${units}";

  static String m8(days) => "كل أسبوع في ${days}";

  static String m9(onString) => "كل سنة ( ${onString})";

  static String m10(count) => "الملفات (${count})";

  static String m11(units) => "${units}";

  static String m12(lockType) => "${lockType} غير صحيح. حاول مرة أخرى.";

  static String m13(count) => "مرفقات وسائط (${count})";

  static String m14(day, suffix, monthName) =>
      "في اليوم ${day}${suffix} من شهر ${monthName}";

  static String m15(selectedInterval) =>
      "سوف يتكرر هذا كل ${selectedInterval} يوم(أيام)";

  static String m16(selectedInterval) =>
      "سوف يتكرر هذا كل ${selectedInterval} شهر(شهور)";

  static String m17(selectedInterval, selectedDays) =>
      "سوف يتكرر هذا كل ${selectedInterval} أسابيع في ${selectedDays}";

  static String m18(selectedInterval) =>
      "سوف يتكرر هذا كل ${selectedInterval} سنة(سنوات)";

  static String m19(selectedDays) =>
      "سوف يتكرر هذا كل أسبوع في ${selectedDays}";

  static String m20(value, units) => "${value} ${units} قبل";

  static String m21(length) => "المهام الفرعية (${length})";

  static String m22(count) => " (${count} مرات)";

  static String m23(untilDate) => ", حتى ${untilDate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "BadgeStyleSelectionOption1":
            MessageLookupByLibrary.simpleMessage("نقطة"),
        "BadgeStyleSelectionOption2":
            MessageLookupByLibrary.simpleMessage("رقم"),
        "LanguageSelectionOption1":
            MessageLookupByLibrary.simpleMessage("إنجليزي"),
        "LanguageSelectionOption2":
            MessageLookupByLibrary.simpleMessage("عربي"),
        "ThemeModeSelectionOption1":
            MessageLookupByLibrary.simpleMessage("النظام"),
        "ThemeModeSelectionOption2":
            MessageLookupByLibrary.simpleMessage("فاتحة"),
        "ThemeModeSelectionOption3":
            MessageLookupByLibrary.simpleMessage("مظلمة"),
        "aboveThressShort": MessageLookupByLibrary.simpleMessage("فوق الثالث"),
        "accountActionsSectionTitle":
            MessageLookupByLibrary.simpleMessage("الإجراءات على الحساب"),
        "accountSectionTitle": MessageLookupByLibrary.simpleMessage("الحساب"),
        "addAttachment": MessageLookupByLibrary.simpleMessage("إضافة مرفق"),
        "addCategoryLabel": MessageLookupByLibrary.simpleMessage("إضافة تصنيف"),
        "addFile": MessageLookupByLibrary.simpleMessage("إضافة ملف"),
        "addSubtaskButton":
            MessageLookupByLibrary.simpleMessage("إضافة مهمَّة فرعية"),
        "addTaskAppBar": MessageLookupByLibrary.simpleMessage("إضافة مهمَّة"),
        "alreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("لديك حساب بالفعل؟ "),
        "appFontsArchivo": MessageLookupByLibrary.simpleMessage("أرتشيفو"),
        "appFontsCairo": MessageLookupByLibrary.simpleMessage("القاهرة"),
        "appFontsCaveat": MessageLookupByLibrary.simpleMessage("كافييت"),
        "appFontsChanga": MessageLookupByLibrary.simpleMessage("تشانجا"),
        "appFontsElMessiri": MessageLookupByLibrary.simpleMessage("المسيري"),
        "appFontsIbmPlexSansArabic":
            MessageLookupByLibrary.simpleMessage("IBM Plex Sans العربي"),
        "appFontsInter": MessageLookupByLibrary.simpleMessage("إنتر"),
        "appFontsNotoKufiArabic":
            MessageLookupByLibrary.simpleMessage("نوتو كوفي العربي"),
        "appFontsOrbitron": MessageLookupByLibrary.simpleMessage("أوربترون"),
        "appFontsPlayfairDisplay":
            MessageLookupByLibrary.simpleMessage("بلايفير ديسبلاى"),
        "appIconBadgeStyleDot": MessageLookupByLibrary.simpleMessage("نقطة"),
        "appIconBadgeStyleNumber": MessageLookupByLibrary.simpleMessage("رقم"),
        "appLanguageArabic": MessageLookupByLibrary.simpleMessage("عربي"),
        "appLanguageEnglish": MessageLookupByLibrary.simpleMessage("إنجليزي"),
        "appLockAppBar": MessageLookupByLibrary.simpleMessage("قفل التطبيق"),
        "appLockOptionItem":
            MessageLookupByLibrary.simpleMessage("قفل التطبيق"),
        "appLockTypeNone": MessageLookupByLibrary.simpleMessage("لا شيء"),
        "appLockTypePassword":
            MessageLookupByLibrary.simpleMessage("كلمة مرور"),
        "appLockTypePin": MessageLookupByLibrary.simpleMessage("رمز PIN"),
        "appSchemeAmber": MessageLookupByLibrary.simpleMessage("كهرماني"),
        "appSchemeAquaBlue": MessageLookupByLibrary.simpleMessage("أزرق مائي"),
        "appSchemeBahamaBlue":
            MessageLookupByLibrary.simpleMessage("باهاما أزرق"),
        "appSchemeBarossa": MessageLookupByLibrary.simpleMessage("باروسا"),
        "appSchemeBigStone": MessageLookupByLibrary.simpleMessage("حجر كبير"),
        "appSchemeBlackWhite":
            MessageLookupByLibrary.simpleMessage("أسود & أبيض"),
        "appSchemeBlue": MessageLookupByLibrary.simpleMessage("أزرق"),
        "appSchemeBlueM3": MessageLookupByLibrary.simpleMessage("أزرق M3"),
        "appSchemeBlueWhale":
            MessageLookupByLibrary.simpleMessage("الحوت الأزرق"),
        "appSchemeBlumineBlue":
            MessageLookupByLibrary.simpleMessage("أزرق بلومين"),
        "appSchemeBrandBlue": MessageLookupByLibrary.simpleMessage("أزرق رسمي"),
        "appSchemeCyanM3": MessageLookupByLibrary.simpleMessage("سماوي M3"),
        "appSchemeDamask": MessageLookupByLibrary.simpleMessage("دمشقي"),
        "appSchemeDeepBlue": MessageLookupByLibrary.simpleMessage("أزرق عميق"),
        "appSchemeDeepOrangeM3":
            MessageLookupByLibrary.simpleMessage("برتقالي غامق M3"),
        "appSchemeDeepPurple":
            MessageLookupByLibrary.simpleMessage("بنفسجي غامق"),
        "appSchemeDellGenoa": MessageLookupByLibrary.simpleMessage("ديل جنوة"),
        "appSchemeEbonyClay":
            MessageLookupByLibrary.simpleMessage("فخار أبنوسي"),
        "appSchemeEspresso": MessageLookupByLibrary.simpleMessage("إسبرسو"),
        "appSchemeFlutterDash": MessageLookupByLibrary.simpleMessage("رفرفة"),
        "appSchemeGold": MessageLookupByLibrary.simpleMessage("ذهبي"),
        "appSchemeGreen": MessageLookupByLibrary.simpleMessage("أخضر"),
        "appSchemeGreenM3": MessageLookupByLibrary.simpleMessage("أخضر M3"),
        "appSchemeGreyLaw":
            MessageLookupByLibrary.simpleMessage("القانون الرمادي"),
        "appSchemeGreys":
            MessageLookupByLibrary.simpleMessage("تدرجات الرمادي"),
        "appSchemeHippieBlue":
            MessageLookupByLibrary.simpleMessage("أزرق محب الطبيعة"),
        "appSchemeIndigo": MessageLookupByLibrary.simpleMessage("نيلي"),
        "appSchemeIndigoM3": MessageLookupByLibrary.simpleMessage("نيلي M3"),
        "appSchemeJungle": MessageLookupByLibrary.simpleMessage("غابة"),
        "appSchemeLimeM3": MessageLookupByLibrary.simpleMessage("لايم M3"),
        "appSchemeMallardGreen":
            MessageLookupByLibrary.simpleMessage("اخضر مالارد"),
        "appSchemeMandyRed": MessageLookupByLibrary.simpleMessage("أحمر ماندي"),
        "appSchemeMango": MessageLookupByLibrary.simpleMessage(" مانجو"),
        "appSchemeMaterial": MessageLookupByLibrary.simpleMessage("مادة"),
        "appSchemeMaterialBaseline":
            MessageLookupByLibrary.simpleMessage("مادة أساسية"),
        "appSchemeMaterialHc":
            MessageLookupByLibrary.simpleMessage("مادة قوية"),
        "appSchemeMoney": MessageLookupByLibrary.simpleMessage("نقود"),
        "appSchemeOrangeM3": MessageLookupByLibrary.simpleMessage("برتقالي M3"),
        "appSchemeOuterSpace":
            MessageLookupByLibrary.simpleMessage("فضاء خارجي"),
        "appSchemePinkM3": MessageLookupByLibrary.simpleMessage("وردي M3"),
        "appSchemePurpleBrown":
            MessageLookupByLibrary.simpleMessage("بنفسجي بني"),
        "appSchemePurpleM3": MessageLookupByLibrary.simpleMessage("بنفسجي M3"),
        "appSchemeRed": MessageLookupByLibrary.simpleMessage("أحمر"),
        "appSchemeRedM3": MessageLookupByLibrary.simpleMessage("أحمر M3"),
        "appSchemeRedWine": MessageLookupByLibrary.simpleMessage("نبيذي"),
        "appSchemeRosewood": MessageLookupByLibrary.simpleMessage("خشب الورد"),
        "appSchemeSakura": MessageLookupByLibrary.simpleMessage("ساكورا"),
        "appSchemeSanJuanBlue":
            MessageLookupByLibrary.simpleMessage("سان خوان أزرق"),
        "appSchemeSepia": MessageLookupByLibrary.simpleMessage("بني محمر"),
        "appSchemeShadBlue": MessageLookupByLibrary.simpleMessage("ظل أزرق"),
        "appSchemeShadGray": MessageLookupByLibrary.simpleMessage("ظل رمادي"),
        "appSchemeShadGreen": MessageLookupByLibrary.simpleMessage("ظل أخضر"),
        "appSchemeShadNeutral":
            MessageLookupByLibrary.simpleMessage("ظل محايد"),
        "appSchemeShadOrange":
            MessageLookupByLibrary.simpleMessage("ظل برتقالي"),
        "appSchemeShadRed": MessageLookupByLibrary.simpleMessage("ظل أحمر"),
        "appSchemeShadRose": MessageLookupByLibrary.simpleMessage("ظل وردِي"),
        "appSchemeShadSlate":
            MessageLookupByLibrary.simpleMessage("ظل أردوازي"),
        "appSchemeShadStone": MessageLookupByLibrary.simpleMessage("ظل حجري"),
        "appSchemeShadViolet":
            MessageLookupByLibrary.simpleMessage("ظل أبنفسجي"),
        "appSchemeShadYellow": MessageLookupByLibrary.simpleMessage("ظل أصفر"),
        "appSchemeShadZinc": MessageLookupByLibrary.simpleMessage("ظل زنك"),
        "appSchemeShark": MessageLookupByLibrary.simpleMessage("قرش"),
        "appSchemeTealM3": MessageLookupByLibrary.simpleMessage("فيرزي M3"),
        "appSchemeVerdunHemlock":
            MessageLookupByLibrary.simpleMessage("فردون هيملوك"),
        "appSchemeVesuviusBurn":
            MessageLookupByLibrary.simpleMessage("بركان فيزوف"),
        "appSchemeWasabi": MessageLookupByLibrary.simpleMessage("واسابِي"),
        "appSchemeYellowM3": MessageLookupByLibrary.simpleMessage("أصفر M3"),
        "appThemeModeDark": MessageLookupByLibrary.simpleMessage("غامق"),
        "appThemeModeLight": MessageLookupByLibrary.simpleMessage("فاتح"),
        "appThemeModeSystem": MessageLookupByLibrary.simpleMessage("نظام"),
        "ascendingLabel": MessageLookupByLibrary.simpleMessage("تصاعدي"),
        "ascendingLowToHigh":
            MessageLookupByLibrary.simpleMessage("من الأقل إلى الأعلى"),
        "attachmentStatusPending":
            MessageLookupByLibrary.simpleMessage("قيد الانتظار"),
        "attachmentStatusUploaded":
            MessageLookupByLibrary.simpleMessage("تم التحمیل"),
        "attachments": MessageLookupByLibrary.simpleMessage("المرفقات"),
        "attachmentsLength": m0,
        "attachmentsTab": MessageLookupByLibrary.simpleMessage("المرفقات"),
        "autoLockAfter":
            MessageLookupByLibrary.simpleMessage("القفل التلقائي بعد"),
        "autoLockAfterImmediately":
            MessageLookupByLibrary.simpleMessage("فورًا"),
        "autoLockAfterSixtySec":
            MessageLookupByLibrary.simpleMessage("بعد 60 ثانية"),
        "autoLockAfterTenSec":
            MessageLookupByLibrary.simpleMessage("بعد 10 ثوانٍ"),
        "autoLockAfterThirtySec":
            MessageLookupByLibrary.simpleMessage("بعد 30 ثانية"),
        "badgeStyleOptionItem":
            MessageLookupByLibrary.simpleMessage("نمط الشارات"),
        "barChartTitle":
            MessageLookupByLibrary.simpleMessage("توزيع الأولويات"),
        "calenderAppBar": MessageLookupByLibrary.simpleMessage("التقويم"),
        "camera": MessageLookupByLibrary.simpleMessage("الكاميرا"),
        "cancelModalSheetButton": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "categories": MessageLookupByLibrary.simpleMessage("التصنيفات"),
        "categoriesFilter": MessageLookupByLibrary.simpleMessage("التصنيفات"),
        "categoriesLength": m1,
        "changePasswordOptionItem":
            MessageLookupByLibrary.simpleMessage("تغيير كلمة المرور"),
        "completedAt":
            MessageLookupByLibrary.simpleMessage("\\nتم الإنجاز في "),
        "confirmModalSheetButton":
            MessageLookupByLibrary.simpleMessage("تأكيد"),
        "confirmPasswordTextField":
            MessageLookupByLibrary.simpleMessage("تأكد من كلمة المرور"),
        "confirmPasswordTextFieldHint":
            MessageLookupByLibrary.simpleMessage("تأكد من كلمة المرور"),
        "connect": MessageLookupByLibrary.simpleMessage("اتصال"),
        "connectedAccountsAppBar":
            MessageLookupByLibrary.simpleMessage("الحسابات المرتبطة"),
        "connectedAccountsOptionItem":
            MessageLookupByLibrary.simpleMessage("الحسابات المتصلة"),
        "createAccount": MessageLookupByLibrary.simpleMessage("إنشاء حساب,"),
        "createSubtaskButton":
            MessageLookupByLibrary.simpleMessage("إنشاء مهمَّة فرعية"),
        "createTaskButton":
            MessageLookupByLibrary.simpleMessage("إنشاء مهمَّة"),
        "createdAt": MessageLookupByLibrary.simpleMessage("تم الإنشاء في "),
        "currentLockType":
            MessageLookupByLibrary.simpleMessage("نوع القفل الحالي"),
        "custom": MessageLookupByLibrary.simpleMessage("مخصص"),
        "daily": MessageLookupByLibrary.simpleMessage("يومي"),
        "day": MessageLookupByLibrary.simpleMessage(" يوم "),
        "days": MessageLookupByLibrary.simpleMessage("أيام"),
        "deleteAccountDialogDescription": MessageLookupByLibrary.simpleMessage(
            "هل تريد حذف الحساب بشكل دائم؟"),
        "deleteAccountDialogTitle":
            MessageLookupByLibrary.simpleMessage("حذف الحساب بشكل دائم"),
        "deleteAccountOptionItem":
            MessageLookupByLibrary.simpleMessage("حذف الحساب"),
        "deleteAttachmentAction": MessageLookupByLibrary.simpleMessage("حذف"),
        "deleteCategoryContent": MessageLookupByLibrary.simpleMessage(
            " هل أنت متأكد أنك تريد حذف هذا التصنيف بشكل نهائي؟"),
        "deleteCategoryTitle":
            MessageLookupByLibrary.simpleMessage("حذف التصنيف نهائياً"),
        "deleteModalSheetButton": MessageLookupByLibrary.simpleMessage("حذف"),
        "deleteSubtaskAction": MessageLookupByLibrary.simpleMessage("حذف"),
        "deleteSubtaskDialogDescription": MessageLookupByLibrary.simpleMessage(
            "هل تريد حذف هذه المهمة الفرعية؟"),
        "deleteSubtaskDialogTitle":
            MessageLookupByLibrary.simpleMessage("حذف المهمة الفرعية"),
        "deleteTaskAction": MessageLookupByLibrary.simpleMessage(""),
        "deleteTaskDialogDescription":
            MessageLookupByLibrary.simpleMessage("هل تريد حذف هذه المهمة؟"),
        "deleteTaskDialogTitle":
            MessageLookupByLibrary.simpleMessage("حذف المهمة"),
        "deletedAt": MessageLookupByLibrary.simpleMessage("\\nتم الحذف في "),
        "descendingHighToLow":
            MessageLookupByLibrary.simpleMessage("من الأعلى إلى الأقل"),
        "descendingLabel": MessageLookupByLibrary.simpleMessage("تنازلي"),
        "descriptionTextField": MessageLookupByLibrary.simpleMessage("الوصف"),
        "descriptionTextFieldHint":
            MessageLookupByLibrary.simpleMessage("أدخل الوصف"),
        "disconnect": MessageLookupByLibrary.simpleMessage("فصل"),
        "dontHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("لا تمتلك حساب؟ "),
        "download": MessageLookupByLibrary.simpleMessage("تحميل"),
        "downloadAttachmentAction":
            MessageLookupByLibrary.simpleMessage("تحميل"),
        "dueDateFilter":
            MessageLookupByLibrary.simpleMessage("تاريخ الاستحقاق"),
        "dueDateTextField":
            MessageLookupByLibrary.simpleMessage("تاريخ الاستحقاق"),
        "duration": MessageLookupByLibrary.simpleMessage("مدة"),
        "editEmailAppBar":
            MessageLookupByLibrary.simpleMessage("تعديل البريد الألكتروني"),
        "editFullNameAppBar":
            MessageLookupByLibrary.simpleMessage("تعديل الاسم الكامل"),
        "editPasswordAppBar":
            MessageLookupByLibrary.simpleMessage("تعديل كلمة المرور"),
        "editSubtaskAction": MessageLookupByLibrary.simpleMessage("تعديل"),
        "editTaskAction": MessageLookupByLibrary.simpleMessage("تعديل"),
        "editTaskAppBar": MessageLookupByLibrary.simpleMessage("تعديل المهمة"),
        "emailEditUser":
            MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
        "emailTextField":
            MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
        "emailTextFieldHint":
            MessageLookupByLibrary.simpleMessage("أدخل البريد الإلكتروني"),
        "endTimeTextField": MessageLookupByLibrary.simpleMessage("نهاية الوقت"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("أدخل كلمة المرور"),
        "enterYourPin": MessageLookupByLibrary.simpleMessage("أدخل رمز PIN"),
        "every": MessageLookupByLibrary.simpleMessage("كل "),
        "everyMonthOn": m2,
        "everyOtherMonthOn": m3,
        "everyOtherWeekOn": m4,
        "everyOtherYearOn": m5,
        "everySingle": m6,
        "everyString": m7,
        "everyWeekOn": m8,
        "everyYearOn": m9,
        "fiftyMB": MessageLookupByLibrary.simpleMessage("50 ميغابايت"),
        "fileAttachments": m10,
        "filters": MessageLookupByLibrary.simpleMessage("فلاتر"),
        "firstShort": MessageLookupByLibrary.simpleMessage("الأوّل"),
        "fontOptionItem": MessageLookupByLibrary.simpleMessage("نوع الخط"),
        "fontSelectionModalSheetDescription":
            MessageLookupByLibrary.simpleMessage(
                "سيتم تطبيق هذا الخط على جميع الشاشات"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور؟"),
        "forgotPasswordAppBar":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور"),
        "forgotPasswordBody": MessageLookupByLibrary.simpleMessage(
            "سيتم إرسال رابط لإعادة التعيين على البريد الإلكتروني"),
        "formattedUnitPlural": m11,
        "friday": MessageLookupByLibrary.simpleMessage("الجمعة"),
        "fridayShort": MessageLookupByLibrary.simpleMessage("جمعة"),
        "fullNameEditUser":
            MessageLookupByLibrary.simpleMessage("الاسم الكامل"),
        "fullNameTextField":
            MessageLookupByLibrary.simpleMessage("الإسم الكامل"),
        "fullNameTextFieldHint":
            MessageLookupByLibrary.simpleMessage("أدخل إسمك الكامل"),
        "gallery": MessageLookupByLibrary.simpleMessage("المعرض"),
        "getStarted": MessageLookupByLibrary.simpleMessage("ابدأ"),
        "highSecurity": MessageLookupByLibrary.simpleMessage("أمان عالٍ، "),
        "incorrectLockType": m12,
        "languageOptionItem": MessageLookupByLibrary.simpleMessage("اللغة"),
        "letsCreateAccountTogether":
            MessageLookupByLibrary.simpleMessage("هيا ننشئ حسابًا معًا"),
        "markAsComplete": MessageLookupByLibrary.simpleMessage("حدد كمكتمل"),
        "maximumCategoryLimit": MessageLookupByLibrary.simpleMessage(
            "وصلت إلى أقصى عدد للتصنيفات "),
        "mediaAttachments": m13,
        "mediumHighSecurity":
            MessageLookupByLibrary.simpleMessage("أمان متوسط-عالٍ، "),
        "memberSince": MessageLookupByLibrary.simpleMessage("عضو منذ"),
        "monday": MessageLookupByLibrary.simpleMessage("الإثنين"),
        "mondayShort": MessageLookupByLibrary.simpleMessage("إثن"),
        "month": MessageLookupByLibrary.simpleMessage("شهر"),
        "monthly": MessageLookupByLibrary.simpleMessage("شهري"),
        "months": MessageLookupByLibrary.simpleMessage("شهور"),
        "moveToTrash":
            MessageLookupByLibrary.simpleMessage("نقل الى سلة المحذوفات"),
        "newPassword":
            MessageLookupByLibrary.simpleMessage("كلمة المرور الجديدة"),
        "newPasswordTextFieldHint":
            MessageLookupByLibrary.simpleMessage("كلمة مرور جديدة"),
        "notConnected": MessageLookupByLibrary.simpleMessage("غير متصل"),
        "noteTextField": MessageLookupByLibrary.simpleMessage("ملاحظة"),
        "noteTextFieldHint":
            MessageLookupByLibrary.simpleMessage("أدخل ملاحظة"),
        "notificationsAppBar":
            MessageLookupByLibrary.simpleMessage("الإشعارات"),
        "notificationsOptionItem":
            MessageLookupByLibrary.simpleMessage("الإشعارات"),
        "okModalBottomSheet": MessageLookupByLibrary.simpleMessage("حسناً"),
        "onBoardingBody1": MessageLookupByLibrary.simpleMessage(
            "تأكد من تتبع إنجازاتك المهنية"),
        "onBoardingBody2": MessageLookupByLibrary.simpleMessage(
            "وفّر نظرة على مساهمات الزملاء ضمن الفرق والمؤسسات"),
        "onBoardingBody3": MessageLookupByLibrary.simpleMessage(
            " تحكم في التنبيهات وتعاون مباشرًا مع الفريق وفي التوقيت الذي تختاره"),
        "onBoardingTitle1":
            MessageLookupByLibrary.simpleMessage("تابع عملك واحصل على النتائج"),
        "onBoardingTitle2":
            MessageLookupByLibrary.simpleMessage("كن منظماً ضمن الفريق"),
        "onBoardingTitle3": MessageLookupByLibrary.simpleMessage(
            "احصل على تنبيه عند حدوث العمل"),
        "onString": m14,
        "once": MessageLookupByLibrary.simpleMessage(" (مرة واحدة)"),
        "or": MessageLookupByLibrary.simpleMessage("أو"),
        "passwordTextField":
            MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "passwordTextFieldHint":
            MessageLookupByLibrary.simpleMessage("أدخل كلمة المرور"),
        "pieChartTitle": MessageLookupByLibrary.simpleMessage("حالة المهام"),
        "predefinedCategoriesEducation":
            MessageLookupByLibrary.simpleMessage("التعليم"),
        "predefinedCategoriesFamily":
            MessageLookupByLibrary.simpleMessage("العائلة"),
        "predefinedCategoriesFinance":
            MessageLookupByLibrary.simpleMessage("الشؤون الماليَّة"),
        "predefinedCategoriesHealth":
            MessageLookupByLibrary.simpleMessage("الصحة"),
        "predefinedCategoriesPersonal":
            MessageLookupByLibrary.simpleMessage("الشخصية"),
        "predefinedCategoriesShopping":
            MessageLookupByLibrary.simpleMessage("التسوق"),
        "predefinedCategoriesWork":
            MessageLookupByLibrary.simpleMessage("العمل"),
        "preferencesSectionTitle":
            MessageLookupByLibrary.simpleMessage("التفضيلات"),
        "priorityFilter": MessageLookupByLibrary.simpleMessage("الأولوية"),
        "priorityTextField": MessageLookupByLibrary.simpleMessage("الأولوية"),
        "profileAppBar": MessageLookupByLibrary.simpleMessage("الملف الشخصِي"),
        "profileOptionItem":
            MessageLookupByLibrary.simpleMessage("الملف الشخصِي"),
        "profilePictureBottomSheet":
            MessageLookupByLibrary.simpleMessage("صورة الملف الشخصِي"),
        "reminderAppBar": MessageLookupByLibrary.simpleMessage("تذكير للمهمة"),
        "reminderOption1":
            MessageLookupByLibrary.simpleMessage("في وقت الفعالية"),
        "reminderOption2": MessageLookupByLibrary.simpleMessage("قبل 10 دقائق"),
        "reminderOption3": MessageLookupByLibrary.simpleMessage("قبل ساعة"),
        "reminderOption4": MessageLookupByLibrary.simpleMessage("قبل يوم واحد"),
        "reminderTextField": MessageLookupByLibrary.simpleMessage("تذكير"),
        "reminderUnit1": MessageLookupByLibrary.simpleMessage("دقائق"),
        "reminderUnit2": MessageLookupByLibrary.simpleMessage("ساعات"),
        "reminderUnit3": MessageLookupByLibrary.simpleMessage("أيام"),
        "reminderUnit4": MessageLookupByLibrary.simpleMessage("أسابيع"),
        "rename": MessageLookupByLibrary.simpleMessage("إعادة التسمية"),
        "renameAttachmentAction":
            MessageLookupByLibrary.simpleMessage("تغيير الاسم"),
        "repeatAppBar": MessageLookupByLibrary.simpleMessage("تكرار المهمَّة"),
        "repeatDescriptionDontRepeat":
            MessageLookupByLibrary.simpleMessage("لا يتكرر هذا التكرار"),
        "repeatDescriptionEveryMonth":
            MessageLookupByLibrary.simpleMessage("سوف يتكرر هذا كل شهر"),
        "repeatDescriptionEveryOtherDay": m15,
        "repeatDescriptionEveryOtherMonth": m16,
        "repeatDescriptionEveryOtherWeek": m17,
        "repeatDescriptionEveryOtherYear": m18,
        "repeatDescriptionEveryWeek": m19,
        "repeatDescriptionEveryYear":
            MessageLookupByLibrary.simpleMessage("سوف يتكرر هذا كل سنة"),
        "repeatDescriptionEveryday":
            MessageLookupByLibrary.simpleMessage("سوف يتكرر هذا كل يوم"),
        "repeatDuration1": MessageLookupByLibrary.simpleMessage("بلا حدود"),
        "repeatDuration2":
            MessageLookupByLibrary.simpleMessage("عدد معين من التكرارات"),
        "repeatDuration3": MessageLookupByLibrary.simpleMessage("حتى"),
        "repeatOption1": MessageLookupByLibrary.simpleMessage("بدون تكرار"),
        "repeatOption2": MessageLookupByLibrary.simpleMessage(" يومياً"),
        "repeatOption3": MessageLookupByLibrary.simpleMessage("كل أسبوع"),
        "repeatOption4": MessageLookupByLibrary.simpleMessage("كل شهر"),
        "repeatOption5": MessageLookupByLibrary.simpleMessage("كل سنة"),
        "repeatTextField": MessageLookupByLibrary.simpleMessage("تكرار"),
        "reschedule": MessageLookupByLibrary.simpleMessage("اعادة جدولة"),
        "rescheduleTask":
            MessageLookupByLibrary.simpleMessage("اعادة جدولة المهمة"),
        "resetModalSheetButton":
            MessageLookupByLibrary.simpleMessage("إعادة التعيين"),
        "resetPasswordAppBar":
            MessageLookupByLibrary.simpleMessage("إعادة تعيين كلمة المرور"),
        "resetPasswordBody": MessageLookupByLibrary.simpleMessage(
            "ينبغي أن تكون كلمة المرور مختلفة عن السابقة"),
        "resetPasswordButton":
            MessageLookupByLibrary.simpleMessage("إعادة التعيين"),
        "restoreTaskAction": MessageLookupByLibrary.simpleMessage("استعادة"),
        "saturday": MessageLookupByLibrary.simpleMessage("السبت"),
        "saturdayShort": MessageLookupByLibrary.simpleMessage("سبت"),
        "schemeColorOptionItem":
            MessageLookupByLibrary.simpleMessage("ألوان الواجهة"),
        "searchBarPlaceholder":
            MessageLookupByLibrary.simpleMessage("ماذا تبحث عنه؟"),
        "secondShort": MessageLookupByLibrary.simpleMessage("الثاني"),
        "securitySectionTitle": MessageLookupByLibrary.simpleMessage("الأ مان"),
        "selectedSortField":
            MessageLookupByLibrary.simpleMessage("تاريخ الاستحقاق"),
        "selectedTaskReminder": m20,
        "sendButton": MessageLookupByLibrary.simpleMessage("إرسال"),
        "settingsAppBar": MessageLookupByLibrary.simpleMessage("الاعدادات"),
        "shareText": MessageLookupByLibrary.simpleMessage("هذه هي الإحصائيات!"),
        "showBadgeSelectionModalSheetTitle":
            MessageLookupByLibrary.simpleMessage("نمط شارة التطبيق"),
        "showFontSelectionModalSheetTitle":
            MessageLookupByLibrary.simpleMessage("خط التطبيق"),
        "showLanguageSelectionModalSheetTitle":
            MessageLookupByLibrary.simpleMessage("لغة التطبيق"),
        "showPrioritySelectionModalSheetTitle":
            MessageLookupByLibrary.simpleMessage("اختر الأولويات"),
        "showSchemeColorSelectionModalSheetTitle":
            MessageLookupByLibrary.simpleMessage("لون المخطط"),
        "showThemeModeSelectionModalSheetTitle":
            MessageLookupByLibrary.simpleMessage("سمة التطبيق"),
        "signInButton": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "signInRedirect": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "signInToYourAccount":
            MessageLookupByLibrary.simpleMessage("سجل الدخول إلى حسابك"),
        "signInWithGoogle":
            MessageLookupByLibrary.simpleMessage("تسجيل الدخول عبر جوجل"),
        "signOutDialogDescription":
            MessageLookupByLibrary.simpleMessage("هل تريد تسجيل الخروج؟"),
        "signOutDialogTitle":
            MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
        "signOutOptionItem":
            MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
        "signUpButton": MessageLookupByLibrary.simpleMessage("انشاء حساب"),
        "signUpRedirect": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
        "skip": MessageLookupByLibrary.simpleMessage("تخطى"),
        "sortBy": MessageLookupByLibrary.simpleMessage("ترتيب حسب"),
        "sortByLabel1": MessageLookupByLibrary.simpleMessage("تاريخ الاستحقاق"),
        "sortByLabel2": MessageLookupByLibrary.simpleMessage("الاولوية"),
        "sortByLabel3": MessageLookupByLibrary.simpleMessage("الأبجدية"),
        "startTimeTextField":
            MessageLookupByLibrary.simpleMessage("بداية الوقت"),
        "statisticsAppBar": MessageLookupByLibrary.simpleMessage("الإحصائيات"),
        "statusFilter": MessageLookupByLibrary.simpleMessage("الحالة"),
        "subtaskStatusCompleted": MessageLookupByLibrary.simpleMessage("مكتمل"),
        "subtaskStatusInProgress":
            MessageLookupByLibrary.simpleMessage("قيد التنفيذ"),
        "subtasks": MessageLookupByLibrary.simpleMessage("المهام الفرعية"),
        "subtasksLength": m21,
        "subtasksTab": MessageLookupByLibrary.simpleMessage("المهام الفرعية"),
        "sunday": MessageLookupByLibrary.simpleMessage("الأحد"),
        "sundayShort": MessageLookupByLibrary.simpleMessage("حد"),
        "tabAll": MessageLookupByLibrary.simpleMessage("الكل"),
        "tabCompleted": MessageLookupByLibrary.simpleMessage("مكتمل"),
        "tabOverdue": MessageLookupByLibrary.simpleMessage("متأخر"),
        "tabToday": MessageLookupByLibrary.simpleMessage("اليوم"),
        "tabTomorrow": MessageLookupByLibrary.simpleMessage("غدًا"),
        "tabUpcoming": MessageLookupByLibrary.simpleMessage("القادمة"),
        "taskDescription": MessageLookupByLibrary.simpleMessage("الوصف"),
        "taskDetails": MessageLookupByLibrary.simpleMessage("تفاصيل المهمة"),
        "taskDueDate": MessageLookupByLibrary.simpleMessage("تاريخ الاستحقاق"),
        "taskDueTime": MessageLookupByLibrary.simpleMessage("وقت الاستحقاق"),
        "taskPriorityHigh": MessageLookupByLibrary.simpleMessage("عالٍ"),
        "taskPriorityLow": MessageLookupByLibrary.simpleMessage("منخفض"),
        "taskPriorityMedium": MessageLookupByLibrary.simpleMessage("متوسط"),
        "taskReminder": MessageLookupByLibrary.simpleMessage("التذكير"),
        "taskRepeat": MessageLookupByLibrary.simpleMessage("التكرار"),
        "taskStatus": MessageLookupByLibrary.simpleMessage("الحالة"),
        "taskStatusCompleted": MessageLookupByLibrary.simpleMessage("مكتمل"),
        "taskStatusInProgress":
            MessageLookupByLibrary.simpleMessage("قيد التنفيذ"),
        "taskStatusOverdue": MessageLookupByLibrary.simpleMessage("متأخر"),
        "taskStatusTrash": MessageLookupByLibrary.simpleMessage("سلة محذوفات"),
        "taskTags": MessageLookupByLibrary.simpleMessage("الوسوم"),
        "taskTitle": MessageLookupByLibrary.simpleMessage("العنوان"),
        "tempSortFieldAlphabet":
            MessageLookupByLibrary.simpleMessage("الأبجدية"),
        "tempSortFieldDueDate":
            MessageLookupByLibrary.simpleMessage("تاريخ الاستحقاق"),
        "tempSortFieldPriority":
            MessageLookupByLibrary.simpleMessage("الاولوية"),
        "themeModeOptionItem":
            MessageLookupByLibrary.simpleMessage("نمط الواجهة"),
        "thirdShort": MessageLookupByLibrary.simpleMessage("الثالث"),
        "thisMonthFilter": MessageLookupByLibrary.simpleMessage("هذا الشهر"),
        "thisWeekFilter": MessageLookupByLibrary.simpleMessage("هذا الأسبوع"),
        "thisYearFilter": MessageLookupByLibrary.simpleMessage("هذه السنة"),
        "thursday": MessageLookupByLibrary.simpleMessage("الخميس"),
        "thursdayShort": MessageLookupByLibrary.simpleMessage("خميس"),
        "timeTotal": MessageLookupByLibrary.simpleMessage("الإجمالي الزمني"),
        "times": m22,
        "timesTotal": MessageLookupByLibrary.simpleMessage("الإجمالي التكراري"),
        "timezone": MessageLookupByLibrary.simpleMessage("التوقيت الزمني"),
        "titleTextField": MessageLookupByLibrary.simpleMessage("عنوان"),
        "titleTextFieldHint":
            MessageLookupByLibrary.simpleMessage("أدخل عنوانًا"),
        "todayFilter": MessageLookupByLibrary.simpleMessage("اليوم"),
        "todoList": MessageLookupByLibrary.simpleMessage("قائمة المهام"),
        "tomorrowFilter": MessageLookupByLibrary.simpleMessage("غدًا"),
        "tooManyAttempts": MessageLookupByLibrary.simpleMessage(
            " محاولات كثيرة جداً. يرجى الانتظار..."),
        "totalTasks": MessageLookupByLibrary.simpleMessage("مجموع المهام"),
        "trashAppBar": MessageLookupByLibrary.simpleMessage("سلة المهملات"),
        "trashBody": MessageLookupByLibrary.simpleMessage(
            "سيتم حذف المهام في سلة المهملات بشكل نهائي بعد 30 يومًا"),
        "tuesday": MessageLookupByLibrary.simpleMessage("الثلاثاء"),
        "tuesdayShort": MessageLookupByLibrary.simpleMessage("ثلاث"),
        "uncategorized": MessageLookupByLibrary.simpleMessage("غير مصنفة"),
        "unlock": MessageLookupByLibrary.simpleMessage("فتح"),
        "until": m23,
        "updateSubtaskButton":
            MessageLookupByLibrary.simpleMessage("تعديل مهمَّة فرعية"),
        "uploadFileSizeLimit":
            MessageLookupByLibrary.simpleMessage("حد التحمیل الأقصى: "),
        "uploadFilesContainer":
            MessageLookupByLibrary.simpleMessage("رفع الملفات"),
        "wednesday": MessageLookupByLibrary.simpleMessage("الأربعاء"),
        "wednesdayShort": MessageLookupByLibrary.simpleMessage("أربع"),
        "week": MessageLookupByLibrary.simpleMessage("أسبوع"),
        "weekly": MessageLookupByLibrary.simpleMessage("اسبوعي"),
        "weeks": MessageLookupByLibrary.simpleMessage("أسابيع"),
        "welcomeBackHomeView":
            MessageLookupByLibrary.simpleMessage("مرحبًا بعودتك!"),
        "welcomeBackSignInView":
            MessageLookupByLibrary.simpleMessage("مرحبًا بعودتك،"),
        "year": MessageLookupByLibrary.simpleMessage("سنة"),
        "years": MessageLookupByLibrary.simpleMessage("سنوات")
      };
}
