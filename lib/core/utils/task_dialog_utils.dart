import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
import 'package:taskify/core/widgets/custom_text_form_field.dart';
import 'package:taskify/features/home/domain/entities/task/task_category_entity.dart';

class TaskDialogUtils {
  static Future<String?> showCustomTimePickerDialog({
    required bool isStartTime,
    required BuildContext context,
    required String initialTime,
    String? compareWithTime,
  }) async {
    TimeOfDay initialTimeOfDay = TimeOfDay.now();
    try {
      initialTimeOfDay =
          TimeOfDay.fromDateTime(DateTimeUtils.parseTime(initialTime));
    } catch (e) {
      log("Error parsing time: $e");
    }

    TimeOfDay? pickedTime = await showTimePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryLightColor,
              onPrimary: Colors.white,
              secondary: AppColors.primaryLightColor,
              onSecondary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: initialTimeOfDay,
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      if (isStartTime) {
        if (selectedTime.isBefore(now)) {
          if (!context.mounted) return null;
          buildSnackbar(context, message: "Start time cannot be in the past.");
          return null;
        }
      } else {
        if (compareWithTime != null) {
          final startTime = DateTimeUtils.parseTime(compareWithTime);
          if (selectedTime.isBefore(startTime)) {
            if (!context.mounted) return null;
            buildSnackbar(context,
                message: "End time must be after start time.");
            return null;
          }
        }
      }

      if (!context.mounted) return null;
      return pickedTime.format(context);
    } else {
      return null;
    }
  }

  static Future<DateTime?> showCustomDatePickerDialog({
    required BuildContext context,
    DateTime? initialDate,
    bool isOverdueTask = false,
  }) async {
    DateTime now = DateTime.now();
    DateTime firstDate = isOverdueTask ? initialDate ?? now : now;
    DateTime lastDate = now.add(const Duration(days: 730));

    DateTime? pickedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryLightColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: initialDate ?? now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (pickedDate != null) {
      return pickedDate;
    } else {
      return null;
    }
  }

  static Future<TaskCategoryEntity?> showCustomCategoryDialog(
      BuildContext context) async {
    String categoryName = 'Uncategorized';
    Color categoryColor = AppColors.greyColor;
    IconData categoryIcon = Icons.help_outline;

    return await showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (statefulContext, setDialogState) => AlertDialog(
          backgroundColor: AppColors.scaffoldLightBackgroundColor,
          title: const Text('Add Custom Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                hintText: 'Category Name',
                onChanged: (value) =>
                    categoryName = value.isNotEmpty ? value : 'Uncategorized',
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text(
                      'Select Icon',
                      style: TextStyle(color: AppColors.primaryLightColor),
                    ),
                    onPressed: () async {
                      IconData? icon =
                          await showCustomIconPickerDialog(context);
                      setDialogState(() {
                        categoryIcon = icon ?? Icons.help_outline;
                      });
                    },
                  ),
                  Icon(categoryIcon, color: AppColors.primaryLightColor),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      Color? pickedColor = await showCustomColorPickerDialog(
                          context: context, initialColor: categoryColor);
                      setDialogState(() {
                        categoryColor = pickedColor ?? AppColors.greyColor;
                      });
                    },
                    child: const Text(
                      'Select Color',
                      style: TextStyle(color: AppColors.primaryLightColor),
                    ),
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: categoryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.greyColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.primaryLightColor),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (categoryName.isEmpty) {
                  categoryName = 'Uncategorized';
                }

                if (categoryName.isNotEmpty) {
                  var categoriesBox =
                      await Hive.openBox(AppConstants.categoriesBox);
                  bool alreadyExists = categoriesBox.values.any((category) =>
                      category.name == categoryName &&
                      category.icon.codePoint == categoryIcon.codePoint);
                  if (!context.mounted) return;
                  final predefinedCategories =
                      predefinedTaskCategories(context);

                  if (alreadyExists) {
                    if (!context.mounted) return;
                    buildSnackbar(
                      context,
                      message: 'Category name already exists',
                    );
                    Navigator.pop(dialogContext);
                    return;
                  }

                  if (predefinedCategories
                      .any((category) => category['name'] == categoryName)) {
                    if (!context.mounted) return;
                    buildSnackbar(
                      context,
                      message: 'Category name already exists',
                    );
                  } else {
                    await HiveService().addCustomCategory(
                      TaskCategoryEntity(
                        name: categoryName,
                        icon: categoryIcon,
                        color: categoryColor,
                      ),
                    );
                    if (!context.mounted) return;
                    Navigator.pop(
                      dialogContext,
                      TaskCategoryEntity(
                        name: categoryName,
                        icon: categoryIcon,
                        color: categoryColor,
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(color: AppColors.primaryLightColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<Color?> showCustomColorPickerDialog({
    required BuildContext context,
    required Color initialColor,
  }) async {
    Color selectedColor = initialColor;
    HSVColor pickerHsvColor = HSVColor.fromColor(initialColor);

    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.scaffoldLightBackgroundColor,
        title: const Text("Pick a Category Color"),
        content: SingleChildScrollView(
          child: ColorPicker(
            labelTypes: const [
              ColorLabelType.hex,
              ColorLabelType.rgb,
              ColorLabelType.hsv
            ],
            pickerColor: selectedColor,
            pickerHsvColor: pickerHsvColor,
            displayThumbColor: true,
            onColorChanged: (color) {
              selectedColor = color;
            },
            onHsvColorChanged: (hsvColor) {
              selectedColor = hsvColor.toColor();
            },
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppColors.primaryLightColor),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text(
              "Pick",
              style: TextStyle(color: AppColors.primaryLightColor),
            ),
            onPressed: () => Navigator.pop(context, selectedColor),
          ),
        ],
      ),
    );
  }

  static Future<IconData?> showCustomIconPickerDialog(
      BuildContext context) async {
    final entries = customMaterialIcons.entries.toList();
    List<MapEntry<String, int>> filteredIcons = List.from(entries);
    final TextEditingController controller = TextEditingController();

    return await showDialog<IconData>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            void updateSearch(String value) {
              setState(() {
                filteredIcons = entries.where((entry) {
                  return entry.key.toLowerCase().contains(value.toLowerCase());
                }).toList();
              });
            }

            return AlertDialog(
              title: const Text('Select Icon'),
              content: SizedBox(
                width: double.maxFinite,
                height: 400,
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Search icons...',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: updateSearch,
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        itemCount: filteredIcons.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          final iconEntry = filteredIcons[index];
                          final iconData = IconData(
                            iconEntry.value,
                            fontFamily: 'MaterialIcons',
                          );
                          return Tooltip(
                            message: iconEntry.key,
                            child: IconButton(
                              icon: Icon(iconData),
                              onPressed: () => Navigator.pop(context, iconData),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
