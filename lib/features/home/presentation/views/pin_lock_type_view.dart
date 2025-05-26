import 'package:flutter/material.dart';
import 'package:taskify/features/home/presentation/widgets/pin_lock_type_view_body.dart';

class PinLockTypeView extends StatelessWidget {
  const PinLockTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PinLockTypeViewBody(),
      ),
    );
  }
}
