import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:taskify/core/functions/filter_tasks.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/domain/entities/pie_chart_item_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/presentation/widgets/pie_chart_item.dart';
import 'package:taskify/generated/l10n.dart';

class CustomPieChart extends StatefulWidget {
  const CustomPieChart(
      {super.key, required this.tasks, required this.selectedValue});
  final List<TaskEntity> tasks;
  final String selectedValue;

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int touchedIndex = -1;
  List<TaskEntity> filterTasksByTimeframe() {
    DateTime now = DateTime.now();
    switch (widget.selectedValue) {
      case 'Daily':
        return widget.tasks
            .where((task) =>
                task.dueDate.day == now.day &&
                task.dueDate.month == now.month &&
                task.dueDate.year == now.year)
            .toList();
      case 'Weekly':
        return widget.tasks
            .where(
                (task) => task.dueDate.isAfter(now.subtract(Duration(days: 7))))
            .toList();
      case 'Monthly':
        return widget.tasks
            .where((task) =>
                task.dueDate.month == now.month &&
                task.dueDate.year == now.year)
            .toList();
      default:
        return widget.tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = filterTasksByTimeframe();
    final totalTasks = filteredTasks.length;
    final completedTasks = filterTasks(filteredTasks, 'completed');
    final inProgressTasks = filterTasks(filteredTasks, 'inProgress');
    final overdueTasks = filterTasks(filteredTasks, 'overdue');
    final completionPercentage = totalTasks > 0
        ? (completedTasks.length / totalTasks * 100).toStringAsFixed(2)
        : "0.00";
    final inProgressPercentage = totalTasks > 0
        ? (inProgressTasks.length / totalTasks * 100).toStringAsFixed(2)
        : "0.00";
    final overduePercentage = totalTasks > 0
        ? (overdueTasks.length / totalTasks * 100).toStringAsFixed(2)
        : "0.00";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: PieChart(
                duration: Duration(milliseconds: 300),
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue,
                      showTitle: false,
                      value: totalTasks > 0
                          ? inProgressTasks.length / totalTasks
                          : 0.0,
                      radius: touchedIndex == 0 ? 40 : 30,
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      showTitle: false,
                      value: totalTasks > 0
                          ? completedTasks.length / totalTasks
                          : 0.0,
                      radius: touchedIndex == 1 ? 40 : 30,
                    ),
                    PieChartSectionData(
                      color: AppColors.errorColor,
                      showTitle: false,
                      value: totalTasks > 0
                          ? overdueTasks.length / totalTasks
                          : 0.0,
                      radius: touchedIndex == 2 ? 40 : 30,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  '${widget.tasks.length}',
                  style: AppTextStyles.bold24,
                ),
                Text(
                  S.of(context).totalTasks,
                  style: AppTextStyles.regular16,
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            PieChartItem(
              pieChartItemEntity: PieChartItemEntity(
                title: S.of(context).taskStatusCompleted,
                progress: '$completionPercentage%',
                color: Colors.green,
              ),
            ),
            PieChartItem(
              pieChartItemEntity: PieChartItemEntity(
                title: S.of(context).taskStatusInProgress,
                progress: '$inProgressPercentage%',
                color: Colors.blue,
              ),
            ),
            PieChartItem(
              pieChartItemEntity: PieChartItemEntity(
                title: S.of(context).taskStatusOverdue,
                progress: '$overduePercentage%',
                color: AppColors.errorColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
