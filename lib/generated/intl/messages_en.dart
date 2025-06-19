// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(length) => "Attachments (${length})";

  static String m1(length) => "Categories (${length})";

  static String m2(onString) => "Every month (${onString})";

  static String m3(interval, onString) =>
      "Every ${interval} months (${onString})";

  static String m4(interval, days) => "Every ${interval} weeks on ${days}";

  static String m5(interval, onString) =>
      "Every ${interval} years (${onString})";

  static String m6(unit) => "Every ${unit}";

  static String m7(interval, units) => "Every ${interval} ${units}";

  static String m8(days) => "Every week on ${days}";

  static String m9(onString) => "Every year (${onString})";

  static String m10(count) => "Files (${count})";

  static String m11(units) => "${units}";

  static String m12(lockType) => "Incorrect ${lockType}. Try again.";

  static String m13(count) => "Media (${count})";

  static String m14(day, suffix, monthName) =>
      "On the ${day}${suffix} of ${monthName}";

  static String m15(selectedInterval) =>
      "This event will repeat every ${selectedInterval} day(s)";

  static String m16(selectedInterval) =>
      "This event will repeat every ${selectedInterval} month(s)";

  static String m17(selectedInterval, selectedDays) =>
      "This event will repeat every ${selectedInterval} week(s) on ${selectedDays}";

  static String m18(selectedInterval) =>
      "This event will repeat every ${selectedInterval} year(s)";

  static String m19(selectedDays) =>
      "This event will repeat every week on ${selectedDays}";

  static String m20(value, units) => "${value} ${units} before";

  static String m21(length) => "Subtasks (${length})";

  static String m22(count) => " (${count} times)";

  static String m23(untilDate) => ", Until ${untilDate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "BadgeStyleSelectionOption1":
            MessageLookupByLibrary.simpleMessage("Dot"),
        "BadgeStyleSelectionOption2":
            MessageLookupByLibrary.simpleMessage("Number"),
        "LanguageSelectionOption1":
            MessageLookupByLibrary.simpleMessage("English"),
        "LanguageSelectionOption2":
            MessageLookupByLibrary.simpleMessage("Arabic"),
        "ThemeModeSelectionOption1":
            MessageLookupByLibrary.simpleMessage("System"),
        "ThemeModeSelectionOption2":
            MessageLookupByLibrary.simpleMessage("Light"),
        "ThemeModeSelectionOption3":
            MessageLookupByLibrary.simpleMessage("Dark"),
        "aboveThressShort": MessageLookupByLibrary.simpleMessage("th"),
        "accountActionsSectionTitle":
            MessageLookupByLibrary.simpleMessage("Account Actions"),
        "accountSectionTitle": MessageLookupByLibrary.simpleMessage("Account"),
        "addAttachment": MessageLookupByLibrary.simpleMessage("Add Attachment"),
        "addCategoryLabel":
            MessageLookupByLibrary.simpleMessage("Add Category"),
        "addFile": MessageLookupByLibrary.simpleMessage("Add File"),
        "addSubtaskButton": MessageLookupByLibrary.simpleMessage("Add Subtask"),
        "addTaskAppBar": MessageLookupByLibrary.simpleMessage("Add Task"),
        "alreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account? "),
        "appFontsArchivo": MessageLookupByLibrary.simpleMessage("Archivo"),
        "appFontsCairo": MessageLookupByLibrary.simpleMessage("Cairo"),
        "appFontsCaveat": MessageLookupByLibrary.simpleMessage("Caveat"),
        "appFontsChanga": MessageLookupByLibrary.simpleMessage("Changa"),
        "appFontsElMessiri": MessageLookupByLibrary.simpleMessage("El Messiri"),
        "appFontsIbmPlexSansArabic":
            MessageLookupByLibrary.simpleMessage("IBM Plex Sans Arabic"),
        "appFontsInter": MessageLookupByLibrary.simpleMessage("Inter"),
        "appFontsNotoKufiArabic":
            MessageLookupByLibrary.simpleMessage("Noto Kufi Arabic"),
        "appFontsOrbitron": MessageLookupByLibrary.simpleMessage("Orbitron"),
        "appFontsPlayfairDisplay":
            MessageLookupByLibrary.simpleMessage("Playfair Display"),
        "appIconBadgeStyleDot": MessageLookupByLibrary.simpleMessage("Dot"),
        "appIconBadgeStyleNumber":
            MessageLookupByLibrary.simpleMessage("Number"),
        "appLanguageArabic": MessageLookupByLibrary.simpleMessage("Arabic"),
        "appLanguageEnglish": MessageLookupByLibrary.simpleMessage("English"),
        "appLockAppBar": MessageLookupByLibrary.simpleMessage("App Lock"),
        "appLockOptionItem": MessageLookupByLibrary.simpleMessage("App Lock"),
        "appLockTypeNone": MessageLookupByLibrary.simpleMessage("None"),
        "appLockTypePassword": MessageLookupByLibrary.simpleMessage("Password"),
        "appLockTypePin": MessageLookupByLibrary.simpleMessage("PIN"),
        "appSchemeAmber": MessageLookupByLibrary.simpleMessage("Amber"),
        "appSchemeAquaBlue": MessageLookupByLibrary.simpleMessage("Aqua Blue"),
        "appSchemeBahamaBlue":
            MessageLookupByLibrary.simpleMessage("Bahama Blue"),
        "appSchemeBarossa": MessageLookupByLibrary.simpleMessage("Barossa"),
        "appSchemeBigStone": MessageLookupByLibrary.simpleMessage("Big Stone"),
        "appSchemeBlackWhite":
            MessageLookupByLibrary.simpleMessage("Black & White"),
        "appSchemeBlue": MessageLookupByLibrary.simpleMessage("Blue"),
        "appSchemeBlueM3": MessageLookupByLibrary.simpleMessage("Blue M3"),
        "appSchemeBlueWhale":
            MessageLookupByLibrary.simpleMessage("Blue Whale"),
        "appSchemeBlumineBlue":
            MessageLookupByLibrary.simpleMessage("Blumine Blue"),
        "appSchemeBrandBlue":
            MessageLookupByLibrary.simpleMessage("Brand Blue"),
        "appSchemeCyanM3": MessageLookupByLibrary.simpleMessage("Cyan M3"),
        "appSchemeDamask": MessageLookupByLibrary.simpleMessage("Damask"),
        "appSchemeDeepBlue": MessageLookupByLibrary.simpleMessage("Deep Blue"),
        "appSchemeDeepOrangeM3":
            MessageLookupByLibrary.simpleMessage("Deep Orange M3"),
        "appSchemeDeepPurple":
            MessageLookupByLibrary.simpleMessage("Deep Purple"),
        "appSchemeDellGenoa":
            MessageLookupByLibrary.simpleMessage("Dell Genoa"),
        "appSchemeEbonyClay":
            MessageLookupByLibrary.simpleMessage("Ebony Clay"),
        "appSchemeEspresso": MessageLookupByLibrary.simpleMessage("Espresso"),
        "appSchemeFlutterDash":
            MessageLookupByLibrary.simpleMessage("Flutter Dash"),
        "appSchemeGold": MessageLookupByLibrary.simpleMessage("Gold"),
        "appSchemeGreen": MessageLookupByLibrary.simpleMessage("Green"),
        "appSchemeGreenM3": MessageLookupByLibrary.simpleMessage("Green M3"),
        "appSchemeGreyLaw": MessageLookupByLibrary.simpleMessage("Grey Law"),
        "appSchemeGreys": MessageLookupByLibrary.simpleMessage("Greys"),
        "appSchemeHippieBlue":
            MessageLookupByLibrary.simpleMessage("Hippie Blue"),
        "appSchemeIndigo": MessageLookupByLibrary.simpleMessage("Indigo"),
        "appSchemeIndigoM3": MessageLookupByLibrary.simpleMessage("Indigo M3"),
        "appSchemeJungle": MessageLookupByLibrary.simpleMessage("Jungle"),
        "appSchemeLimeM3": MessageLookupByLibrary.simpleMessage("Lime M3"),
        "appSchemeMallardGreen":
            MessageLookupByLibrary.simpleMessage("Mallard Green"),
        "appSchemeMandyRed": MessageLookupByLibrary.simpleMessage("Mandy Red"),
        "appSchemeMango": MessageLookupByLibrary.simpleMessage("Mango"),
        "appSchemeMaterial": MessageLookupByLibrary.simpleMessage("Material"),
        "appSchemeMaterialBaseline":
            MessageLookupByLibrary.simpleMessage("Material Baseline"),
        "appSchemeMaterialHc":
            MessageLookupByLibrary.simpleMessage("Material HC"),
        "appSchemeMoney": MessageLookupByLibrary.simpleMessage("Money"),
        "appSchemeOrangeM3": MessageLookupByLibrary.simpleMessage("Orange M3"),
        "appSchemeOuterSpace":
            MessageLookupByLibrary.simpleMessage("Outer Space"),
        "appSchemePinkM3": MessageLookupByLibrary.simpleMessage("Pink M3"),
        "appSchemePurpleBrown":
            MessageLookupByLibrary.simpleMessage("Purple Brown"),
        "appSchemePurpleM3": MessageLookupByLibrary.simpleMessage("Purple M3"),
        "appSchemeRed": MessageLookupByLibrary.simpleMessage("Red"),
        "appSchemeRedM3": MessageLookupByLibrary.simpleMessage("Red M3"),
        "appSchemeRedWine": MessageLookupByLibrary.simpleMessage("Red Wine"),
        "appSchemeRosewood": MessageLookupByLibrary.simpleMessage("Rosewood"),
        "appSchemeSakura": MessageLookupByLibrary.simpleMessage("Sakura"),
        "appSchemeSanJuanBlue":
            MessageLookupByLibrary.simpleMessage("San Juan Blue"),
        "appSchemeSepia": MessageLookupByLibrary.simpleMessage("Sepia"),
        "appSchemeShadBlue": MessageLookupByLibrary.simpleMessage("Shad Blue"),
        "appSchemeShadGray": MessageLookupByLibrary.simpleMessage("Shad Gray"),
        "appSchemeShadGreen":
            MessageLookupByLibrary.simpleMessage("Shad Green"),
        "appSchemeShadNeutral":
            MessageLookupByLibrary.simpleMessage("Shad Neutral"),
        "appSchemeShadOrange":
            MessageLookupByLibrary.simpleMessage("Shad Orange"),
        "appSchemeShadRed": MessageLookupByLibrary.simpleMessage("Shad Red"),
        "appSchemeShadRose": MessageLookupByLibrary.simpleMessage("Shad Rose"),
        "appSchemeShadSlate":
            MessageLookupByLibrary.simpleMessage("Shad Slate"),
        "appSchemeShadStone":
            MessageLookupByLibrary.simpleMessage("Shad Stone"),
        "appSchemeShadViolet":
            MessageLookupByLibrary.simpleMessage("Shad Violet"),
        "appSchemeShadYellow":
            MessageLookupByLibrary.simpleMessage("Shad Yellow"),
        "appSchemeShadZinc": MessageLookupByLibrary.simpleMessage("Shad Zinc"),
        "appSchemeShark": MessageLookupByLibrary.simpleMessage("Shark"),
        "appSchemeTealM3": MessageLookupByLibrary.simpleMessage("Teal M3"),
        "appSchemeVerdunHemlock":
            MessageLookupByLibrary.simpleMessage("Verdun Hemlock"),
        "appSchemeVesuviusBurn":
            MessageLookupByLibrary.simpleMessage("Vesuvius Burn"),
        "appSchemeWasabi": MessageLookupByLibrary.simpleMessage("Wasabi"),
        "appSchemeYellowM3": MessageLookupByLibrary.simpleMessage("Yellow M3"),
        "appThemeModeDark": MessageLookupByLibrary.simpleMessage("Dark"),
        "appThemeModeLight": MessageLookupByLibrary.simpleMessage("Light"),
        "appThemeModeSystem": MessageLookupByLibrary.simpleMessage("System"),
        "ascendingLabel": MessageLookupByLibrary.simpleMessage("Ascending"),
        "ascendingLowToHigh":
            MessageLookupByLibrary.simpleMessage("Low to High"),
        "attachmentStatusPending":
            MessageLookupByLibrary.simpleMessage("Pending"),
        "attachmentStatusUploaded":
            MessageLookupByLibrary.simpleMessage("Uploaded"),
        "attachments": MessageLookupByLibrary.simpleMessage("Attachments"),
        "attachmentsLength": m0,
        "attachmentsTab": MessageLookupByLibrary.simpleMessage("Attachments"),
        "autoLockAfter":
            MessageLookupByLibrary.simpleMessage("Auto-lock After"),
        "autoLockAfterImmediately":
            MessageLookupByLibrary.simpleMessage("Immediately"),
        "autoLockAfterSixtySec":
            MessageLookupByLibrary.simpleMessage("After 60 seconds"),
        "autoLockAfterTenSec":
            MessageLookupByLibrary.simpleMessage("After 10 seconds"),
        "autoLockAfterThirtySec":
            MessageLookupByLibrary.simpleMessage("After 30 seconds"),
        "badgeStyleOptionItem":
            MessageLookupByLibrary.simpleMessage("Badge Style"),
        "barChartTitle":
            MessageLookupByLibrary.simpleMessage("Priority Distribution"),
        "calenderAppBar": MessageLookupByLibrary.simpleMessage("Calender"),
        "camera": MessageLookupByLibrary.simpleMessage("Camera"),
        "cancelModalSheetButton":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "categories": MessageLookupByLibrary.simpleMessage("Categories"),
        "categoriesFilter": MessageLookupByLibrary.simpleMessage("Categories"),
        "categoriesLength": m1,
        "changePasswordOptionItem":
            MessageLookupByLibrary.simpleMessage("Change Password"),
        "completedAt": MessageLookupByLibrary.simpleMessage("\nCompleted at  "),
        "confirmModalSheetButton":
            MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmPasswordTextField":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "confirmPasswordTextFieldHint":
            MessageLookupByLibrary.simpleMessage("Confirm your password"),
        "connect": MessageLookupByLibrary.simpleMessage("Connect"),
        "connectedAccountsAppBar":
            MessageLookupByLibrary.simpleMessage("Connected Accounts"),
        "connectedAccountsOptionItem":
            MessageLookupByLibrary.simpleMessage("Connected accounts"),
        "createAccount":
            MessageLookupByLibrary.simpleMessage("Create an account,"),
        "createSubtaskButton":
            MessageLookupByLibrary.simpleMessage("Create Subtask"),
        "createTaskButton": MessageLookupByLibrary.simpleMessage("Create Task"),
        "createdAt": MessageLookupByLibrary.simpleMessage("Created at  "),
        "currentLockType":
            MessageLookupByLibrary.simpleMessage("Current lock type"),
        "custom": MessageLookupByLibrary.simpleMessage("Custom"),
        "daily": MessageLookupByLibrary.simpleMessage("Daily"),
        "day": MessageLookupByLibrary.simpleMessage("day"),
        "days": MessageLookupByLibrary.simpleMessage("days"),
        "deleteAccountDialogDescription": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete your account permanently?"),
        "deleteAccountDialogTitle":
            MessageLookupByLibrary.simpleMessage("Delete Account Permanently"),
        "deleteAccountOptionItem":
            MessageLookupByLibrary.simpleMessage("Delete Account"),
        "deleteAttachmentAction":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteCategoryContent": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this Category permanently?"),
        "deleteCategoryTitle":
            MessageLookupByLibrary.simpleMessage("Delete Category Permanently"),
        "deleteModalSheetButton":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteSubtaskAction": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteSubtaskDialogDescription": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this subtask?"),
        "deleteSubtaskDialogTitle":
            MessageLookupByLibrary.simpleMessage("Delete Subtask"),
        "deleteTaskAction": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteTaskDialogDescription": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this task?"),
        "deleteTaskDialogTitle":
            MessageLookupByLibrary.simpleMessage("Delete Task"),
        "deletedAt": MessageLookupByLibrary.simpleMessage("\nDeleted at  "),
        "descendingHighToLow":
            MessageLookupByLibrary.simpleMessage("High to Low"),
        "descendingLabel": MessageLookupByLibrary.simpleMessage("Descending"),
        "descriptionTextField":
            MessageLookupByLibrary.simpleMessage("Description"),
        "descriptionTextFieldHint":
            MessageLookupByLibrary.simpleMessage("Enter Description"),
        "disconnect": MessageLookupByLibrary.simpleMessage("Disconnect"),
        "dontHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Don’t have an account? "),
        "download": MessageLookupByLibrary.simpleMessage("Download"),
        "downloadAttachmentAction":
            MessageLookupByLibrary.simpleMessage("Download"),
        "dueDateFilter": MessageLookupByLibrary.simpleMessage("Due Date"),
        "dueDateTextField": MessageLookupByLibrary.simpleMessage("Due Date"),
        "duration": MessageLookupByLibrary.simpleMessage("Duration"),
        "editEmailAppBar": MessageLookupByLibrary.simpleMessage("Edit Email"),
        "editFullNameAppBar":
            MessageLookupByLibrary.simpleMessage("Edit Full Name"),
        "editPasswordAppBar":
            MessageLookupByLibrary.simpleMessage("Edit Password"),
        "editSubtaskAction": MessageLookupByLibrary.simpleMessage("Edit"),
        "editTaskAction": MessageLookupByLibrary.simpleMessage("Edit"),
        "editTaskAppBar": MessageLookupByLibrary.simpleMessage("Edit Task"),
        "emailEditUser": MessageLookupByLibrary.simpleMessage("Email"),
        "emailTextField": MessageLookupByLibrary.simpleMessage("Email"),
        "emailTextFieldHint":
            MessageLookupByLibrary.simpleMessage("Enter your email"),
        "endTimeTextField": MessageLookupByLibrary.simpleMessage("End Time"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("Enter your Password"),
        "enterYourPin": MessageLookupByLibrary.simpleMessage("Enter your PIN"),
        "every": MessageLookupByLibrary.simpleMessage("Every "),
        "everyMonthOn": m2,
        "everyOtherMonthOn": m3,
        "everyOtherWeekOn": m4,
        "everyOtherYearOn": m5,
        "everySingle": m6,
        "everyString": m7,
        "everyWeekOn": m8,
        "everyYearOn": m9,
        "fiftyMB": MessageLookupByLibrary.simpleMessage("50MB"),
        "fileAttachments": m10,
        "filters": MessageLookupByLibrary.simpleMessage("Filters"),
        "firstShort": MessageLookupByLibrary.simpleMessage("st"),
        "fontOptionItem": MessageLookupByLibrary.simpleMessage("Font"),
        "fontSelectionModalSheetDescription":
            MessageLookupByLibrary.simpleMessage(
                "This font will be applied to all screens"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "forgotPasswordAppBar":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "forgotPasswordBody": MessageLookupByLibrary.simpleMessage(
            "The reset link will be sent to your email, please check it"),
        "formattedUnitPlural": m11,
        "friday": MessageLookupByLibrary.simpleMessage("Friday"),
        "fridayShort": MessageLookupByLibrary.simpleMessage("Fri"),
        "fullNameEditUser": MessageLookupByLibrary.simpleMessage("Full Name"),
        "fullNameTextField": MessageLookupByLibrary.simpleMessage("Full Name"),
        "fullNameTextFieldHint":
            MessageLookupByLibrary.simpleMessage("Enter your name"),
        "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
        "getStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
        "highSecurity": MessageLookupByLibrary.simpleMessage("High security, "),
        "incorrectLockType": m12,
        "languageOptionItem": MessageLookupByLibrary.simpleMessage("Language"),
        "letsCreateAccountTogether": MessageLookupByLibrary.simpleMessage(
            "Let’s create account together"),
        "markAsComplete":
            MessageLookupByLibrary.simpleMessage("Mark as Complete"),
        "maximumCategoryLimit":
            MessageLookupByLibrary.simpleMessage("Maximum category limit: "),
        "mediaAttachments": m13,
        "mediumHighSecurity":
            MessageLookupByLibrary.simpleMessage("Medium-high security, "),
        "memberSince": MessageLookupByLibrary.simpleMessage("Member Since"),
        "monday": MessageLookupByLibrary.simpleMessage("Monday"),
        "mondayShort": MessageLookupByLibrary.simpleMessage("Mon"),
        "month": MessageLookupByLibrary.simpleMessage("month"),
        "monthly": MessageLookupByLibrary.simpleMessage("Monthly"),
        "months": MessageLookupByLibrary.simpleMessage("months"),
        "moveToTrash": MessageLookupByLibrary.simpleMessage("Move to Trash"),
        "newEmailTextField": MessageLookupByLibrary.simpleMessage("New Email"),
        "newEmailTextFieldHint":
            MessageLookupByLibrary.simpleMessage("Enter new email"),
        "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
        "newPasswordTextFieldHint":
            MessageLookupByLibrary.simpleMessage("New Password"),
        "notConnected": MessageLookupByLibrary.simpleMessage("Not connected"),
        "noteTextField": MessageLookupByLibrary.simpleMessage("Note"),
        "noteTextFieldHint": MessageLookupByLibrary.simpleMessage("Enter note"),
        "notificationsAppBar":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "notificationsOptionItem":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "okModalBottomSheet": MessageLookupByLibrary.simpleMessage("Ok"),
        "onBoardingBody1": MessageLookupByLibrary.simpleMessage(
            "Remember to keep track of your professional accomplishments"),
        "onBoardingBody2": MessageLookupByLibrary.simpleMessage(
            "But understanding the contributions our colleagues make to our teams and companies"),
        "onBoardingBody3": MessageLookupByLibrary.simpleMessage(
            "Take control of notifications, collaborate live or on your own time"),
        "onBoardingTitle1": MessageLookupByLibrary.simpleMessage(
            "Track your work and get the result"),
        "onBoardingTitle2":
            MessageLookupByLibrary.simpleMessage("Stay organized with team"),
        "onBoardingTitle3": MessageLookupByLibrary.simpleMessage(
            "Get notified when work happens"),
        "onString": m14,
        "once": MessageLookupByLibrary.simpleMessage(" (once)"),
        "or": MessageLookupByLibrary.simpleMessage("Or"),
        "passwordTextField": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordTextFieldHint":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "pieChartTitle": MessageLookupByLibrary.simpleMessage("Task Status"),
        "predefinedCategoriesEducation":
            MessageLookupByLibrary.simpleMessage("Education"),
        "predefinedCategoriesFamily":
            MessageLookupByLibrary.simpleMessage("Family"),
        "predefinedCategoriesFinance":
            MessageLookupByLibrary.simpleMessage("Finance"),
        "predefinedCategoriesHealth":
            MessageLookupByLibrary.simpleMessage("Health"),
        "predefinedCategoriesPersonal":
            MessageLookupByLibrary.simpleMessage("Personal"),
        "predefinedCategoriesShopping":
            MessageLookupByLibrary.simpleMessage("Shopping"),
        "predefinedCategoriesWork":
            MessageLookupByLibrary.simpleMessage("Work"),
        "preferencesSectionTitle":
            MessageLookupByLibrary.simpleMessage("Preferences"),
        "priorityFilter": MessageLookupByLibrary.simpleMessage("Priority"),
        "priorityTextField": MessageLookupByLibrary.simpleMessage("Priority"),
        "profileAppBar": MessageLookupByLibrary.simpleMessage("Profile"),
        "profileOptionItem": MessageLookupByLibrary.simpleMessage("Profile"),
        "profilePictureBottomSheet":
            MessageLookupByLibrary.simpleMessage("Profile Picture"),
        "reminderAppBar": MessageLookupByLibrary.simpleMessage("Task Reminder"),
        "reminderOption1":
            MessageLookupByLibrary.simpleMessage("At time of event"),
        "reminderOption2":
            MessageLookupByLibrary.simpleMessage("10 mins before"),
        "reminderOption3":
            MessageLookupByLibrary.simpleMessage("1 hour before"),
        "reminderOption4": MessageLookupByLibrary.simpleMessage("1 day before"),
        "reminderTextField": MessageLookupByLibrary.simpleMessage("Reminder"),
        "reminderUnit1": MessageLookupByLibrary.simpleMessage("Minutes"),
        "reminderUnit2": MessageLookupByLibrary.simpleMessage("Hours"),
        "reminderUnit3": MessageLookupByLibrary.simpleMessage("Days"),
        "reminderUnit4": MessageLookupByLibrary.simpleMessage("Weeks"),
        "rename": MessageLookupByLibrary.simpleMessage("Rename"),
        "renameAttachmentAction":
            MessageLookupByLibrary.simpleMessage("Rename"),
        "repeatAppBar": MessageLookupByLibrary.simpleMessage("Task Repeat"),
        "repeatDescriptionDontRepeat":
            MessageLookupByLibrary.simpleMessage("This event doesn’t repeat"),
        "repeatDescriptionEveryMonth": MessageLookupByLibrary.simpleMessage(
            "This event will repeat every month"),
        "repeatDescriptionEveryOtherDay": m15,
        "repeatDescriptionEveryOtherMonth": m16,
        "repeatDescriptionEveryOtherWeek": m17,
        "repeatDescriptionEveryOtherYear": m18,
        "repeatDescriptionEveryWeek": m19,
        "repeatDescriptionEveryYear": MessageLookupByLibrary.simpleMessage(
            "This event will repeat every year"),
        "repeatDescriptionEveryday": MessageLookupByLibrary.simpleMessage(
            "This event will repeat every day"),
        "repeatDuration1": MessageLookupByLibrary.simpleMessage("Forever"),
        "repeatDuration2":
            MessageLookupByLibrary.simpleMessage("Specific number of times"),
        "repeatDuration3": MessageLookupByLibrary.simpleMessage("Until"),
        "repeatOption1": MessageLookupByLibrary.simpleMessage("Don’t repeat"),
        "repeatOption2": MessageLookupByLibrary.simpleMessage("Everyday"),
        "repeatOption3": MessageLookupByLibrary.simpleMessage("Every week"),
        "repeatOption4": MessageLookupByLibrary.simpleMessage("Every month"),
        "repeatOption5": MessageLookupByLibrary.simpleMessage("Every year"),
        "repeatTextField": MessageLookupByLibrary.simpleMessage("Repeat"),
        "reschedule": MessageLookupByLibrary.simpleMessage("Reschedule"),
        "rescheduleTask":
            MessageLookupByLibrary.simpleMessage("Reschedule Task"),
        "resetModalSheetButton": MessageLookupByLibrary.simpleMessage("Reset"),
        "resetPasswordAppBar":
            MessageLookupByLibrary.simpleMessage("Reset Password"),
        "resetPasswordBody": MessageLookupByLibrary.simpleMessage(
            "Your new password should be different from your previous password"),
        "resetPasswordButton": MessageLookupByLibrary.simpleMessage("Reset"),
        "restoreTaskAction": MessageLookupByLibrary.simpleMessage("Restore"),
        "saturday": MessageLookupByLibrary.simpleMessage("Saturday"),
        "saturdayShort": MessageLookupByLibrary.simpleMessage("Sat"),
        "schemeColorOptionItem":
            MessageLookupByLibrary.simpleMessage("Scheme Color"),
        "searchBarPlaceholder":
            MessageLookupByLibrary.simpleMessage("What are you looking for?"),
        "secondShort": MessageLookupByLibrary.simpleMessage("nd"),
        "securitySectionTitle":
            MessageLookupByLibrary.simpleMessage("Security"),
        "selectedSortField": MessageLookupByLibrary.simpleMessage("dueDate"),
        "selectedTaskReminder": m20,
        "sendButton": MessageLookupByLibrary.simpleMessage("Send"),
        "settingsAppBar": MessageLookupByLibrary.simpleMessage("Settings"),
        "shareText":
            MessageLookupByLibrary.simpleMessage("Here are the statistics!"),
        "showBadgeSelectionModalSheetTitle":
            MessageLookupByLibrary.simpleMessage("App Badge Style"),
        "showFontSelectionModalSheetTitle":
            MessageLookupByLibrary.simpleMessage("App Font"),
        "showLanguageSelectionModalSheetTitle":
            MessageLookupByLibrary.simpleMessage("App Language"),
        "showPrioritySelectionModalSheetTitle":
            MessageLookupByLibrary.simpleMessage("Select Priority"),
        "showSchemeColorSelectionModalSheetTitle":
            MessageLookupByLibrary.simpleMessage("Scheme Color"),
        "showThemeModeSelectionModalSheetTitle":
            MessageLookupByLibrary.simpleMessage("App Theme"),
        "signInButton": MessageLookupByLibrary.simpleMessage("Sign In"),
        "signInRedirect": MessageLookupByLibrary.simpleMessage("Sign In"),
        "signInToYourAccount":
            MessageLookupByLibrary.simpleMessage("Sign in to your account"),
        "signInWithGoogle":
            MessageLookupByLibrary.simpleMessage("Sign in with Google"),
        "signOutDialogDescription": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to sign out?"),
        "signOutDialogTitle": MessageLookupByLibrary.simpleMessage("Sign out"),
        "signOutOptionItem": MessageLookupByLibrary.simpleMessage("Sign out"),
        "signUpButton": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "signUpRedirect": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort By"),
        "sortByLabel1": MessageLookupByLibrary.simpleMessage("dueDate"),
        "sortByLabel2": MessageLookupByLibrary.simpleMessage("priority"),
        "sortByLabel3": MessageLookupByLibrary.simpleMessage("alphabet"),
        "startTimeTextField":
            MessageLookupByLibrary.simpleMessage("Start Time"),
        "statisticsAppBar": MessageLookupByLibrary.simpleMessage("Statistics"),
        "statusFilter": MessageLookupByLibrary.simpleMessage("Status"),
        "subtaskStatusCompleted":
            MessageLookupByLibrary.simpleMessage("Completed"),
        "subtaskStatusInProgress":
            MessageLookupByLibrary.simpleMessage("In Progress"),
        "subtasks": MessageLookupByLibrary.simpleMessage("Subtasks"),
        "subtasksLength": m21,
        "subtasksTab": MessageLookupByLibrary.simpleMessage("Subtasks"),
        "sunday": MessageLookupByLibrary.simpleMessage("Sunday"),
        "sundayShort": MessageLookupByLibrary.simpleMessage("Sun"),
        "tabAll": MessageLookupByLibrary.simpleMessage("All"),
        "tabCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
        "tabOverdue": MessageLookupByLibrary.simpleMessage("Overdue"),
        "tabToday": MessageLookupByLibrary.simpleMessage("Today"),
        "tabTomorrow": MessageLookupByLibrary.simpleMessage("Tomorrow"),
        "tabUpcoming": MessageLookupByLibrary.simpleMessage("Upcoming"),
        "taskDescription": MessageLookupByLibrary.simpleMessage("Description"),
        "taskDetails": MessageLookupByLibrary.simpleMessage("Task Details"),
        "taskDueDate": MessageLookupByLibrary.simpleMessage("Due Date"),
        "taskDueTime": MessageLookupByLibrary.simpleMessage("Due Time"),
        "taskPriorityHigh": MessageLookupByLibrary.simpleMessage("High"),
        "taskPriorityLow": MessageLookupByLibrary.simpleMessage("Low"),
        "taskPriorityMedium": MessageLookupByLibrary.simpleMessage("Medium"),
        "taskReminder": MessageLookupByLibrary.simpleMessage("Reminder"),
        "taskRepeat": MessageLookupByLibrary.simpleMessage("Repeat"),
        "taskStatus": MessageLookupByLibrary.simpleMessage("Status"),
        "taskStatusCompleted":
            MessageLookupByLibrary.simpleMessage("Completed"),
        "taskStatusInProgress":
            MessageLookupByLibrary.simpleMessage("In Progress"),
        "taskStatusOverdue": MessageLookupByLibrary.simpleMessage("Overdue"),
        "taskStatusTrash": MessageLookupByLibrary.simpleMessage("Trash"),
        "taskTags": MessageLookupByLibrary.simpleMessage("Tags"),
        "taskTitle": MessageLookupByLibrary.simpleMessage("Title"),
        "tempSortFieldAlphabet":
            MessageLookupByLibrary.simpleMessage("alphabet"),
        "tempSortFieldDueDate": MessageLookupByLibrary.simpleMessage("dueDate"),
        "tempSortFieldPriority":
            MessageLookupByLibrary.simpleMessage("priority"),
        "themeModeOptionItem":
            MessageLookupByLibrary.simpleMessage("Theme Mode"),
        "thirdShort": MessageLookupByLibrary.simpleMessage("rd"),
        "thisMonthFilter": MessageLookupByLibrary.simpleMessage("This Month"),
        "thisWeekFilter": MessageLookupByLibrary.simpleMessage("This Week"),
        "thisYearFilter": MessageLookupByLibrary.simpleMessage("This Year"),
        "thursday": MessageLookupByLibrary.simpleMessage("Thursday"),
        "thursdayShort": MessageLookupByLibrary.simpleMessage("Thu"),
        "timeTotal": MessageLookupByLibrary.simpleMessage("time total"),
        "times": m22,
        "timesTotal": MessageLookupByLibrary.simpleMessage("times total"),
        "timezone": MessageLookupByLibrary.simpleMessage("Timezone"),
        "titleTextField": MessageLookupByLibrary.simpleMessage("Title"),
        "titleTextFieldHint":
            MessageLookupByLibrary.simpleMessage("Enter title"),
        "todayFilter": MessageLookupByLibrary.simpleMessage("Today"),
        "todoList": MessageLookupByLibrary.simpleMessage("Todo List"),
        "tomorrowFilter": MessageLookupByLibrary.simpleMessage("Tomorrow"),
        "tooManyAttempts": MessageLookupByLibrary.simpleMessage(
            "Too many attempts. Please wait..."),
        "totalTasks": MessageLookupByLibrary.simpleMessage("Total Tasks"),
        "trashAppBar": MessageLookupByLibrary.simpleMessage("Trash"),
        "trashBody": MessageLookupByLibrary.simpleMessage(
            "Tasks in the trash will be permanently deleted after 30 days"),
        "tuesday": MessageLookupByLibrary.simpleMessage("Tuesday"),
        "tuesdayShort": MessageLookupByLibrary.simpleMessage("Tue"),
        "uncategorized": MessageLookupByLibrary.simpleMessage("Uncategorized"),
        "unlock": MessageLookupByLibrary.simpleMessage("Unlock"),
        "until": m23,
        "updateSubtaskButton":
            MessageLookupByLibrary.simpleMessage("Update Subtask"),
        "updatedAt": MessageLookupByLibrary.simpleMessage("\nUpdated at  "),
        "uploadFileSizeLimit":
            MessageLookupByLibrary.simpleMessage("Upload file size limit: "),
        "uploadFilesContainer":
            MessageLookupByLibrary.simpleMessage("Upload Files"),
        "wednesday": MessageLookupByLibrary.simpleMessage("Wednesday"),
        "wednesdayShort": MessageLookupByLibrary.simpleMessage("Wed"),
        "week": MessageLookupByLibrary.simpleMessage("week"),
        "weekly": MessageLookupByLibrary.simpleMessage("Weekly"),
        "weeks": MessageLookupByLibrary.simpleMessage("weeks"),
        "welcomeBackHomeView":
            MessageLookupByLibrary.simpleMessage("Welcome back!"),
        "welcomeBackSignInView":
            MessageLookupByLibrary.simpleMessage("Welcome back,"),
        "year": MessageLookupByLibrary.simpleMessage("year"),
        "years": MessageLookupByLibrary.simpleMessage("years")
      };
}
