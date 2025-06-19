import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:taskify/features/home/presentation/widgets/custom_bar_chart.dart';
import 'package:taskify/features/home/presentation/widgets/custom_pie_chart.dart';
import 'package:taskify/generated/l10n.dart';

class StatisticsViewBody extends StatefulWidget {
  const StatisticsViewBody({super.key});

  @override
  State<StatisticsViewBody> createState() => _StatisticsViewBodyState();
}

class _StatisticsViewBodyState extends State<StatisticsViewBody> {
  final GlobalKey _pdfKey = GlobalKey();

  Future<void> _generateAndSharePDF() async {
    try {
      RenderRepaintBoundary boundary =
          _pdfKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final pdf = pw.Document();
      final imageProvider = pw.MemoryImage(pngBytes);
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(imageProvider),
            );
          },
        ),
      );
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/statistics.pdf');
      await file.writeAsBytes(await pdf.save());
      if (!mounted) return;
      final params = ShareParams(
        text: S.of(context).shareText,
        files: [XFile(file.path)],
      );
      await SharePlus.instance.share(params);
    } catch (e) {
      log('Error generating PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String? selectedValueTaskStatus = S.of(context).weekly;
    String? selectedValuePriorityDistribution = S.of(context).weekly;
    final optionsList = options(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
      child: Column(
        children: [
          const SizedBox(height: 20),
          CustomAppbar(
            title: S.of(context).statisticsAppBar,
            showBackButton: false,
            actions: [
              GestureDetector(
                onTap: _generateAndSharePDF,
                child: Icon(Icons.share),
              ),
            ],
          ),
          const SizedBox(height: 20),
          RepaintBoundary(
            key: _pdfKey,
            child: Column(
              spacing: 20,
              children: [
                BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    var tasks = context.watch<TaskCubit>().tasks;

                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: AppColors.borderColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).pieChartTitle,
                                  style: AppTextStyles.semiBold20,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.borderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    isDense: true,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff7b808c),
                                    ),
                                    style: AppTextStyles.medium16.copyWith(
                                      color: Color(0xff7b808c),
                                    ),
                                    dropdownColor:
                                        AppColors.scaffoldLightBackgroundColor,
                                    underline: const SizedBox.shrink(),
                                    value: selectedValueTaskStatus,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedValueTaskStatus = newValue;
                                      });
                                    },
                                    items: optionsList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            CustomPieChart(
                              tasks: tasks,
                              selectedValue: selectedValueTaskStatus ??
                                  S.of(context).weekly,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    var tasks = context.watch<TaskCubit>().tasks;

                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: AppColors.borderColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).barChartTitle,
                                  style: AppTextStyles.semiBold20,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.borderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    isDense: true,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff7b808c),
                                    ),
                                    style: AppTextStyles.medium16.copyWith(
                                      color: Color(0xff7b808c),
                                    ),
                                    dropdownColor:
                                        AppColors.scaffoldLightBackgroundColor,
                                    underline: const SizedBox.shrink(),
                                    value: selectedValuePriorityDistribution,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedValuePriorityDistribution =
                                            newValue;
                                      });
                                    },
                                    items: optionsList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              height: 200,
                              child: CustomBarChart(
                                  tasks: tasks,
                                  selectedValue:
                                      selectedValuePriorityDistribution ??
                                          S.of(context).weekly),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<String> options(BuildContext context) {
  return [
    S.of(context).daily,
    S.of(context).weekly,
    S.of(context).monthly,
  ];
}
