import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.maxLength,
    this.textInputAction,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
  });

  final String hintText;
  final TextEditingController? controller;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final TextAlign textAlign;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textAlign: widget.textAlign,
      obscureText: _obscureText,
      maxLength: widget.maxLength,
      textInputAction: widget.textInputAction,
      autofocus: widget.autofocus,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: GestureDetector(
          onTap: _toggleVisibility,
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
    );
  }
}
