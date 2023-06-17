import 'package:assignment/presentation_payer/common/colors.dart';
import 'package:assignment/presentation_payer/common/text_styles.dart';
import 'package:flutter/material.dart';

class ASTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final bool obscureText;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final int maxLines;
  final TextInputAction textInputAction;

  const ASTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.onEditingComplete,
    this.prefixIcon,
    this.onChanged,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            textInputAction: textInputAction,
            textAlignVertical: TextAlignVertical.center,
            style: ASTextStyles.inputTextStyle,
            onEditingComplete: onEditingComplete,
            onChanged: onChanged,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                prefixIcon: prefixIcon,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    width: 1,
                    color: errorText == null ? ASColors.lightGrey : ASColors.redAccent,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    width: 1,
                    color: errorText == null ? ASColors.lightGrey : ASColors.redAccent,
                  ),
                ),
                hintText: hintText,
                hintStyle: ASTextStyles.inputTextStyle.copyWith(color: ASColors.darkGrey)),
          ),
        ),
        if (errorText != null) ...{
          const SizedBox(
            height: 5,
          ),
          Text(
            errorText!,
            style: ASTextStyles.errorText,
          )
        }
      ],
    );
  }
}
