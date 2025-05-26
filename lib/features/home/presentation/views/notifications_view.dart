import 'package:flutter/material.dart';
import 'package:taskify/features/home/presentation/widgets/notifications_view_body.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NotificationsViewBody(),
      ),
    );
  }
}
