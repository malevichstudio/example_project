import 'package:assignment/presentation_payer/common/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final double? width;
  final double? height;
  final String? text;
  final Widget? icon;
  final Function() onPressed;

  const PrimaryButton({Key? key, this.text, required this.onPressed, this.icon, this.width, this.height})
      : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [if (widget.text != null) Text(widget.text!), if (widget.icon != null) widget.icon!],
            ),
          ),
        ),
      ),
    );
  }
}
