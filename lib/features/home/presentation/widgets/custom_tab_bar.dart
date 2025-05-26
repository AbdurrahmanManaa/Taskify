import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedTabIndex;
  final Function(int) onTabSelected;
  final List<String> titles;

  const CustomTabBar({
    super.key,
    required this.selectedTabIndex,
    required this.onTabSelected,
    this.titles = const ['Subtasks', 'Attachments'],
  });

  SizedBox _twoTabs() {
    return SizedBox(
      height: 48,
      child: Row(
        children: List.generate(titles.length, (index) {
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
                        titles[index],
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

  SizedBox _moreThanTwoTabs() {
    return SizedBox(
      height: 52,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: titles.length,
        itemBuilder: (context, index) {
          final isSelected = selectedTabIndex == index;
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: index == 0 || index == titles.length ? 0 : 10),
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
                      titles[index],
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
      child: titles.length == 2 ? _twoTabs() : _moreThanTwoTabs(),
    );
  }
}
