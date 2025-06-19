import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:taskify/core/functions/filter_tasks.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/task_ui_helper.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_priority.dart';
import 'package:taskify/generated/l10n.dart';

class CustomBarChart extends StatefulWidget {
  const CustomBarChart(
      {super.key, required this.tasks, required this.selectedValue});
  final List<TaskEntity> tasks;
  final String selectedValue;

  @override
  State<CustomBarChart> createState() => _CustomBarChartState();
}

class _CustomBarChartState extends State<CustomBarChart> {
  int? touchedIndex;
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
    final lowPriorityTasks = filterTasks(filteredTasks, 'lowPriority');
    final mediumPriorityTasks = filterTasks(filteredTasks, 'mediumPriority');
    final highPriorityTasks = filterTasks(filteredTasks, 'highPriority');
    final int maxTaskCount =
        filteredTasks.isNotEmpty ? filteredTasks.length : 1;
    final int interval = calculateInterval(maxTaskCount);
    final double maxY = maxTaskCount > 0
        ? (maxTaskCount % interval == 0
            ? maxTaskCount.toDouble()
            : ((maxTaskCount ~/ interval + 1) * interval).toDouble())
        : 1;
    final double gridInterval = calculateGridInterval(maxY);

    return BarChart(
      duration: Duration(milliseconds: 300),
      BarChartData(
        minY: 0,
        maxY: maxY,
        barTouchData: BarTouchData(
          handleBuiltInTouches: true,
          touchCallback: (event, response) {
            if (event.isInterestedForInteractions &&
                response != null &&
                response.spot != null) {
              setState(() {
                touchedIndex = response.spot!.touchedBarGroupIndex;
              });
            } else {
              setState(() {
                touchedIndex = null;
              });
            }
          },
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                rod.toY.round().toString(),
                AppTextStyles.medium16.copyWith(color: Colors.white),
              );
            },
            getTooltipColor: (_) => AppColors.primaryLightColor,
          ),
        ),
        barGroups: List.generate(3, (index) {
          final isTouched = index == touchedIndex;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: [
                  lowPriorityTasks.isNotEmpty ? lowPriorityTasks.length : 0,
                  mediumPriorityTasks.isNotEmpty
                      ? mediumPriorityTasks.length
                      : 0,
                  highPriorityTasks.isNotEmpty ? highPriorityTasks.length : 0
                ][index]
                    .toDouble(),
                width: 20,
                color: isTouched
                    ? TaskUIHelper.getPriorityDetails([
                        TaskPriority.low,
                        TaskPriority.medium,
                        TaskPriority.high
                      ][index])['color']
                    : TaskUIHelper.getPriorityDetails([
                        TaskPriority.low,
                        TaskPriority.medium,
                        TaskPriority.high
                      ][index])['color']
                        .withAlpha(128),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ],
          );
        }),
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: maxY,
              color: Colors.blueGrey,
              strokeWidth: 0.4,
              dashArray: [8, 4],
            ),
            HorizontalLine(
              y: 0,
              color: Colors.blueGrey,
              strokeWidth: 0.4,
              dashArray: [8, 4],
            ),
          ],
        ),
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: gridInterval,
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: getTitles,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: interval.toDouble(),
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                return Text(
                  meta.formattedValue,
                  style: AppTextStyles.medium16.copyWith(
                    color: Color(0xff7b808c),
                  ),
                );
              },
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  double calculateGridInterval(double maxY) {
    return maxY <= 10 ? 1 : maxY / 5;
  }

  int calculateInterval(int maxTaskCount) {
    if (maxTaskCount <= 10) {
      return 1;
    } else if (maxTaskCount <= 50) {
      return 5;
    } else if (maxTaskCount <= 100) {
      return 10;
    } else {
      return (maxTaskCount / 10).ceil();
    }
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = AppTextStyles.medium16.copyWith(
      color: Color(0xff7b808c),
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = S.of(context).taskPriorityLow;
        break;
      case 1:
        text = S.of(context).taskPriorityMedium;
        break;
      case 2:
        text = S.of(context).taskPriorityHigh;
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      meta: meta,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
