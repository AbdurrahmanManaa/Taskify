import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/generated/l10n.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedTabIndex;
  final Function(int) onTabSelected;
  final int titleCount;

  const CustomTabBar({
    super.key,
    required this.selectedTabIndex,
    required this.onTabSelected,
    this.titleCount = 2,
  });

  SizedBox _twoTabs(
    BuildContext context,
    List<String> titlesList,
  ) {
    return SizedBox(
      height: 48,
      child: Row(
        children: List.generate(titlesList.length, (index) {
          final isSelected = selectedTabIndex == index;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 0 : 10),
              child: GestureDetector(
                onTap: () => onTabSelected(index),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey<bool>(isSelected),
                    decoration: ShapeDecoration(
                      color: isSelected
                          ? AppColors.primaryLightColor
                          : AppColors.transparentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        titlesList[index],
                        style: AppTextStyles.medium18.copyWith(
                          color: selectedTabIndex == index
                              ? Colors.white
                              : AppColors.primaryLightColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  SizedBox _moreThanTwoTabs(
    BuildContext context,
    List<String> titlesList,
  ) {
    return SizedBox(
      height: 52,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: titlesList.length,
        itemBuilder: (context, index) {
          final isSelected = selectedTabIndex == index;

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: index == 0 || index == titlesList.length ? 0 : 10),
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    key: ValueKey<bool>(isSelected),
                    decoration: ShapeDecoration(
                      color: isSelected
                          ? AppColors.primaryLightColor
                          : AppColors.transparentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      titlesList[index],
                      style: AppTextStyles.medium18.copyWith(
                        color: isSelected
                            ? Colors.white
                            : AppColors.primaryLightColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> titlesList =
        titleCount == 2 ? titlesForTwo(context) : titlesForMoreThanTwo(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: ShapeDecoration(
        color: const Color(0xfff8f9fb),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: AppColors.borderColor,
          ),
        ),
      ),
      child: titlesList.length == 2
          ? _twoTabs(
              context,
              titlesList,
            )
          : _moreThanTwoTabs(
              context,
              titlesList,
            ),
    );
  }
}

List<String> titlesForTwo(BuildContext context) {
  return [
    S.of(context).subtasksTab,
    S.of(context).attachmentsTab,
  ];
}

List<String> titlesForMoreThanTwo(BuildContext context) {
  return [
    S.of(context).tabAll,
    S.of(context).tabToday,
    S.of(context).tabTomorrow,
    S.of(context).tabUpcoming,
    S.of(context).tabCompleted,
    S.of(context).tabOverdue,
  ];
}
