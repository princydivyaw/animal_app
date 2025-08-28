import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_module/core/theme/text_styles.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool isValidated;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool showCursor;
  final bool readOnly;
  final bool autofocus;
  final bool autocorrect;
  final int maxLine;
  final int? maxLength;
  List<TextInputFormatter>? inputFormatters;
  final bool isObscure;

  final Color? lblColor;
  final Color? hintColor;
  final Color? txtColor;
  final FocusNode? focus;

  AppTextField({
    super.key,
    required this.controller,
    required this.isValidated,
    this.labelText = "",
    this.hintText = "",
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    this.enabled = true,
    this.showCursor = true,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.maxLine = 1,
    this.maxLength,
    this.isObscure = false,
    this.inputFormatters,
    this.lblColor,
    this.hintColor,
    this.txtColor,
    this.focus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.056,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(
            color: isValidated ? Colors.red : Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        cursorColor: Colors.white,
        cursorWidth: 1.0,
        cursorHeight: 20.0,
        enabled: enabled,
        showCursor: showCursor,
        readOnly: readOnly,
        autofocus: autofocus,
        autocorrect: autocorrect,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        maxLength: maxLength,
        maxLines: maxLine,
        focusNode: focus ?? FocusNode(),
        style: AppTextStyles.bodyNormal(color: txtColor),
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        obscureText: isObscure,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: AppTextStyles.bodyRegularMedium(color: hintColor),
            labelText: labelText,
            labelStyle: AppTextStyles.labelNormal(color: lblColor),
            counterText: ""),
        onChanged: onChanged,
      ),
    );
  }
}
