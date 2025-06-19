import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
import 'package:taskify/core/utils/task_dialog_utils.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_text_form_field.dart';
import 'package:taskify/core/widgets/field_item.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:taskify/generated/l10n.dart';

Future<void> rescheduleTask(
  BuildContext context,
  String formattedDate,
  TaskEntity taskEntity,
  Map<String, dynamic> data,
  String selectedTaskStartTime,
  String selectedTaskEndTime,
  void Function(String) handlePickedDate,
  void Function(String) handlePickedStartTime,
  void Function(String) handlePickedEndTime,
) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: AppColors.scaffoldLightBackgroundColor,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              FieldItem(
                label: S.of(context).dueDateTextField,
                widget: GestureDetector(
                  onTap: () async {
                    bool isOverdueTask =
                        taskEntity.status == TaskStatus.overdue;
                    DateTime? pickedDate =
                        await TaskDialogUtils.showCustomDatePickerDialog(
                      context: context,
                      initialDate: DateTime.parse(
                        formattedDate,
                      ),
                      isOverdueTask: isOverdueTask,
                    );
                    if (pickedDate != null) {
                      handlePickedDate(DateTimeUtils.formatDate(pickedDate));
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      hintText: formattedDate,
                      isReadOnly: true,
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: FieldItem(
                      label: S.of(context).startTimeTextField,
                      widget: GestureDetector(
                        onTap: () async {
                          String? pickedStartTime =
                              await TaskDialogUtils.showCustomTimePickerDialog(
                            isStartTime: true,
                            context: context,
                            initialTime: selectedTaskStartTime,
                          );
                          if (pickedStartTime != null) {
                            handlePickedStartTime(pickedStartTime);
                          }
                        },
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                            hintText: selectedTaskStartTime,
                            isReadOnly: true,
                            suffixIcon: const Icon(Icons.access_time_outlined),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FieldItem(
                      label: S.of(context).endTimeTextField,
                      widget: GestureDetector(
                        onTap: () async {
                          String? pickedEndTime =
                              await TaskDialogUtils.showCustomTimePickerDialog(
                            isStartTime: false,
                            context: context,
                            initialTime: selectedTaskEndTime,
                          );
                          if (pickedEndTime != null) {
                            handlePickedEndTime(pickedEndTime);
                          }
                        },
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                            hintText: selectedTaskEndTime,
                            isReadOnly: true,
                            suffixIcon: const Icon(Icons.access_time_outlined),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: S.of(context).rescheduleTask,
                onPressed: () async {
                  await context.read<TaskCubit>().updateTask(
                        userId: taskEntity.userId,
                        data: data,
                        taskId: taskEntity.id,
                      );
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      );
    },
  );
}
