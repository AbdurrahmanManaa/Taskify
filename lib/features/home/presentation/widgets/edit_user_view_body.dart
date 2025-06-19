import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_text_form_field.dart';
import 'package:taskify/core/widgets/field_item.dart';
import 'package:taskify/core/widgets/password_text_form_field.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/features/home/domain/entities/edit_user_entity.dart';
import 'package:taskify/generated/l10n.dart';

enum EditProfileType {
  name,
  email,
  password,
}

class EditUserViewBody extends StatefulWidget {
  const EditUserViewBody({super.key});

  @override
  State<EditUserViewBody> createState() => _EditUserViewBodyState();
}

class _EditUserViewBodyState extends State<EditUserViewBody> {
  late final TextEditingController _controller;
  late final TextEditingController _confirmController;
  late final EditUserEntity editData;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _confirmController = TextEditingController();
    editData = context.read<EditUserEntity>();
    switch (editData.mode) {
      case EditProfileType.name:
        _controller.text = editData.userEntity.fullName;
        break;
      case EditProfileType.email:
        _controller.text = editData.userEntity.email;
        break;
      case EditProfileType.password:
        _controller.text = '';
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    switch (editData.mode) {
      case EditProfileType.name:
        return _buildFullNameEditor();
      case EditProfileType.email:
        return _buildEmailEditor();
      case EditProfileType.password:
        return _buildPasswordEditor();
    }
  }

  Widget _buildFullNameEditor() {
    return Column(
      children: [
        SizedBox(height: 20),
        CustomAppbar(
          title: S.of(context).editFullNameAppBar,
        ),
        SizedBox(height: 20),
        FieldItem(
          label: S.of(context).fullNameTextField,
          widget: ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, value, _) {
              return CustomTextFormField(
                controller: _controller,
                hintText: S.of(context).fullNameTextFieldHint,
                autofocus: true,
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.name],
                textInputAction: TextInputAction.done,
                maxLength: 100,
                suffixIcon: value.text.isEmpty
                    ? null
                    : GestureDetector(
                        onTap: () => _controller.clear(),
                        child: Icon(
                          Icons.cancel,
                        ),
                      ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        BlocListener<UserCubit, UserState>(
          listener: (context, state) async {
            if (state is UserUpdated) {
              buildSnackbar(context,
                  message: 'Full Name updated successfully.');
            } else if (state is UserFailure) {
              buildSnackbar(context, message: 'Failed to update Full Name.');
            }
          },
          child: CustomButton(
            title: S.of(context).editFullNameAppBar,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await context.read<UserCubit>().updateUserData(
                      newName: _controller.text,
                      uid: editData.userEntity.id,
                    );
                _controller.clear();
                if (!mounted) return;
                Navigator.pop(context);
              } else {
                setState(() {
                  _autoValidateMode = AutovalidateMode.always;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmailEditor() {
    return Column(
      children: [
        SizedBox(height: 20),
        CustomAppbar(
          title: S.of(context).editEmailAppBar,
        ),
        SizedBox(height: 20),
        FieldItem(
          label: S.of(context).newEmailTextField,
          widget: ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, value, _) {
              return CustomTextFormField(
                controller: _controller,
                hintText: S.of(context).newEmailTextFieldHint,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.done,
                maxLength: 254,
                suffixIcon: value.text.isEmpty
                    ? null
                    : GestureDetector(
                        onTap: () => _controller.clear(),
                        child: Icon(
                          Icons.cancel,
                        ),
                      ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        BlocListener<UserCubit, UserState>(
          listener: (context, state) async {
            if (state is UserUpdated) {
              buildSnackbar(context,
                  message:
                      'Email updated successfully Check your new email for the verification link.');
            } else if (state is UserFailure) {
              buildSnackbar(context, message: 'Failed to update email.');
            }
          },
          child: CustomButton(
            title: S.of(context).editEmailAppBar,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await context.read<UserCubit>().updateUserData(
                    newEmail: _controller.text.trim(),
                    uid: editData.userEntity.id,
                    redirectTo: 'taskify://change-email');
                if (!context.mounted) return;
                if (!mounted) return;
                buildSnackbar(context,
                    message: 'Check your new email for the verification link.');
                _controller.clear();
              } else {
                setState(() {
                  _autoValidateMode = AutovalidateMode.always;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordEditor() {
    return Column(
      children: [
        SizedBox(height: 20),
        CustomAppbar(title: S.of(context).editPasswordAppBar),
        SizedBox(height: 20),
        FieldItem(
          label: S.of(context).newPassword,
          widget: PasswordTextFormField(
            hintText: S.of(context).newPasswordTextFieldHint,
            controller: _controller,
            textInputAction: TextInputAction.next,
            maxLength: 30,
          ),
        ),
        FieldItem(
          label: S.of(context).confirmPasswordTextField,
          widget: PasswordTextFormField(
            hintText: S.of(context).confirmPasswordTextFieldHint,
            controller: _confirmController,
            textInputAction: TextInputAction.done,
            maxLength: 30,
          ),
        ),
        const SizedBox(height: 30),
        BlocListener<UserCubit, UserState>(
          listener: (context, state) async {
            if (state is UserUpdated) {
              buildSnackbar(context, message: 'Password updated successfully.');
            } else if (state is UserFailure) {
              buildSnackbar(context, message: 'Failed to update password.');
            }
          },
          child: CustomButton(
            title: S.of(context).editPasswordAppBar,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (_controller.text.trim() != _confirmController.text.trim()) {
                  buildSnackbar(context, message: 'Passwords do not match.');
                  return;
                }
                await context.read<UserCubit>().updateUserData(
                      newPassword: _controller.text.trim(),
                      uid: editData.userEntity.id,
                    );
                _controller.clear();
                _confirmController.clear();
                if (!mounted) return;
                Navigator.pop(context);
              } else {
                setState(() {
                  _autoValidateMode = AutovalidateMode.always;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: _buildBody(),
        ),
      ),
    );
  }
}
