import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/features/home/presentation/manager/cubits/attachments_cubit/attachment_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:taskify/generated/l10n.dart';

Future<void> deleteTask(
  BuildContext context,
  String userId,
  String taskId,
  List<String> dataPaths,
  void Function()? onFinishAction,
) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      title: Text(S.of(context).deleteTaskDialogTitle),
      content: Text(S.of(context).deleteTaskDialogDescription),
      actions: [
        TextButton(
          child: Text(
            S.of(context).cancelModalSheetButton,
            style: TextStyle(color: AppColors.primaryLightColor),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(
            S.of(context).deleteModalSheetButton,
            style: TextStyle(color: AppColors.primaryLightColor),
          ),
          onPressed: () async {
            await context.read<AttachmentCubit>().deleteAttachmentsFromStorage(
                  taskId: taskId,
                  dataPaths: dataPaths,
                );
            if (!context.mounted) return;
            await context.read<TaskCubit>().deleteSingleTask(
                  userId: userId,
                  taskId: taskId,
                );
            if (!context.mounted) return;
            Navigator.pop(context);
            onFinishAction?.call();
          },
        ),
      ],
    ),
  );
}
