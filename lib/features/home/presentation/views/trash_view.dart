import 'package:flutter/material.dart';
import 'package:taskify/features/home/presentation/widgets/trash_view_body.dart';

class TrashView extends StatelessWidget {
  const TrashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TrashViewBody(),
      ),
    );
  }
}
