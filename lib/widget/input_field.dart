import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;

  /// 是否是密码输入框
  final bool isPassword;

  /// 初始是否显示密码
  final bool initialShowPassword;
  final Widget? prefix;
  final Widget? suffix;
  final Function()? onSuffixTap;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const InputField({
    super.key,
    this.controller,
    this.isPassword = false,
    this.initialShowPassword = false,
    this.prefix,
    this.suffix,
    this.onSuffixTap,
    this.hintText,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  State<StatefulWidget> createState() {
    return _InputFieldState();
  }
}

class _InputFieldState extends State<InputField> {
  late bool showPassword;

  @override
  void initState() {
    super.initState();
    showPassword = widget.initialShowPassword;
  }

  @override
  Widget build(BuildContext context) {
    Widget? suffixWidget;
    if (widget.suffix != null) {
      suffixWidget = widget.suffix;
      if (widget.onSuffixTap != null) {
        suffixWidget = GestureDetector(
          onTap: widget.onSuffixTap,
          child: suffixWidget,
        );
      }
    } else if (widget.isPassword) {
      suffixWidget = GestureDetector(
        onTap: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        child: Icon(
          showPassword ? Icons.visibility : Icons.visibility_off,
        ),
      );
    }
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword && !showPassword,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefix,
        suffixIcon: suffixWidget,
        contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
