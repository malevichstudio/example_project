import 'package:assignment/presentation_payer/common/colors.dart';
import 'package:assignment/presentation_payer/common/text_styles.dart';
import 'package:flutter/material.dart';

class ASTextFormField extends StatelessWidget {
  final String hintText;
  final Function(String) validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final bool obscureText;
  final int maxLines;
  final TextInputAction textInputAction;

  const ASTextFormField({
    super.key,
    required this.hintText,
    required this.validator,
    required this.controller,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        textInputAction: textInputAction,
        textAlignVertical: TextAlignVertical.center,
        style: ASTextStyles.inputTextStyle,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            prefixIcon: prefixIcon,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                width: 1,
                color: ASColors.redAccent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                width: 1,
                color: ASColors.lightGrey,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                width: 1,
                color: ASColors.lightGrey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                width: 1,
                color: ASColors.lightGrey,
              ),
            ),
            hintText: hintText,
            hintStyle: ASTextStyles.inputTextStyle.copyWith(color: ASColors.darkGrey)),
        validator: (value) => validator(value ?? ''),
      ),
    );
  }
}
