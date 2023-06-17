import 'package:assignment/app_layer/app/injection.dart';
import 'package:assignment/app_layer/router/router.dart';
import 'package:assignment/domain_layer/entities/calendar_panel_switcher_option.dart';
import 'package:assignment/presentation_payer/common/colors.dart';
import 'package:assignment/presentation_payer/common/inputs/parts/date_picker/select_end_date_dialog.dart';
import 'package:assignment/presentation_payer/common/inputs/parts/date_picker/select_start_date_dialog.dart';
import 'package:assignment/presentation_payer/common/text_styles.dart';
import 'package:flutter/material.dart';

part 'parts/date_picker/widgets/calendar_panel_switchers.dart';

enum ASDatePickerView {
  requiredStartDate,
  endDate,
}

class ASDatePicker extends StatefulWidget {
  final Widget? prefixIcon;
  final String hintText;
  final String? initialValue;
  final DateTime? initialDate;
  final ASDatePickerView view;
  final Function(DateTime?) onDateSaved;

  const ASDatePicker({
    required this.hintText,
    required this.onDateSaved,
    required this.view,
    this.prefixIcon,
    this.initialDate,
    this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  State<ASDatePicker> createState() => _ASDatePickerState();
}

class _ASDatePickerState extends State<ASDatePicker> {
  DateTime? _initialDate;
  String? _initialValue;

  @override
  void initState() {
    super.initState();
    _initialDate = widget.initialDate;
    _initialValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPickerPressed,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: ASColors.lightGrey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            if (widget.prefixIcon != null)
              Container(width: 44, alignment: Alignment.center, height: double.infinity, child: widget.prefixIcon!),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: _buildCurrentText(),
            ),
          ],
        ),
      ),
    );
  }

  void _onPickerPressed() {
    switch (widget.view) {
      case ASDatePickerView.requiredStartDate:
        return getIt<ASNavigator>().showCustomDialog(
            widget: ASSelectStartDateDialog(initialDate: _initialDate, onDateSaved: widget.onDateSaved));
      case ASDatePickerView.endDate:
        return getIt<ASNavigator>().showCustomDialog(
            widget: ASSelectEndDateDialog(initialDate: _initialDate, onDateSaved: widget.onDateSaved));
    }
  }

  Text _buildCurrentText() {
    if (_initialValue == null || _initialValue == '') {
      return Text(
        widget.hintText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: ASTextStyles.inputTextStyle.copyWith(color: ASColors.darkGrey, fontSize: 14),
      );
    }
    return Text(
      _initialValue!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: ASTextStyles.inputTextStyle.copyWith(fontSize: 14),
    );
  }
}
