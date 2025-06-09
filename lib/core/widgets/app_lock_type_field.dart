import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';

class AppLockTypeField extends StatefulWidget {
  const AppLockTypeField({
    super.key,
    this.controller,
    this.textAlign,
    this.keyboardType,
    this.isPassword = true,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final bool isPassword;

  @override
  State<AppLockTypeField> createState() => _AppLockTypeFieldState();
}

class _AppLockTypeFieldState extends State<AppLockTypeField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  UnderlineInputBorder buildBorder([Color? borderColor]) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: borderColor ?? Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textAlign: widget.textAlign ?? TextAlign.start,
      obscureText: _obscureText,
      textInputAction: TextInputAction.done,
      autofocus: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        filled: false,
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        errorBorder: buildBorder(AppColors.errorColor),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _toggleVisibility,
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
      ),
    );
  }
}
