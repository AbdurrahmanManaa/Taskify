import 'package:flutter/material.dart';
import 'package:taskify/features/home/presentation/widgets/connected_accounts_view_body.dart';

class ConnectedAccountsView extends StatelessWidget {
  const ConnectedAccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ConnectedAccountsViewBody(),
      ),
    );
  }
}
