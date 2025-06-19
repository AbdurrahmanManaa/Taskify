import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/features/home/domain/entities/attachment/attachment_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_category_entity.dart';
import 'package:taskify/features/home/domain/entities/subtask/sub_task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/preferences/user_preferences_entity.dart';

class HiveService {
  static final ValueNotifier<List<TaskCategoryEntity>> categoriesNotifier =
      ValueNotifier([]);

  static final ValueNotifier<UserPreferencesEntity> preferencesNotifier =
      ValueNotifier(UserPreferencesEntity());

  Future<UserEntity?> getUserData() async {
    try {
      var userDataBox = Hive.box(AppConstants.userBox);
      return userDataBox.get(AppConstants.userKey);
    } catch (e) {
      log("Error fetching user data: $e");
      return null;
    }
  }

  Future<void> setUserData(UserEntity userEntity) async {
    var userDataBox = Hive.box(AppConstants.userBox);
    await userDataBox.put(AppConstants.userKey, userEntity);
  }

  Future<List<TaskEntity>> getTaskData() async {
    var taskDataBox = Hive.box(AppConstants.taskBox);
    return List<TaskEntity>.from(taskDataBox.values);
  }

  Future<List<AttachmentEntity>> getattachmentsData() async {
    var attachmentsDataBox = Hive.box(AppConstants.attachmentsBox);
    return List<AttachmentEntity>.from(attachmentsDataBox.values);
  }

  Future<void> setTaskData(List<TaskEntity> taskEntities) async {
    var taskDataBox = Hive.box(AppConstants.taskBox);
    await taskDataBox.putAll({for (var task in taskEntities) task.id: task});
  }

  Future<void> setAttachmentsData(
      List<AttachmentEntity> attachmentsEntities) async {
    var attachmentsDataBox = Hive.box(AppConstants.attachmentsBox);
    await attachmentsDataBox.putAll({
      for (var attachment in attachmentsEntities) attachment.id: attachment
    });
  }

  Future<List<SubtaskEntity>> getSubtaskData() async {
    var subtaskDataBox = Hive.box(AppConstants.subtaskBox);
    return List<SubtaskEntity>.from(subtaskDataBox.values);
  }

  Future<void> setSubtaskData(List<SubtaskEntity> subtaskEntities) async {
    var subtaskDataBox = Hive.box(AppConstants.subtaskBox);
    await subtaskDataBox
        .putAll({for (var subtask in subtaskEntities) subtask.id: subtask});
  }

  Future<void> initializeCategories() async {
    var categoriesBox = Hive.box(AppConstants.categoriesBox);
    categoriesNotifier.value =
        List<TaskCategoryEntity>.from(categoriesBox.values);
  }

  Future<void> addCustomCategory(TaskCategoryEntity category) async {
    var categoriesBox = Hive.box(AppConstants.categoriesBox);
    List<TaskCategoryEntity> existingCategories =
        List<TaskCategoryEntity>.from(categoriesBox.values);

    bool alreadyExists = existingCategories.any((c) =>
        c.name == category.name && c.icon.codePoint == category.icon.codePoint);

    if (!alreadyExists) {
      await categoriesBox.add(category);
      _updateCategoriesNotifier(categoriesBox);
    }
  }

  Future<List<TaskCategoryEntity>> getAllCategories() async {
    var categoriesBox = Hive.box(AppConstants.categoriesBox);
    return List<TaskCategoryEntity>.from(categoriesBox.values);
  }

  Future<void> deleteCategory(String name) async {
    var categoriesBox = Hive.box(AppConstants.categoriesBox);
    final categoryKey = categoriesBox.keys.firstWhere(
      (key) => categoriesBox.get(key).name == name,
      orElse: () => null,
    );
    if (categoryKey != null) {
      await categoriesBox.delete(categoryKey);
      _updateCategoriesNotifier(categoriesBox);
    }
  }

  Future<UserPreferencesEntity> getUserPreferences() async {
    final box = Hive.box(AppConstants.userPreferencesBox);
    final existing = box.get(AppConstants.userPreferencesKey);

    if (existing != null) {
      preferencesNotifier.value = existing;
      return existing;
    }

    final defaultPrefs = UserPreferencesEntity();
    await box.put(AppConstants.userPreferencesKey, defaultPrefs);
    preferencesNotifier.value = defaultPrefs;
    return defaultPrefs;
  }

  Future<void> setUserPreferences(UserPreferencesEntity preferences) async {
    final box = Hive.box(AppConstants.userPreferencesBox);
    await box.put(AppConstants.userPreferencesKey, preferences);
    preferencesNotifier.value = preferences;
  }

  void _updateCategoriesNotifier(Box categoriesBox) {
    categoriesNotifier.value =
        List<TaskCategoryEntity>.from(categoriesBox.values);
  }
}
