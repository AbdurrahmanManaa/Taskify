// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Track your work and get the result`
  String get onBoardingTitle1 {
    return Intl.message(
      'Track your work and get the result',
      name: 'onBoardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Stay organized with team`
  String get onBoardingTitle2 {
    return Intl.message(
      'Stay organized with team',
      name: 'onBoardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Get notified when work happens`
  String get onBoardingTitle3 {
    return Intl.message(
      'Get notified when work happens',
      name: 'onBoardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Remember to keep track of your professional accomplishments`
  String get onBoardingBody1 {
    return Intl.message(
      'Remember to keep track of your professional accomplishments',
      name: 'onBoardingBody1',
      desc: '',
      args: [],
    );
  }

  /// `But understanding the contributions our colleagues make to our teams and companies`
  String get onBoardingBody2 {
    return Intl.message(
      'But understanding the contributions our colleagues make to our teams and companies',
      name: 'onBoardingBody2',
      desc: '',
      args: [],
    );
  }

  /// `Take control of notifications, collaborate live or on your own time`
  String get onBoardingBody3 {
    return Intl.message(
      'Take control of notifications, collaborate live or on your own time',
      name: 'onBoardingBody3',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back,`
  String get welcomeBackSignInView {
    return Intl.message(
      'Welcome back,',
      name: 'welcomeBackSignInView',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back!`
  String get welcomeBackHomeView {
    return Intl.message(
      'Welcome back!',
      name: 'welcomeBackHomeView',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to your account`
  String get signInToYourAccount {
    return Intl.message(
      'Sign in to your account',
      name: 'signInToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullNameTextField {
    return Intl.message(
      'Full Name',
      name: 'fullNameTextField',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullNameEditUser {
    return Intl.message(
      'Full Name',
      name: 'fullNameEditUser',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get fullNameTextFieldHint {
    return Intl.message(
      'Enter your name',
      name: 'fullNameTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailTextField {
    return Intl.message(
      'Email',
      name: 'emailTextField',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailEditUser {
    return Intl.message(
      'Email',
      name: 'emailEditUser',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get emailTextFieldHint {
    return Intl.message(
      'Enter your email',
      name: 'emailTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordTextField {
    return Intl.message(
      'Password',
      name: 'passwordTextField',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get passwordTextFieldHint {
    return Intl.message(
      'Enter your password',
      name: 'passwordTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordTextField {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordTextField',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get confirmPasswordTextFieldHint {
    return Intl.message(
      'Confirm your password',
      name: 'confirmPasswordTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get noteTextField {
    return Intl.message(
      'Note',
      name: 'noteTextField',
      desc: '',
      args: [],
    );
  }

  /// `Enter note`
  String get noteTextFieldHint {
    return Intl.message(
      'Enter note',
      name: 'noteTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signInButton {
    return Intl.message(
      'Sign In',
      name: 'signInButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUpButton {
    return Intl.message(
      'Sign Up',
      name: 'signUpButton',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get signInWithGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account? `
  String get dontHaveAnAccount {
    return Intl.message(
      'Don’t have an account? ',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUpRedirect {
    return Intl.message(
      'Sign Up',
      name: 'signUpRedirect',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signInRedirect {
    return Intl.message(
      'Sign In',
      name: 'signInRedirect',
      desc: '',
      args: [],
    );
  }

  /// `Create an account,`
  String get createAccount {
    return Intl.message(
      'Create an account,',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Let’s create account together`
  String get letsCreateAccountTogether {
    return Intl.message(
      'Let’s create account together',
      name: 'letsCreateAccountTogether',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPasswordAppBar {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPasswordAppBar',
      desc: '',
      args: [],
    );
  }

  /// `The reset link will be sent to your email, please check it`
  String get forgotPasswordBody {
    return Intl.message(
      'The reset link will be sent to your email, please check it',
      name: 'forgotPasswordBody',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get sendButton {
    return Intl.message(
      'Send',
      name: 'sendButton',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordAppBar {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Your new password should be different from your previous password`
  String get resetPasswordBody {
    return Intl.message(
      'Your new password should be different from your previous password',
      name: 'resetPasswordBody',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get resetPasswordButton {
    return Intl.message(
      'Reset',
      name: 'resetPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get resetModalSheetButton {
    return Intl.message(
      'Reset',
      name: 'resetModalSheetButton',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPasswordTextFieldHint {
    return Intl.message(
      'New Password',
      name: 'newPasswordTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileAppBar {
    return Intl.message(
      'Profile',
      name: 'profileAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Profile Picture`
  String get profilePictureBottomSheet {
    return Intl.message(
      'Profile Picture',
      name: 'profilePictureBottomSheet',
      desc: '',
      args: [],
    );
  }

  /// `Timezone`
  String get timezone {
    return Intl.message(
      'Timezone',
      name: 'timezone',
      desc: '',
      args: [],
    );
  }

  /// `Member Since`
  String get memberSince {
    return Intl.message(
      'Member Since',
      name: 'memberSince',
      desc: '',
      args: [],
    );
  }

  /// `Trash`
  String get trashAppBar {
    return Intl.message(
      'Trash',
      name: 'trashAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Tasks in the trash will be permanently deleted after 30 days`
  String get trashBody {
    return Intl.message(
      'Tasks in the trash will be permanently deleted after 30 days',
      name: 'trashBody',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notificationsAppBar {
    return Intl.message(
      'Notifications',
      name: 'notificationsAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Calender`
  String get calenderAppBar {
    return Intl.message(
      'Calender',
      name: 'calenderAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Add Task`
  String get addTaskAppBar {
    return Intl.message(
      'Add Task',
      name: 'addTaskAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get titleTextField {
    return Intl.message(
      'Title',
      name: 'titleTextField',
      desc: '',
      args: [],
    );
  }

  /// `Enter title`
  String get titleTextFieldHint {
    return Intl.message(
      'Enter title',
      name: 'titleTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get descriptionTextField {
    return Intl.message(
      'Description',
      name: 'descriptionTextField',
      desc: '',
      args: [],
    );
  }

  /// `Enter Description`
  String get descriptionTextFieldHint {
    return Intl.message(
      'Enter Description',
      name: 'descriptionTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Due Date`
  String get dueDateTextField {
    return Intl.message(
      'Due Date',
      name: 'dueDateTextField',
      desc: '',
      args: [],
    );
  }

  /// `Due Date`
  String get dueDateFilter {
    return Intl.message(
      'Due Date',
      name: 'dueDateFilter',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get startTimeTextField {
    return Intl.message(
      'Start Time',
      name: 'startTimeTextField',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get endTimeTextField {
    return Intl.message(
      'End Time',
      name: 'endTimeTextField',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get reminderTextField {
    return Intl.message(
      'Reminder',
      name: 'reminderTextField',
      desc: '',
      args: [],
    );
  }

  /// `Repeat`
  String get repeatTextField {
    return Intl.message(
      'Repeat',
      name: 'repeatTextField',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priorityTextField {
    return Intl.message(
      'Priority',
      name: 'priorityTextField',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priorityFilter {
    return Intl.message(
      'Priority',
      name: 'priorityFilter',
      desc: '',
      args: [],
    );
  }

  /// `Select Priority`
  String get showPrioritySelectionModalSheetTitle {
    return Intl.message(
      'Select Priority',
      name: 'showPrioritySelectionModalSheetTitle',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categoriesFilter {
    return Intl.message(
      'Categories',
      name: 'categoriesFilter',
      desc: '',
      args: [],
    );
  }

  /// `Categories ({length})`
  String categoriesLength(Object length) {
    return Intl.message(
      'Categories ($length)',
      name: 'categoriesLength',
      desc: '',
      args: [length],
    );
  }

  /// `Delete Category Permanently`
  String get deleteCategoryTitle {
    return Intl.message(
      'Delete Category Permanently',
      name: 'deleteCategoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this Category permanently?`
  String get deleteCategoryContent {
    return Intl.message(
      'Are you sure you want to delete this Category permanently?',
      name: 'deleteCategoryContent',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get addCategoryLabel {
    return Intl.message(
      'Add Category',
      name: 'addCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Maximum category limit: `
  String get maximumCategoryLimit {
    return Intl.message(
      'Maximum category limit: ',
      name: 'maximumCategoryLimit',
      desc: '',
      args: [],
    );
  }

  /// `Attachments`
  String get attachments {
    return Intl.message(
      'Attachments',
      name: 'attachments',
      desc: '',
      args: [],
    );
  }

  /// `Attachments`
  String get attachmentsTab {
    return Intl.message(
      'Attachments',
      name: 'attachmentsTab',
      desc: '',
      args: [],
    );
  }

  /// `Attachments ({length})`
  String attachmentsLength(Object length) {
    return Intl.message(
      'Attachments ($length)',
      name: 'attachmentsLength',
      desc: '',
      args: [length],
    );
  }

  /// `Upload Files`
  String get uploadFilesContainer {
    return Intl.message(
      'Upload Files',
      name: 'uploadFilesContainer',
      desc: '',
      args: [],
    );
  }

  /// `Upload file size limit: `
  String get uploadFileSizeLimit {
    return Intl.message(
      'Upload file size limit: ',
      name: 'uploadFileSizeLimit',
      desc: '',
      args: [],
    );
  }

  /// `50MB`
  String get fiftyMB {
    return Intl.message(
      '50MB',
      name: 'fiftyMB',
      desc: '',
      args: [],
    );
  }

  /// `Subtasks`
  String get subtasks {
    return Intl.message(
      'Subtasks',
      name: 'subtasks',
      desc: '',
      args: [],
    );
  }

  /// `Subtasks`
  String get subtasksTab {
    return Intl.message(
      'Subtasks',
      name: 'subtasksTab',
      desc: '',
      args: [],
    );
  }

  /// `Subtasks ({length})`
  String subtasksLength(Object length) {
    return Intl.message(
      'Subtasks ($length)',
      name: 'subtasksLength',
      desc: '',
      args: [length],
    );
  }

  /// `Add Subtask`
  String get addSubtaskButton {
    return Intl.message(
      'Add Subtask',
      name: 'addSubtaskButton',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editSubtaskAction {
    return Intl.message(
      'Edit',
      name: 'editSubtaskAction',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteSubtaskAction {
    return Intl.message(
      'Delete',
      name: 'deleteSubtaskAction',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteAttachmentAction {
    return Intl.message(
      'Delete',
      name: 'deleteAttachmentAction',
      desc: '',
      args: [],
    );
  }

  /// `Rename`
  String get renameAttachmentAction {
    return Intl.message(
      'Rename',
      name: 'renameAttachmentAction',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get downloadAttachmentAction {
    return Intl.message(
      'Download',
      name: 'downloadAttachmentAction',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelModalSheetButton {
    return Intl.message(
      'Cancel',
      name: 'cancelModalSheetButton',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmModalSheetButton {
    return Intl.message(
      'Confirm',
      name: 'confirmModalSheetButton',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteModalSheetButton {
    return Intl.message(
      'Delete',
      name: 'deleteModalSheetButton',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Create Task`
  String get createTaskButton {
    return Intl.message(
      'Create Task',
      name: 'createTaskButton',
      desc: '',
      args: [],
    );
  }

  /// `Create Subtask`
  String get createSubtaskButton {
    return Intl.message(
      'Create Subtask',
      name: 'createSubtaskButton',
      desc: '',
      args: [],
    );
  }

  /// `Update Subtask`
  String get updateSubtaskButton {
    return Intl.message(
      'Update Subtask',
      name: 'updateSubtaskButton',
      desc: '',
      args: [],
    );
  }

  /// `Task Reminder`
  String get reminderAppBar {
    return Intl.message(
      'Task Reminder',
      name: 'reminderAppBar',
      desc: '',
      args: [],
    );
  }

  /// `{value} {units} before`
  String selectedTaskReminder(Object value, Object units) {
    return Intl.message(
      '$value $units before',
      name: 'selectedTaskReminder',
      desc: '',
      args: [value, units],
    );
  }

  /// `At time of event`
  String get reminderOption1 {
    return Intl.message(
      'At time of event',
      name: 'reminderOption1',
      desc: '',
      args: [],
    );
  }

  /// `10 mins before`
  String get reminderOption2 {
    return Intl.message(
      '10 mins before',
      name: 'reminderOption2',
      desc: '',
      args: [],
    );
  }

  /// `1 hour before`
  String get reminderOption3 {
    return Intl.message(
      '1 hour before',
      name: 'reminderOption3',
      desc: '',
      args: [],
    );
  }

  /// `1 day before`
  String get reminderOption4 {
    return Intl.message(
      '1 day before',
      name: 'reminderOption4',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get reminderUnit1 {
    return Intl.message(
      'Minutes',
      name: 'reminderUnit1',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get reminderUnit2 {
    return Intl.message(
      'Hours',
      name: 'reminderUnit2',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get reminderUnit3 {
    return Intl.message(
      'Days',
      name: 'reminderUnit3',
      desc: '',
      args: [],
    );
  }

  /// `Weeks`
  String get reminderUnit4 {
    return Intl.message(
      'Weeks',
      name: 'reminderUnit4',
      desc: '',
      args: [],
    );
  }

  /// `Task Repeat`
  String get repeatAppBar {
    return Intl.message(
      'Task Repeat',
      name: 'repeatAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Don’t repeat`
  String get repeatOption1 {
    return Intl.message(
      'Don’t repeat',
      name: 'repeatOption1',
      desc: '',
      args: [],
    );
  }

  /// `Everyday`
  String get repeatOption2 {
    return Intl.message(
      'Everyday',
      name: 'repeatOption2',
      desc: '',
      args: [],
    );
  }

  /// `Every week`
  String get repeatOption3 {
    return Intl.message(
      'Every week',
      name: 'repeatOption3',
      desc: '',
      args: [],
    );
  }

  /// `Every month`
  String get repeatOption4 {
    return Intl.message(
      'Every month',
      name: 'repeatOption4',
      desc: '',
      args: [],
    );
  }

  /// `Every year`
  String get repeatOption5 {
    return Intl.message(
      'Every year',
      name: 'repeatOption5',
      desc: '',
      args: [],
    );
  }

  /// `Forever`
  String get repeatDuration1 {
    return Intl.message(
      'Forever',
      name: 'repeatDuration1',
      desc: '',
      args: [],
    );
  }

  /// `Specific number of times`
  String get repeatDuration2 {
    return Intl.message(
      'Specific number of times',
      name: 'repeatDuration2',
      desc: '',
      args: [],
    );
  }

  /// `Until`
  String get repeatDuration3 {
    return Intl.message(
      'Until',
      name: 'repeatDuration3',
      desc: '',
      args: [],
    );
  }

  /// `This event doesn’t repeat`
  String get repeatDescriptionDontRepeat {
    return Intl.message(
      'This event doesn’t repeat',
      name: 'repeatDescriptionDontRepeat',
      desc: '',
      args: [],
    );
  }

  /// `This event will repeat every day`
  String get repeatDescriptionEveryday {
    return Intl.message(
      'This event will repeat every day',
      name: 'repeatDescriptionEveryday',
      desc: '',
      args: [],
    );
  }

  /// `This event will repeat every {selectedInterval} day(s)`
  String repeatDescriptionEveryOtherDay(Object selectedInterval) {
    return Intl.message(
      'This event will repeat every $selectedInterval day(s)',
      name: 'repeatDescriptionEveryOtherDay',
      desc: '',
      args: [selectedInterval],
    );
  }

  /// `This event will repeat every week on {selectedDays}`
  String repeatDescriptionEveryWeek(Object selectedDays) {
    return Intl.message(
      'This event will repeat every week on $selectedDays',
      name: 'repeatDescriptionEveryWeek',
      desc: '',
      args: [selectedDays],
    );
  }

  /// `This event will repeat every {selectedInterval} week(s) on {selectedDays}`
  String repeatDescriptionEveryOtherWeek(
      Object selectedInterval, Object selectedDays) {
    return Intl.message(
      'This event will repeat every $selectedInterval week(s) on $selectedDays',
      name: 'repeatDescriptionEveryOtherWeek',
      desc: '',
      args: [selectedInterval, selectedDays],
    );
  }

  /// `This event will repeat every month`
  String get repeatDescriptionEveryMonth {
    return Intl.message(
      'This event will repeat every month',
      name: 'repeatDescriptionEveryMonth',
      desc: '',
      args: [],
    );
  }

  /// `This event will repeat every {selectedInterval} month(s)`
  String repeatDescriptionEveryOtherMonth(Object selectedInterval) {
    return Intl.message(
      'This event will repeat every $selectedInterval month(s)',
      name: 'repeatDescriptionEveryOtherMonth',
      desc: '',
      args: [selectedInterval],
    );
  }

  /// `This event will repeat every year`
  String get repeatDescriptionEveryYear {
    return Intl.message(
      'This event will repeat every year',
      name: 'repeatDescriptionEveryYear',
      desc: '',
      args: [],
    );
  }

  /// `This event will repeat every {selectedInterval} year(s)`
  String repeatDescriptionEveryOtherYear(Object selectedInterval) {
    return Intl.message(
      'This event will repeat every $selectedInterval year(s)',
      name: 'repeatDescriptionEveryOtherYear',
      desc: '',
      args: [selectedInterval],
    );
  }

  /// `Every `
  String get every {
    return Intl.message(
      'Every ',
      name: 'every',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get day {
    return Intl.message(
      'day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message(
      'days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `week`
  String get week {
    return Intl.message(
      'week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `weeks`
  String get weeks {
    return Intl.message(
      'weeks',
      name: 'weeks',
      desc: '',
      args: [],
    );
  }

  /// `month`
  String get month {
    return Intl.message(
      'month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `months`
  String get months {
    return Intl.message(
      'months',
      name: 'months',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get year {
    return Intl.message(
      'year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `years`
  String get years {
    return Intl.message(
      'years',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `time total`
  String get timeTotal {
    return Intl.message(
      'time total',
      name: 'timeTotal',
      desc: '',
      args: [],
    );
  }

  /// `times total`
  String get timesTotal {
    return Intl.message(
      'times total',
      name: 'timesTotal',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get custom {
    return Intl.message(
      'Custom',
      name: 'custom',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Here are the statistics!`
  String get shareText {
    return Intl.message(
      'Here are the statistics!',
      name: 'shareText',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statisticsAppBar {
    return Intl.message(
      'Statistics',
      name: 'statisticsAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Task Status`
  String get pieChartTitle {
    return Intl.message(
      'Task Status',
      name: 'pieChartTitle',
      desc: '',
      args: [],
    );
  }

  /// `Priority Distribution`
  String get barChartTitle {
    return Intl.message(
      'Priority Distribution',
      name: 'barChartTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get sundayShort {
    return Intl.message(
      'Sun',
      name: 'sundayShort',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get mondayShort {
    return Intl.message(
      'Mon',
      name: 'mondayShort',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get tuesdayShort {
    return Intl.message(
      'Tue',
      name: 'tuesdayShort',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get wednesdayShort {
    return Intl.message(
      'Wed',
      name: 'wednesdayShort',
      desc: '',
      args: [],
    );
  }

  /// `Thu`
  String get thursdayShort {
    return Intl.message(
      'Thu',
      name: 'thursdayShort',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get fridayShort {
    return Intl.message(
      'Fri',
      name: 'fridayShort',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get saturdayShort {
    return Intl.message(
      'Sat',
      name: 'saturdayShort',
      desc: '',
      args: [],
    );
  }

  /// `st`
  String get firstShort {
    return Intl.message(
      'st',
      name: 'firstShort',
      desc: '',
      args: [],
    );
  }

  /// `nd`
  String get secondShort {
    return Intl.message(
      'nd',
      name: 'secondShort',
      desc: '',
      args: [],
    );
  }

  /// `rd`
  String get thirdShort {
    return Intl.message(
      'rd',
      name: 'thirdShort',
      desc: '',
      args: [],
    );
  }

  /// `th`
  String get aboveThressShort {
    return Intl.message(
      'th',
      name: 'aboveThressShort',
      desc: '',
      args: [],
    );
  }

  /// `On the {day}{suffix} of {monthName}`
  String onString(Object day, Object suffix, Object monthName) {
    return Intl.message(
      'On the $day$suffix of $monthName',
      name: 'onString',
      desc: '',
      args: [day, suffix, monthName],
    );
  }

  /// `Every {interval} {units}`
  String everyString(Object interval, Object units) {
    return Intl.message(
      'Every $interval $units',
      name: 'everyString',
      desc: '',
      args: [interval, units],
    );
  }

  /// `{units}`
  String formattedUnitPlural(Object units) {
    return Intl.message(
      '$units',
      name: 'formattedUnitPlural',
      desc: '',
      args: [units],
    );
  }

  /// `Every {unit}`
  String everySingle(Object unit) {
    return Intl.message(
      'Every $unit',
      name: 'everySingle',
      desc: '',
      args: [unit],
    );
  }

  /// `Every year ({onString})`
  String everyYearOn(Object onString) {
    return Intl.message(
      'Every year ($onString)',
      name: 'everyYearOn',
      desc: '',
      args: [onString],
    );
  }

  /// `Every {interval} years ({onString})`
  String everyOtherYearOn(Object interval, Object onString) {
    return Intl.message(
      'Every $interval years ($onString)',
      name: 'everyOtherYearOn',
      desc: '',
      args: [interval, onString],
    );
  }

  /// `Every month ({onString})`
  String everyMonthOn(Object onString) {
    return Intl.message(
      'Every month ($onString)',
      name: 'everyMonthOn',
      desc: '',
      args: [onString],
    );
  }

  /// `Every {interval} months ({onString})`
  String everyOtherMonthOn(Object interval, Object onString) {
    return Intl.message(
      'Every $interval months ($onString)',
      name: 'everyOtherMonthOn',
      desc: '',
      args: [interval, onString],
    );
  }

  /// `Every week on {days}`
  String everyWeekOn(Object days) {
    return Intl.message(
      'Every week on $days',
      name: 'everyWeekOn',
      desc: '',
      args: [days],
    );
  }

  /// `Every {interval} weeks on {days}`
  String everyOtherWeekOn(Object interval, Object days) {
    return Intl.message(
      'Every $interval weeks on $days',
      name: 'everyOtherWeekOn',
      desc: '',
      args: [interval, days],
    );
  }

  /// `, Until {untilDate}`
  String until(Object untilDate) {
    return Intl.message(
      ', Until $untilDate',
      name: 'until',
      desc: '',
      args: [untilDate],
    );
  }

  /// ` (once)`
  String get once {
    return Intl.message(
      ' (once)',
      name: 'once',
      desc: '',
      args: [],
    );
  }

  /// ` ({count} times)`
  String times(Object count) {
    return Intl.message(
      ' ($count times)',
      name: 'times',
      desc: '',
      args: [count],
    );
  }

  /// `Settings`
  String get settingsAppBar {
    return Intl.message(
      'Settings',
      name: 'settingsAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get accountSectionTitle {
    return Intl.message(
      'Account',
      name: 'accountSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileOptionItem {
    return Intl.message(
      'Profile',
      name: 'profileOptionItem',
      desc: '',
      args: [],
    );
  }

  /// `Connected accounts`
  String get connectedAccountsOptionItem {
    return Intl.message(
      'Connected accounts',
      name: 'connectedAccountsOptionItem',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get securitySectionTitle {
    return Intl.message(
      'Security',
      name: 'securitySectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePasswordOptionItem {
    return Intl.message(
      'Change Password',
      name: 'changePasswordOptionItem',
      desc: '',
      args: [],
    );
  }

  /// `App Lock`
  String get appLockOptionItem {
    return Intl.message(
      'App Lock',
      name: 'appLockOptionItem',
      desc: '',
      args: [],
    );
  }

  /// `Account Actions`
  String get accountActionsSectionTitle {
    return Intl.message(
      'Account Actions',
      name: 'accountActionsSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signOutOptionItem {
    return Intl.message(
      'Sign out',
      name: 'signOutOptionItem',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signOutDialogTitle {
    return Intl.message(
      'Sign out',
      name: 'signOutDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to sign out?`
  String get signOutDialogDescription {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'signOutDialogDescription',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account Permanently`
  String get deleteAccountDialogTitle {
    return Intl.message(
      'Delete Account Permanently',
      name: 'deleteAccountDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account permanently?`
  String get deleteAccountDialogDescription {
    return Intl.message(
      'Are you sure you want to delete your account permanently?',
      name: 'deleteAccountDialogDescription',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccountOptionItem {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccountOptionItem',
      desc: '',
      args: [],
    );
  }

  /// `Preferences`
  String get preferencesSectionTitle {
    return Intl.message(
      'Preferences',
      name: 'preferencesSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notificationsOptionItem {
    return Intl.message(
      'Notifications',
      name: 'notificationsOptionItem',
      desc: '',
      args: [],
    );
  }

  /// `Badge Style`
  String get badgeStyleOptionItem {
    return Intl.message(
      'Badge Style',
      name: 'badgeStyleOptionItem',
      desc: '',
      args: [],
    );
  }

  /// `Theme Mode`
  String get themeModeOptionItem {
    return Intl.message(
      'Theme Mode',
      name: 'themeModeOptionItem',
      desc: '',
      args: [],
    );
  }

  /// `Scheme Color`
  String get schemeColorOptionItem {
    return Intl.message(
      'Scheme Color',
      name: 'schemeColorOptionItem',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get languageOptionItem {
    return Intl.message(
      'Language',
      name: 'languageOptionItem',
      desc: '',
      args: [],
    );
  }

  /// `Font`
  String get fontOptionItem {
    return Intl.message(
      'Font',
      name: 'fontOptionItem',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get taskStatusInProgress {
    return Intl.message(
      'In Progress',
      name: 'taskStatusInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get taskStatusCompleted {
    return Intl.message(
      'Completed',
      name: 'taskStatusCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get tabCompleted {
    return Intl.message(
      'Completed',
      name: 'tabCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Overdue`
  String get taskStatusOverdue {
    return Intl.message(
      'Overdue',
      name: 'taskStatusOverdue',
      desc: '',
      args: [],
    );
  }

  /// `Overdue`
  String get tabOverdue {
    return Intl.message(
      'Overdue',
      name: 'tabOverdue',
      desc: '',
      args: [],
    );
  }

  /// `Trash`
  String get taskStatusTrash {
    return Intl.message(
      'Trash',
      name: 'taskStatusTrash',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get taskPriorityLow {
    return Intl.message(
      'Low',
      name: 'taskPriorityLow',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get taskPriorityMedium {
    return Intl.message(
      'Medium',
      name: 'taskPriorityMedium',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get taskPriorityHigh {
    return Intl.message(
      'High',
      name: 'taskPriorityHigh',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get subtaskStatusInProgress {
    return Intl.message(
      'In Progress',
      name: 'subtaskStatusInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get subtaskStatusCompleted {
    return Intl.message(
      'Completed',
      name: 'subtaskStatusCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get attachmentStatusPending {
    return Intl.message(
      'Pending',
      name: 'attachmentStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Uploaded`
  String get attachmentStatusUploaded {
    return Intl.message(
      'Uploaded',
      name: 'attachmentStatusUploaded',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get appThemeModeLight {
    return Intl.message(
      'Light',
      name: 'appThemeModeLight',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get appThemeModeDark {
    return Intl.message(
      'Dark',
      name: 'appThemeModeDark',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get appThemeModeSystem {
    return Intl.message(
      'System',
      name: 'appThemeModeSystem',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get appLanguageEnglish {
    return Intl.message(
      'English',
      name: 'appLanguageEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get appLanguageArabic {
    return Intl.message(
      'Arabic',
      name: 'appLanguageArabic',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get appIconBadgeStyleNumber {
    return Intl.message(
      'Number',
      name: 'appIconBadgeStyleNumber',
      desc: '',
      args: [],
    );
  }

  /// `Dot`
  String get appIconBadgeStyleDot {
    return Intl.message(
      'Dot',
      name: 'appIconBadgeStyleDot',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get appLockTypeNone {
    return Intl.message(
      'None',
      name: 'appLockTypeNone',
      desc: '',
      args: [],
    );
  }

  /// `PIN`
  String get appLockTypePin {
    return Intl.message(
      'PIN',
      name: 'appLockTypePin',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get appLockTypePassword {
    return Intl.message(
      'Password',
      name: 'appLockTypePassword',
      desc: '',
      args: [],
    );
  }

  /// `Immediately`
  String get autoLockAfterImmediately {
    return Intl.message(
      'Immediately',
      name: 'autoLockAfterImmediately',
      desc: '',
      args: [],
    );
  }

  /// `After 10 seconds`
  String get autoLockAfterTenSec {
    return Intl.message(
      'After 10 seconds',
      name: 'autoLockAfterTenSec',
      desc: '',
      args: [],
    );
  }

  /// `After 30 seconds`
  String get autoLockAfterThirtySec {
    return Intl.message(
      'After 30 seconds',
      name: 'autoLockAfterThirtySec',
      desc: '',
      args: [],
    );
  }

  /// `After 60 seconds`
  String get autoLockAfterSixtySec {
    return Intl.message(
      'After 60 seconds',
      name: 'autoLockAfterSixtySec',
      desc: '',
      args: [],
    );
  }

  /// `Inter`
  String get appFontsInter {
    return Intl.message(
      'Inter',
      name: 'appFontsInter',
      desc: '',
      args: [],
    );
  }

  /// `Orbitron`
  String get appFontsOrbitron {
    return Intl.message(
      'Orbitron',
      name: 'appFontsOrbitron',
      desc: '',
      args: [],
    );
  }

  /// `Archivo`
  String get appFontsArchivo {
    return Intl.message(
      'Archivo',
      name: 'appFontsArchivo',
      desc: '',
      args: [],
    );
  }

  /// `Playfair Display`
  String get appFontsPlayfairDisplay {
    return Intl.message(
      'Playfair Display',
      name: 'appFontsPlayfairDisplay',
      desc: '',
      args: [],
    );
  }

  /// `Caveat`
  String get appFontsCaveat {
    return Intl.message(
      'Caveat',
      name: 'appFontsCaveat',
      desc: '',
      args: [],
    );
  }

  /// `Cairo`
  String get appFontsCairo {
    return Intl.message(
      'Cairo',
      name: 'appFontsCairo',
      desc: '',
      args: [],
    );
  }

  /// `Changa`
  String get appFontsChanga {
    return Intl.message(
      'Changa',
      name: 'appFontsChanga',
      desc: '',
      args: [],
    );
  }

  /// `El Messiri`
  String get appFontsElMessiri {
    return Intl.message(
      'El Messiri',
      name: 'appFontsElMessiri',
      desc: '',
      args: [],
    );
  }

  /// `IBM Plex Sans Arabic`
  String get appFontsIbmPlexSansArabic {
    return Intl.message(
      'IBM Plex Sans Arabic',
      name: 'appFontsIbmPlexSansArabic',
      desc: '',
      args: [],
    );
  }

  /// `Noto Kufi Arabic`
  String get appFontsNotoKufiArabic {
    return Intl.message(
      'Noto Kufi Arabic',
      name: 'appFontsNotoKufiArabic',
      desc: '',
      args: [],
    );
  }

  /// `Material`
  String get appSchemeMaterial {
    return Intl.message(
      'Material',
      name: 'appSchemeMaterial',
      desc: '',
      args: [],
    );
  }

  /// `Material HC`
  String get appSchemeMaterialHc {
    return Intl.message(
      'Material HC',
      name: 'appSchemeMaterialHc',
      desc: '',
      args: [],
    );
  }

  /// `Blue`
  String get appSchemeBlue {
    return Intl.message(
      'Blue',
      name: 'appSchemeBlue',
      desc: '',
      args: [],
    );
  }

  /// `Indigo`
  String get appSchemeIndigo {
    return Intl.message(
      'Indigo',
      name: 'appSchemeIndigo',
      desc: '',
      args: [],
    );
  }

  /// `Hippie Blue`
  String get appSchemeHippieBlue {
    return Intl.message(
      'Hippie Blue',
      name: 'appSchemeHippieBlue',
      desc: '',
      args: [],
    );
  }

  /// `Aqua Blue`
  String get appSchemeAquaBlue {
    return Intl.message(
      'Aqua Blue',
      name: 'appSchemeAquaBlue',
      desc: '',
      args: [],
    );
  }

  /// `Brand Blue`
  String get appSchemeBrandBlue {
    return Intl.message(
      'Brand Blue',
      name: 'appSchemeBrandBlue',
      desc: '',
      args: [],
    );
  }

  /// `Deep Blue`
  String get appSchemeDeepBlue {
    return Intl.message(
      'Deep Blue',
      name: 'appSchemeDeepBlue',
      desc: '',
      args: [],
    );
  }

  /// `Sakura`
  String get appSchemeSakura {
    return Intl.message(
      'Sakura',
      name: 'appSchemeSakura',
      desc: '',
      args: [],
    );
  }

  /// `Mandy Red`
  String get appSchemeMandyRed {
    return Intl.message(
      'Mandy Red',
      name: 'appSchemeMandyRed',
      desc: '',
      args: [],
    );
  }

  /// `Red`
  String get appSchemeRed {
    return Intl.message(
      'Red',
      name: 'appSchemeRed',
      desc: '',
      args: [],
    );
  }

  /// `Red Wine`
  String get appSchemeRedWine {
    return Intl.message(
      'Red Wine',
      name: 'appSchemeRedWine',
      desc: '',
      args: [],
    );
  }

  /// `Purple Brown`
  String get appSchemePurpleBrown {
    return Intl.message(
      'Purple Brown',
      name: 'appSchemePurpleBrown',
      desc: '',
      args: [],
    );
  }

  /// `Green`
  String get appSchemeGreen {
    return Intl.message(
      'Green',
      name: 'appSchemeGreen',
      desc: '',
      args: [],
    );
  }

  /// `Money`
  String get appSchemeMoney {
    return Intl.message(
      'Money',
      name: 'appSchemeMoney',
      desc: '',
      args: [],
    );
  }

  /// `Jungle`
  String get appSchemeJungle {
    return Intl.message(
      'Jungle',
      name: 'appSchemeJungle',
      desc: '',
      args: [],
    );
  }

  /// `Grey Law`
  String get appSchemeGreyLaw {
    return Intl.message(
      'Grey Law',
      name: 'appSchemeGreyLaw',
      desc: '',
      args: [],
    );
  }

  /// `Wasabi`
  String get appSchemeWasabi {
    return Intl.message(
      'Wasabi',
      name: 'appSchemeWasabi',
      desc: '',
      args: [],
    );
  }

  /// `Gold`
  String get appSchemeGold {
    return Intl.message(
      'Gold',
      name: 'appSchemeGold',
      desc: '',
      args: [],
    );
  }

  /// `Mango`
  String get appSchemeMango {
    return Intl.message(
      'Mango',
      name: 'appSchemeMango',
      desc: '',
      args: [],
    );
  }

  /// `Amber`
  String get appSchemeAmber {
    return Intl.message(
      'Amber',
      name: 'appSchemeAmber',
      desc: '',
      args: [],
    );
  }

  /// `Vesuvius Burn`
  String get appSchemeVesuviusBurn {
    return Intl.message(
      'Vesuvius Burn',
      name: 'appSchemeVesuviusBurn',
      desc: '',
      args: [],
    );
  }

  /// `Deep Purple`
  String get appSchemeDeepPurple {
    return Intl.message(
      'Deep Purple',
      name: 'appSchemeDeepPurple',
      desc: '',
      args: [],
    );
  }

  /// `Ebony Clay`
  String get appSchemeEbonyClay {
    return Intl.message(
      'Ebony Clay',
      name: 'appSchemeEbonyClay',
      desc: '',
      args: [],
    );
  }

  /// `Barossa`
  String get appSchemeBarossa {
    return Intl.message(
      'Barossa',
      name: 'appSchemeBarossa',
      desc: '',
      args: [],
    );
  }

  /// `Shark`
  String get appSchemeShark {
    return Intl.message(
      'Shark',
      name: 'appSchemeShark',
      desc: '',
      args: [],
    );
  }

  /// `Big Stone`
  String get appSchemeBigStone {
    return Intl.message(
      'Big Stone',
      name: 'appSchemeBigStone',
      desc: '',
      args: [],
    );
  }

  /// `Damask`
  String get appSchemeDamask {
    return Intl.message(
      'Damask',
      name: 'appSchemeDamask',
      desc: '',
      args: [],
    );
  }

  /// `Bahama Blue`
  String get appSchemeBahamaBlue {
    return Intl.message(
      'Bahama Blue',
      name: 'appSchemeBahamaBlue',
      desc: '',
      args: [],
    );
  }

  /// `Mallard Green`
  String get appSchemeMallardGreen {
    return Intl.message(
      'Mallard Green',
      name: 'appSchemeMallardGreen',
      desc: '',
      args: [],
    );
  }

  /// `Espresso`
  String get appSchemeEspresso {
    return Intl.message(
      'Espresso',
      name: 'appSchemeEspresso',
      desc: '',
      args: [],
    );
  }

  /// `Outer Space`
  String get appSchemeOuterSpace {
    return Intl.message(
      'Outer Space',
      name: 'appSchemeOuterSpace',
      desc: '',
      args: [],
    );
  }

  /// `Blue Whale`
  String get appSchemeBlueWhale {
    return Intl.message(
      'Blue Whale',
      name: 'appSchemeBlueWhale',
      desc: '',
      args: [],
    );
  }

  /// `San Juan Blue`
  String get appSchemeSanJuanBlue {
    return Intl.message(
      'San Juan Blue',
      name: 'appSchemeSanJuanBlue',
      desc: '',
      args: [],
    );
  }

  /// `Rosewood`
  String get appSchemeRosewood {
    return Intl.message(
      'Rosewood',
      name: 'appSchemeRosewood',
      desc: '',
      args: [],
    );
  }

  /// `Blumine Blue`
  String get appSchemeBlumineBlue {
    return Intl.message(
      'Blumine Blue',
      name: 'appSchemeBlumineBlue',
      desc: '',
      args: [],
    );
  }

  /// `Flutter Dash`
  String get appSchemeFlutterDash {
    return Intl.message(
      'Flutter Dash',
      name: 'appSchemeFlutterDash',
      desc: '',
      args: [],
    );
  }

  /// `Material Baseline`
  String get appSchemeMaterialBaseline {
    return Intl.message(
      'Material Baseline',
      name: 'appSchemeMaterialBaseline',
      desc: '',
      args: [],
    );
  }

  /// `Verdun Hemlock`
  String get appSchemeVerdunHemlock {
    return Intl.message(
      'Verdun Hemlock',
      name: 'appSchemeVerdunHemlock',
      desc: '',
      args: [],
    );
  }

  /// `Dell Genoa`
  String get appSchemeDellGenoa {
    return Intl.message(
      'Dell Genoa',
      name: 'appSchemeDellGenoa',
      desc: '',
      args: [],
    );
  }

  /// `Red M3`
  String get appSchemeRedM3 {
    return Intl.message(
      'Red M3',
      name: 'appSchemeRedM3',
      desc: '',
      args: [],
    );
  }

  /// `Pink M3`
  String get appSchemePinkM3 {
    return Intl.message(
      'Pink M3',
      name: 'appSchemePinkM3',
      desc: '',
      args: [],
    );
  }

  /// `Purple M3`
  String get appSchemePurpleM3 {
    return Intl.message(
      'Purple M3',
      name: 'appSchemePurpleM3',
      desc: '',
      args: [],
    );
  }

  /// `Indigo M3`
  String get appSchemeIndigoM3 {
    return Intl.message(
      'Indigo M3',
      name: 'appSchemeIndigoM3',
      desc: '',
      args: [],
    );
  }

  /// `Blue M3`
  String get appSchemeBlueM3 {
    return Intl.message(
      'Blue M3',
      name: 'appSchemeBlueM3',
      desc: '',
      args: [],
    );
  }

  /// `Cyan M3`
  String get appSchemeCyanM3 {
    return Intl.message(
      'Cyan M3',
      name: 'appSchemeCyanM3',
      desc: '',
      args: [],
    );
  }

  /// `Teal M3`
  String get appSchemeTealM3 {
    return Intl.message(
      'Teal M3',
      name: 'appSchemeTealM3',
      desc: '',
      args: [],
    );
  }

  /// `Green M3`
  String get appSchemeGreenM3 {
    return Intl.message(
      'Green M3',
      name: 'appSchemeGreenM3',
      desc: '',
      args: [],
    );
  }

  /// `Lime M3`
  String get appSchemeLimeM3 {
    return Intl.message(
      'Lime M3',
      name: 'appSchemeLimeM3',
      desc: '',
      args: [],
    );
  }

  /// `Yellow M3`
  String get appSchemeYellowM3 {
    return Intl.message(
      'Yellow M3',
      name: 'appSchemeYellowM3',
      desc: '',
      args: [],
    );
  }

  /// `Orange M3`
  String get appSchemeOrangeM3 {
    return Intl.message(
      'Orange M3',
      name: 'appSchemeOrangeM3',
      desc: '',
      args: [],
    );
  }

  /// `Deep Orange M3`
  String get appSchemeDeepOrangeM3 {
    return Intl.message(
      'Deep Orange M3',
      name: 'appSchemeDeepOrangeM3',
      desc: '',
      args: [],
    );
  }

  /// `Black & White`
  String get appSchemeBlackWhite {
    return Intl.message(
      'Black & White',
      name: 'appSchemeBlackWhite',
      desc: '',
      args: [],
    );
  }

  /// `Greys`
  String get appSchemeGreys {
    return Intl.message(
      'Greys',
      name: 'appSchemeGreys',
      desc: '',
      args: [],
    );
  }

  /// `Sepia`
  String get appSchemeSepia {
    return Intl.message(
      'Sepia',
      name: 'appSchemeSepia',
      desc: '',
      args: [],
    );
  }

  /// `Shad Blue`
  String get appSchemeShadBlue {
    return Intl.message(
      'Shad Blue',
      name: 'appSchemeShadBlue',
      desc: '',
      args: [],
    );
  }

  /// `Shad Gray`
  String get appSchemeShadGray {
    return Intl.message(
      'Shad Gray',
      name: 'appSchemeShadGray',
      desc: '',
      args: [],
    );
  }

  /// `Shad Green`
  String get appSchemeShadGreen {
    return Intl.message(
      'Shad Green',
      name: 'appSchemeShadGreen',
      desc: '',
      args: [],
    );
  }

  /// `Shad Neutral`
  String get appSchemeShadNeutral {
    return Intl.message(
      'Shad Neutral',
      name: 'appSchemeShadNeutral',
      desc: '',
      args: [],
    );
  }

  /// `Shad Orange`
  String get appSchemeShadOrange {
    return Intl.message(
      'Shad Orange',
      name: 'appSchemeShadOrange',
      desc: '',
      args: [],
    );
  }

  /// `Shad Red`
  String get appSchemeShadRed {
    return Intl.message(
      'Shad Red',
      name: 'appSchemeShadRed',
      desc: '',
      args: [],
    );
  }

  /// `Shad Rose`
  String get appSchemeShadRose {
    return Intl.message(
      'Shad Rose',
      name: 'appSchemeShadRose',
      desc: '',
      args: [],
    );
  }

  /// `Shad Slate`
  String get appSchemeShadSlate {
    return Intl.message(
      'Shad Slate',
      name: 'appSchemeShadSlate',
      desc: '',
      args: [],
    );
  }

  /// `Shad Stone`
  String get appSchemeShadStone {
    return Intl.message(
      'Shad Stone',
      name: 'appSchemeShadStone',
      desc: '',
      args: [],
    );
  }

  /// `Shad Violet`
  String get appSchemeShadViolet {
    return Intl.message(
      'Shad Violet',
      name: 'appSchemeShadViolet',
      desc: '',
      args: [],
    );
  }

  /// `Shad Yellow`
  String get appSchemeShadYellow {
    return Intl.message(
      'Shad Yellow',
      name: 'appSchemeShadYellow',
      desc: '',
      args: [],
    );
  }

  /// `Shad Zinc`
  String get appSchemeShadZinc {
    return Intl.message(
      'Shad Zinc',
      name: 'appSchemeShadZinc',
      desc: '',
      args: [],
    );
  }

  /// `Work`
  String get predefinedCategoriesWork {
    return Intl.message(
      'Work',
      name: 'predefinedCategoriesWork',
      desc: '',
      args: [],
    );
  }

  /// `Personal`
  String get predefinedCategoriesPersonal {
    return Intl.message(
      'Personal',
      name: 'predefinedCategoriesPersonal',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get predefinedCategoriesHealth {
    return Intl.message(
      'Health',
      name: 'predefinedCategoriesHealth',
      desc: '',
      args: [],
    );
  }

  /// `Finance`
  String get predefinedCategoriesFinance {
    return Intl.message(
      'Finance',
      name: 'predefinedCategoriesFinance',
      desc: '',
      args: [],
    );
  }

  /// `Family`
  String get predefinedCategoriesFamily {
    return Intl.message(
      'Family',
      name: 'predefinedCategoriesFamily',
      desc: '',
      args: [],
    );
  }

  /// `Shopping`
  String get predefinedCategoriesShopping {
    return Intl.message(
      'Shopping',
      name: 'predefinedCategoriesShopping',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get predefinedCategoriesEducation {
    return Intl.message(
      'Education',
      name: 'predefinedCategoriesEducation',
      desc: '',
      args: [],
    );
  }

  /// `Reschedule Task`
  String get rescheduleTask {
    return Intl.message(
      'Reschedule Task',
      name: 'rescheduleTask',
      desc: '',
      args: [],
    );
  }

  /// `Uncategorized`
  String get uncategorized {
    return Intl.message(
      'Uncategorized',
      name: 'uncategorized',
      desc: '',
      args: [],
    );
  }

  /// `Mark as Complete`
  String get markAsComplete {
    return Intl.message(
      'Mark as Complete',
      name: 'markAsComplete',
      desc: '',
      args: [],
    );
  }

  /// `Reschedule`
  String get reschedule {
    return Intl.message(
      'Reschedule',
      name: 'reschedule',
      desc: '',
      args: [],
    );
  }

  /// `Move to Trash`
  String get moveToTrash {
    return Intl.message(
      'Move to Trash',
      name: 'moveToTrash',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get restoreTaskAction {
    return Intl.message(
      'Restore',
      name: 'restoreTaskAction',
      desc: '',
      args: [],
    );
  }

  /// `Task Details`
  String get taskDetails {
    return Intl.message(
      'Task Details',
      name: 'taskDetails',
      desc: '',
      args: [],
    );
  }

  /// `Created at  `
  String get createdAt {
    return Intl.message(
      'Created at  ',
      name: 'createdAt',
      desc: '',
      args: [],
    );
  }

  /// `\nCompleted at  `
  String get completedAt {
    return Intl.message(
      '\nCompleted at  ',
      name: 'completedAt',
      desc: '',
      args: [],
    );
  }

  /// `\nUpdated at  `
  String get updatedAt {
    return Intl.message(
      '\nUpdated at  ',
      name: 'updatedAt',
      desc: '',
      args: [],
    );
  }

  /// `\nDeleted at  `
  String get deletedAt {
    return Intl.message(
      '\nDeleted at  ',
      name: 'deletedAt',
      desc: '',
      args: [],
    );
  }

  /// `Edit Task`
  String get editTaskAppBar {
    return Intl.message(
      'Edit Task',
      name: 'editTaskAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Edit Full Name`
  String get editFullNameAppBar {
    return Intl.message(
      'Edit Full Name',
      name: 'editFullNameAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Edit Email`
  String get editEmailAppBar {
    return Intl.message(
      'Edit Email',
      name: 'editEmailAppBar',
      desc: '',
      args: [],
    );
  }

  /// `New Email`
  String get newEmailTextField {
    return Intl.message(
      'New Email',
      name: 'newEmailTextField',
      desc: '',
      args: [],
    );
  }

  /// `Enter new email`
  String get newEmailTextFieldHint {
    return Intl.message(
      'Enter new email',
      name: 'newEmailTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Edit Password`
  String get editPasswordAppBar {
    return Intl.message(
      'Edit Password',
      name: 'editPasswordAppBar',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Connected Accounts`
  String get connectedAccountsAppBar {
    return Intl.message(
      'Connected Accounts',
      name: 'connectedAccountsAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Disconnect`
  String get disconnect {
    return Intl.message(
      'Disconnect',
      name: 'disconnect',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect {
    return Intl.message(
      'Connect',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Not connected`
  String get notConnected {
    return Intl.message(
      'Not connected',
      name: 'notConnected',
      desc: '',
      args: [],
    );
  }

  /// `Delete Subtask`
  String get deleteSubtaskDialogTitle {
    return Intl.message(
      'Delete Subtask',
      name: 'deleteSubtaskDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this subtask?`
  String get deleteSubtaskDialogDescription {
    return Intl.message(
      'Are you sure you want to delete this subtask?',
      name: 'deleteSubtaskDialogDescription',
      desc: '',
      args: [],
    );
  }

  /// `Delete Task`
  String get deleteTaskDialogTitle {
    return Intl.message(
      'Delete Task',
      name: 'deleteTaskDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this task?`
  String get deleteTaskDialogDescription {
    return Intl.message(
      'Are you sure you want to delete this task?',
      name: 'deleteTaskDialogDescription',
      desc: '',
      args: [],
    );
  }

  /// `Todo List`
  String get todoList {
    return Intl.message(
      'Todo List',
      name: 'todoList',
      desc: '',
      args: [],
    );
  }

  /// `Media ({count})`
  String mediaAttachments(Object count) {
    return Intl.message(
      'Media ($count)',
      name: 'mediaAttachments',
      desc: '',
      args: [count],
    );
  }

  /// `Add Attachment`
  String get addAttachment {
    return Intl.message(
      'Add Attachment',
      name: 'addAttachment',
      desc: '',
      args: [],
    );
  }

  /// `Files ({count})`
  String fileAttachments(Object count) {
    return Intl.message(
      'Files ($count)',
      name: 'fileAttachments',
      desc: '',
      args: [count],
    );
  }

  /// `Edit`
  String get editTaskAction {
    return Intl.message(
      'Edit',
      name: 'editTaskAction',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteTaskAction {
    return Intl.message(
      'Delete',
      name: 'deleteTaskAction',
      desc: '',
      args: [],
    );
  }

  /// `Add File`
  String get addFile {
    return Intl.message(
      'Add File',
      name: 'addFile',
      desc: '',
      args: [],
    );
  }

  /// `Rename`
  String get rename {
    return Intl.message(
      'Rename',
      name: 'rename',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get tabAll {
    return Intl.message(
      'All',
      name: 'tabAll',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get tabToday {
    return Intl.message(
      'Today',
      name: 'tabToday',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get todayFilter {
    return Intl.message(
      'Today',
      name: 'todayFilter',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get tabTomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'tabTomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get tomorrowFilter {
    return Intl.message(
      'Tomorrow',
      name: 'tomorrowFilter',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get tabUpcoming {
    return Intl.message(
      'Upcoming',
      name: 'tabUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `What are you looking for?`
  String get searchBarPlaceholder {
    return Intl.message(
      'What are you looking for?',
      name: 'searchBarPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `This Week`
  String get thisWeekFilter {
    return Intl.message(
      'This Week',
      name: 'thisWeekFilter',
      desc: '',
      args: [],
    );
  }

  /// `This Month`
  String get thisMonthFilter {
    return Intl.message(
      'This Month',
      name: 'thisMonthFilter',
      desc: '',
      args: [],
    );
  }

  /// `This Year`
  String get thisYearFilter {
    return Intl.message(
      'This Year',
      name: 'thisYearFilter',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get statusFilter {
    return Intl.message(
      'Status',
      name: 'statusFilter',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sortBy {
    return Intl.message(
      'Sort By',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get okModalBottomSheet {
    return Intl.message(
      'Ok',
      name: 'okModalBottomSheet',
      desc: '',
      args: [],
    );
  }

  /// `Unlock`
  String get unlock {
    return Intl.message(
      'Unlock',
      name: 'unlock',
      desc: '',
      args: [],
    );
  }

  /// `Enter your PIN`
  String get enterYourPin {
    return Intl.message(
      'Enter your PIN',
      name: 'enterYourPin',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Password`
  String get enterYourPassword {
    return Intl.message(
      'Enter your Password',
      name: 'enterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Too many attempts. Please wait...`
  String get tooManyAttempts {
    return Intl.message(
      'Too many attempts. Please wait...',
      name: 'tooManyAttempts',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect {lockType}. Try again.`
  String incorrectLockType(Object lockType) {
    return Intl.message(
      'Incorrect $lockType. Try again.',
      name: 'incorrectLockType',
      desc: '',
      args: [lockType],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Total Tasks`
  String get totalTasks {
    return Intl.message(
      'Total Tasks',
      name: 'totalTasks',
      desc: '',
      args: [],
    );
  }

  /// `App Lock`
  String get appLockAppBar {
    return Intl.message(
      'App Lock',
      name: 'appLockAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Medium-high security, `
  String get mediumHighSecurity {
    return Intl.message(
      'Medium-high security, ',
      name: 'mediumHighSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Current lock type`
  String get currentLockType {
    return Intl.message(
      'Current lock type',
      name: 'currentLockType',
      desc: '',
      args: [],
    );
  }

  /// `High security, `
  String get highSecurity {
    return Intl.message(
      'High security, ',
      name: 'highSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Auto-lock After`
  String get autoLockAfter {
    return Intl.message(
      'Auto-lock After',
      name: 'autoLockAfter',
      desc: '',
      args: [],
    );
  }

  /// `App Theme`
  String get showThemeModeSelectionModalSheetTitle {
    return Intl.message(
      'App Theme',
      name: 'showThemeModeSelectionModalSheetTitle',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get ThemeModeSelectionOption1 {
    return Intl.message(
      'System',
      name: 'ThemeModeSelectionOption1',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get ThemeModeSelectionOption2 {
    return Intl.message(
      'Light',
      name: 'ThemeModeSelectionOption2',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get ThemeModeSelectionOption3 {
    return Intl.message(
      'Dark',
      name: 'ThemeModeSelectionOption3',
      desc: '',
      args: [],
    );
  }

  /// `App Language`
  String get showLanguageSelectionModalSheetTitle {
    return Intl.message(
      'App Language',
      name: 'showLanguageSelectionModalSheetTitle',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get LanguageSelectionOption1 {
    return Intl.message(
      'English',
      name: 'LanguageSelectionOption1',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get LanguageSelectionOption2 {
    return Intl.message(
      'Arabic',
      name: 'LanguageSelectionOption2',
      desc: '',
      args: [],
    );
  }

  /// `dueDate`
  String get selectedSortField {
    return Intl.message(
      'dueDate',
      name: 'selectedSortField',
      desc: '',
      args: [],
    );
  }

  /// `Ascending`
  String get ascendingLabel {
    return Intl.message(
      'Ascending',
      name: 'ascendingLabel',
      desc: '',
      args: [],
    );
  }

  /// `Descending`
  String get descendingLabel {
    return Intl.message(
      'Descending',
      name: 'descendingLabel',
      desc: '',
      args: [],
    );
  }

  /// `dueDate`
  String get tempSortFieldDueDate {
    return Intl.message(
      'dueDate',
      name: 'tempSortFieldDueDate',
      desc: '',
      args: [],
    );
  }

  /// `dueDate`
  String get sortByLabel1 {
    return Intl.message(
      'dueDate',
      name: 'sortByLabel1',
      desc: '',
      args: [],
    );
  }

  /// `priority`
  String get tempSortFieldPriority {
    return Intl.message(
      'priority',
      name: 'tempSortFieldPriority',
      desc: '',
      args: [],
    );
  }

  /// `priority`
  String get sortByLabel2 {
    return Intl.message(
      'priority',
      name: 'sortByLabel2',
      desc: '',
      args: [],
    );
  }

  /// `alphabet`
  String get tempSortFieldAlphabet {
    return Intl.message(
      'alphabet',
      name: 'tempSortFieldAlphabet',
      desc: '',
      args: [],
    );
  }

  /// `alphabet`
  String get sortByLabel3 {
    return Intl.message(
      'alphabet',
      name: 'sortByLabel3',
      desc: '',
      args: [],
    );
  }

  /// `Low to High`
  String get ascendingLowToHigh {
    return Intl.message(
      'Low to High',
      name: 'ascendingLowToHigh',
      desc: '',
      args: [],
    );
  }

  /// `High to Low`
  String get descendingHighToLow {
    return Intl.message(
      'High to Low',
      name: 'descendingHighToLow',
      desc: '',
      args: [],
    );
  }

  /// `App Font`
  String get showFontSelectionModalSheetTitle {
    return Intl.message(
      'App Font',
      name: 'showFontSelectionModalSheetTitle',
      desc: '',
      args: [],
    );
  }

  /// `This font will be applied to all screens`
  String get fontSelectionModalSheetDescription {
    return Intl.message(
      'This font will be applied to all screens',
      name: 'fontSelectionModalSheetDescription',
      desc: '',
      args: [],
    );
  }

  /// `App Badge Style`
  String get showBadgeSelectionModalSheetTitle {
    return Intl.message(
      'App Badge Style',
      name: 'showBadgeSelectionModalSheetTitle',
      desc: '',
      args: [],
    );
  }

  /// `Dot`
  String get BadgeStyleSelectionOption1 {
    return Intl.message(
      'Dot',
      name: 'BadgeStyleSelectionOption1',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get BadgeStyleSelectionOption2 {
    return Intl.message(
      'Number',
      name: 'BadgeStyleSelectionOption2',
      desc: '',
      args: [],
    );
  }

  /// `Scheme Color`
  String get showSchemeColorSelectionModalSheetTitle {
    return Intl.message(
      'Scheme Color',
      name: 'showSchemeColorSelectionModalSheetTitle',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get taskTitle {
    return Intl.message(
      'Title',
      name: 'taskTitle',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get taskDescription {
    return Intl.message(
      'Description',
      name: 'taskDescription',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get taskStatus {
    return Intl.message(
      'Status',
      name: 'taskStatus',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get taskTags {
    return Intl.message(
      'Tags',
      name: 'taskTags',
      desc: '',
      args: [],
    );
  }

  /// `Due Date`
  String get taskDueDate {
    return Intl.message(
      'Due Date',
      name: 'taskDueDate',
      desc: '',
      args: [],
    );
  }

  /// `Due Time`
  String get taskDueTime {
    return Intl.message(
      'Due Time',
      name: 'taskDueTime',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get taskReminder {
    return Intl.message(
      'Reminder',
      name: 'taskReminder',
      desc: '',
      args: [],
    );
  }

  /// `Repeat`
  String get taskRepeat {
    return Intl.message(
      'Repeat',
      name: 'taskRepeat',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
