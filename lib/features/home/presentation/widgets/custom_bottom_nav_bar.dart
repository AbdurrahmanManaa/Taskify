import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/features/home/presentation/views/add_task_view.dart';
import 'package:taskify/features/home/presentation/views/calender_view.dart';
import 'package:taskify/features/home/presentation/views/home_view.dart';
import 'package:taskify/features/home/presentation/views/settings_view.dart';
import 'package:taskify/features/home/presentation/views/statistics_view.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key, this.controller});
  final PersistentTabController? controller;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final List<ScrollController> _scrollControllers =
      List.generate(4, (_) => ScrollController());

  List<PersistentTabConfig> get _tabs {
    return [
      PersistentTabConfig(
        screen: ChangeNotifierProvider.value(
          value: _scrollControllers[0],
          child: HomeView(),
        ),
        scrollController: _scrollControllers[0],
        item: ItemConfig(
          icon: Icon(Icons.home, color: AppColors.primaryLightColor, size: 32),
          inactiveIcon:
              Icon(Icons.home_outlined, color: AppColors.greyColor, size: 30),
        ),
      ),
      PersistentTabConfig(
        screen: ChangeNotifierProvider.value(
          value: _scrollControllers[1],
          child: CalenderView(),
        ),
        scrollController: _scrollControllers[1],
        item: ItemConfig(
          icon: Icon(Icons.calendar_month,
              color: AppColors.primaryLightColor, size: 32),
          inactiveIcon: Icon(Icons.calendar_month_outlined,
              color: AppColors.greyColor, size: 30),
        ),
      ),
      PersistentTabConfig(
        screen: ChangeNotifierProvider.value(
          value: _scrollControllers[2],
          child: AddTaskView(),
        ),
        scrollController: _scrollControllers[2],
        item: ItemConfig(
          icon:
              Icon(Icons.add_box, color: AppColors.primaryLightColor, size: 32),
          inactiveIcon: Icon(Icons.add_box_outlined,
              color: AppColors.greyColor, size: 30),
        ),
      ),
      PersistentTabConfig(
        screen: StatisticsView(),
        item: ItemConfig(
          icon: Icon(Icons.bar_chart,
              color: AppColors.primaryLightColor, size: 32),
          inactiveIcon: Icon(Icons.bar_chart_outlined,
              color: AppColors.greyColor, size: 30),
        ),
      ),
      PersistentTabConfig(
        screen: ChangeNotifierProvider.value(
          value: _scrollControllers[3],
          child: SettingsView(),
        ),
        scrollController: _scrollControllers[3],
        item: ItemConfig(
          icon: Icon(Icons.settings,
              color: AppColors.primaryLightColor, size: 32),
          inactiveIcon: Icon(Icons.settings_outlined,
              color: AppColors.greyColor, size: 30),
        ),
      ),
    ];
  }

  Style6BottomNavBar _bottomNavBarStyle(NavBarConfig navBarConfig) {
    return Style6BottomNavBar(
      height: 60,
      navBarConfig: navBarConfig,
      navBarDecoration: NavBarDecoration(
        border:
            Border(top: BorderSide(color: Colors.grey.shade300, width: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: widget.controller,
      tabs: _tabs,
      navBarBuilder: (navBarConfig) => _bottomNavBarStyle(navBarConfig),
      selectedTabPressConfig: SelectedTabPressConfig(
        scrollToTop: true,
      ),
    );
  }
}
