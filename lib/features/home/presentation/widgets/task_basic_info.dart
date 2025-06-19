import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskify/core/extensions/task_enum_extensions.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
import 'package:taskify/core/utils/schedule_parser.dart';
import 'package:taskify/core/utils/task_ui_helper.dart';
import 'package:taskify/core/widgets/field_item.dart';
import 'package:taskify/core/widgets/field_label.dart';
import 'package:taskify/features/home/domain/entities/task/task_category_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/presentation/widgets/custom_tag_container.dart';
import 'package:taskify/generated/l10n.dart';

class TaskBasicInfo extends StatelessWidget {
  const TaskBasicInfo({
    super.key,
    required this.taskDetails,
  });
  final TaskEntity taskDetails;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateTimeUtils.formatDate(taskDetails.dueDate);
    final statusDetails = TaskUIHelper.getStatusDetails(taskDetails.status);
    final IconData statusIcon = statusDetails['icon'] as IconData;
    final Color statusColor = statusDetails['color'] as Color;
    final Map<String, dynamic> uncategorizedCategory = {
      'name': S.of(context).uncategorized,
      'icon': Icons.help_outline,
      'color': AppColors.greyColor,
    };
    final taskDetailsPriorityLabel = taskDetails.priority.label(context);
    final taskDetailsStatusLabel = taskDetails.status.label(context);
    final predefinedCategories = predefinedTaskCategories(context);

    return Column(
      children: [
        FieldItem(
          label: S.of(context).taskTitle,
          widget: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              taskDetails.title[0].toUpperCase() +
                  taskDetails.title.substring(1),
              style: AppTextStyles.semiBold24,
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (taskDetails.description != null &&
            taskDetails.description!.isNotEmpty)
          FieldItem(
            label: S.of(context).taskDescription,
            widget: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xfff8f9fb),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: AppColors.borderColor,
                ),
              ),
              child: Center(
                child: Text(
                  taskDetails.description!,
                  style: AppTextStyles.medium18,
                ),
              ),
            ),
          ),
        const SizedBox(height: 20),
        Row(
          children: [
            FieldLabel(label: S.of(context).taskStatus),
            const SizedBox(width: 10),
            Icon(
              statusIcon,
              size: 20,
              color: statusColor,
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                taskDetailsStatusLabel,
                style: AppTextStyles.regular16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<List<TaskCategoryEntity>>(
            valueListenable: HiveService.categoriesNotifier,
            builder: (context, customCategories, _) {
              return Wrap(
                spacing: 10,
                runSpacing: 5,
                children: [
                  FieldLabel(label: S.of(context).taskTags),
                  if (taskDetails.categories.isNotEmpty) ...[
                    ...taskDetails.categories.map(
                      (category) {
                        bool isValidCategory = customCategories
                                .any((c) => c.name == category.name) ||
                            predefinedCategories
                                .any((c) => c['name'] == category.name);
                        if (!isValidCategory) {
                          if (customCategories.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: CustomTagContainer(
                                iconColor: uncategorizedCategory['color'],
                                iconCodePoint:
                                    uncategorizedCategory['icon'].codePoint,
                                title: uncategorizedCategory['name'],
                              ),
                            );
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: CustomTagContainer(
                            iconColor: category.color,
                            iconCodePoint: category.icon.codePoint,
                            title: category.name,
                          ),
                        );
                      },
                    ),
                  ] else
                    CustomTagContainer(
                      iconColor: uncategorizedCategory['color'],
                      iconCodePoint: uncategorizedCategory['icon'].codePoint,
                      title: uncategorizedCategory['name'],
                    ),
                  CustomTagContainer(
                    iconColor: TaskUIHelper.getPriorityDetails(
                        taskDetails.priority)['color'],
                    iconCodePoint: TaskUIHelper.getPriorityDetails(
                            taskDetails.priority)['icon']
                        .codePoint,
                    title: taskDetailsPriorityLabel,
                  ),
                ],
              );
            }),
        const SizedBox(height: 20),
        Row(
          children: [
            FieldLabel(label: S.of(context).taskDueDate),
            const SizedBox(width: 10),
            const Icon(Icons.date_range, color: AppColors.primaryLightColor),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                formattedDate,
                style: AppTextStyles.regular16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            FieldLabel(label: S.of(context).taskDueTime),
            const SizedBox(width: 10),
            const Icon(
              FontAwesomeIcons.clock,
              size: 20,
              color: AppColors.primaryLightColor,
            ),
            const SizedBox(width: 5),
            Text(
              '${DateTimeUtils.formatTime(taskDetails.startTime)} - ${DateTimeUtils.formatTime(taskDetails.endTime)}',
              style: AppTextStyles.regular16,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            FieldLabel(label: S.of(context).taskReminder),
            const SizedBox(width: 10),
            const Icon(Icons.notifications, color: AppColors.primaryLightColor),
            const SizedBox(width: 5),
            Text(
              ScheduleParser.formatReminder(
                context,
                taskDetails.reminder,
              ),
              style: AppTextStyles.regular16,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            FieldLabel(label: S.of(context).taskRepeat),
            const SizedBox(width: 10),
            const Icon(Icons.repeat, color: AppColors.primaryLightColor),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                ScheduleParser.formatRepeat(
                  context,
                  taskDetails.repeat,
                ),
                style: AppTextStyles.regular16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
