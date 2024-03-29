import 'package:assignment/presentation_payer/common/colors.dart';
import 'package:assignment/presentation_payer/common/text_styles.dart';
import 'package:flutter/material.dart';

class ASPrimaryButton extends StatefulWidget {
  final double? width;
  final double? height;
  final String? text;
  final Widget? icon;
  final Function() onPressed;

  const ASPrimaryButton({Key? key, this.text, required this.onPressed, this.icon, this.width, this.height})
      : super(key: key);

  @override
  State<ASPrimaryButton> createState() => _ASPrimaryButtonState();
}

class _ASPrimaryButtonState extends State<ASPrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: ASColors.secondary.withOpacity(0.1),
        onTap: widget.onPressed,
        child: Ink(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(color: ASColors.primary, borderRadius: BorderRadius.circular(6)),
          child: Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(
              minWidth: 73,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.text != null)
                  Text(
                    widget.text!,
                    style: ASTextStyles.buttonText,
                  ),
                if (widget.icon != null) widget.icon!
              ],
            ),
          ),
        ),
      ),
    );
  }
}
