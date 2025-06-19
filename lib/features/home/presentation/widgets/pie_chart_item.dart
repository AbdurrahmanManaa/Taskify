import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/domain/entities/pie_chart_item_entity.dart';

class PieChartItem extends StatelessWidget {
  const PieChartItem({
    super.key,
    required this.pieChartItemEntity,
  });
  final PieChartItemEntity pieChartItemEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 6,
          backgroundColor: pieChartItemEntity.color,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pieChartItemEntity.progress,
              style: AppTextStyles.semiBold20,
            ),
            Text(
              pieChartItemEntity.title,
              style: AppTextStyles.regular16.copyWith(
                color: AppColors.bodyTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
