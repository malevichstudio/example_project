import 'package:assignment/app_layer/app/injection.dart';
import 'package:assignment/app_layer/router/router.dart';
import 'package:assignment/generated/assets.gen.dart';
import 'package:assignment/presentation_payer/common/colors.dart';
import 'package:assignment/presentation_payer/common/text_styles.dart';
import 'package:flutter/material.dart';

part "parts/modal_bottom/picker_modal_bottom_view.dart";

typedef ASOptionSelectedCallback<T> = Function(T);

class ASModalBottomPicker<T> extends StatelessWidget {
  final List<ASModalBottomPickerOption<T>> options;
  final ASOptionSelectedCallback<T> onSelected;
  final ASModalBottomPickerOption<T>? value;
  final Widget? prefixIcon;
  final String hintText;
  const ASModalBottomPicker(
      {required this.hintText,
      required this.options,
      required this.onSelected,
      required this.value,
      this.prefixIcon,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getIt<ASNavigator>().showModalBottom(
            widget: ASOptionPickerModalBottom<T>(
          options: options,
          onSelected: onSelected,
        ));
      },
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: ASColors.lightGrey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            if (prefixIcon != null)
              Container(width: 44, alignment: Alignment.center, height: double.infinity, child: prefixIcon!),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: _buildCurrentText(),
            ),
            SizedBox(
              width: 40,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.79, horizontal: 10.17),
                child: Assets.svg.triangleDropdown.svg(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _buildCurrentText() {
    if (value == null) {
      return Text(
        hintText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: ASTextStyles.inputTextStyle.copyWith(color: ASColors.darkGrey),
      );
    }
    return Text(
      value!.displayableName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: ASTextStyles.inputTextStyle,
    );
  }
}
