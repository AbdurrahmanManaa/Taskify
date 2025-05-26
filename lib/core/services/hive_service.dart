import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/features/home/domain/entities/attachment_entity.dart';
import 'package:taskify/features/home/domain/entities/category_entity.dart';
import 'package:taskify/features/home/domain/entities/sub_task_entity.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';
import 'package:taskify/features/home/domain/entities/user_preferences_entity.dart';

class HiveService {
  static final ValueNotifier<List<CategoryEntity>> categoriesNotifier =
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

  static Future<void> initializeCategories() async {
    var categoriesBox = Hive.box(AppConstants.categoriesBox);
    categoriesNotifier.value = List<CategoryEntity>.from(categoriesBox.values);
  }

  Future<void> addCustomCategory(CategoryEntity category) async {
    var categoriesBox = Hive.box(AppConstants.categoriesBox);
    List<CategoryEntity> existingCategories =
        List<CategoryEntity>.from(categoriesBox.values);

    bool alreadyExists = existingCategories.any((c) =>
        c.name == category.name && c.icon.codePoint == category.icon.codePoint);

    if (!alreadyExists) {
      await categoriesBox.add(category);
      _updateCategoriesNotifier(categoriesBox);
    }
  }

  Future<List<CategoryEntity>> getAllCategories() async {
    var categoriesBox = Hive.box(AppConstants.categoriesBox);
    return List<CategoryEntity>.from(categoriesBox.values);
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

    if (existing != null) return existing;

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

  Future<String?> getCachedFilePath(String fileName) async {
    var fileCacheBox = Hive.box(AppConstants.fileCacheBox);
    final fileData = fileCacheBox.get(fileName);
    return fileData?['filePath'];
  }

  Future<void> setFileCacheData({
    required String fileName,
    required String filePath,
    required String supabasePath,
  }) async {
    var fileCacheBox = Hive.box(AppConstants.fileCacheBox);
    await fileCacheBox.put(fileName, {
      'filePath': filePath,
      'supabasePath': supabasePath,
    });
  }

  Future<void> clearCache() async {
    try {
      Hive.box(AppConstants.userBox).clear();
      Hive.box(AppConstants.taskBox).clear();
      Hive.box(AppConstants.subtaskBox).clear();
      Hive.box(AppConstants.attachmentsBox).clear();
      Hive.box(AppConstants.fileCacheBox).clear();
      Hive.box(AppConstants.categoriesBox).clear();
      Hive.box(AppConstants.userPreferencesBox).clear();
      log("Cache cleared successfully.");
    } catch (e) {
      log("Error clearing cache: $e");
    }
  }

  void _updateCategoriesNotifier(Box categoriesBox) {
    categoriesNotifier.value = List<CategoryEntity>.from(categoriesBox.values);
  }
}
