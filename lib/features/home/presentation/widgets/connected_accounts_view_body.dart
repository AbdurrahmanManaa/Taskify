import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/features/home/domain/entities/user_identity_entity.dart';
import 'package:taskify/features/home/presentation/widgets/user_account_widget.dart';

class ConnectedAccountsViewBody extends StatefulWidget {
  const ConnectedAccountsViewBody({super.key});

  @override
  State<ConnectedAccountsViewBody> createState() =>
      _ConnectedAccountsViewBodyState();
}

class _ConnectedAccountsViewBodyState extends State<ConnectedAccountsViewBody> {
  late final TextEditingController _passwordTest;
  @override
  void initState() {
    super.initState();
    _passwordTest = TextEditingController();
    getUserIdentities();
  }

  @override
  void dispose() {
    _passwordTest.dispose();
    super.dispose();
  }

  Future<void> getUserIdentities() async {
    await context.read<UserCubit>().getUserIdentities();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          CustomAppbar(title: 'Connected Accounts'),
          const SizedBox(height: 30),
          BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is UserLoading) {
                return Skeletonizer(
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                        ),
                        title: Text('testingemail@gmail.com'),
                        subtitle: Text('Google'),
                      ),
                      const SizedBox(height: 40),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                        ),
                        title: Text('testingemail@gmail.com'),
                        subtitle: Text('Google'),
                      ),
                    ],
                  ),
                );
              } else if (state is UserFailure) {
                return Center(
                  child: Text(
                    'Failed to load identities',
                    style: AppTextStyles.regular16
                        .copyWith(color: AppColors.greyColor),
                  ),
                );
              } else {
                var userIdentities = context.watch<UserCubit>().userIdentities;
                final providerIcons = {
                  'google': AppAssets.imagesGoogle,
                };

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: providerIcons.entries.map((entry) {
                    final provider = entry.key;
                    final icon = entry.value;

                    final matchingIdentities = userIdentities
                        .where(
                          (identity) => identity.provider == provider,
                        )
                        .toList();

                    final isConnected = matchingIdentities.isNotEmpty;
                    final userIdentity =
                        isConnected ? matchingIdentities.first : null;

                    final userIdentityEntity = UserIdentityEntity(
                      userIdentity: userIdentity,
                      providerIcon: icon,
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserAccountWidget(
                          userIdentityEntity: userIdentityEntity,
                          isConnected: isConnected,
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          title: isConnected ? 'Disconnect' : 'Connect',
                          onPressed: () async {
                            if (isConnected && userIdentities.length > 1) {
                              await context.read<UserCubit>().unlinkIdentity();
                            } else if (!isConnected) {
                              await context.read<UserCubit>().linkIdentity();
                            } else {
                              buildSnackbar(context,
                                  message:
                                      'You must have at least two identity connected.');
                            }
                          },
                        ),
                        const SizedBox(height: 40),
                      ],
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
