import 'package:assignment/domain_layer/entities/employee.dart';
import 'package:assignment/domain_layer/entities/employee_presentation.dart';
import 'package:assignment/domain_layer/entities/roles.dart';
import 'package:assignment/generated/assets.gen.dart';
import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/presentation_payer/common/buttons/primaty_button.dart';
import 'package:assignment/presentation_payer/common/buttons/secondary_button.dart';
import 'package:assignment/presentation_payer/common/colors.dart';
import 'package:assignment/presentation_payer/common/inputs/date_picker.dart';
import 'package:assignment/presentation_payer/common/inputs/input_field.dart';
import 'package:assignment/presentation_payer/common/inputs/modal_bottom_picker.dart';
import 'package:assignment/presentation_payer/common/text_styles.dart';
import 'package:assignment/presentation_payer/edit/cubit/edit_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPage extends StatefulWidget {
  final ASEmployee? employee;
  final Function(ASEmployeePresentation) onEmployeeChanged;
  const EditPage({required this.employee, required this.onEmployeeChanged, Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late final TextEditingController _employeeController;

  @override
  void initState() {
    super.initState();
    _employeeController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditPageCubit>().init(localization: AppLocalizations.of(context), employee: widget.employee);
    });
    _employeeController.addListener(() {
      context.read<EditPageCubit>().newValueEmployeeName(_employeeController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _employeeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ASColors.primary,
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context).addEmployeeDetails,
            style: ASTextStyles.headerPage,
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<EditPageCubit, EditPageState>(
            buildWhen: (oldState, newState) => newState.map(
              initial: (_) => false,
              loaded: (_) => true,
            ),
            listenWhen: (oldState, newState) => newState.map(
              initial: (_) => false,
              loaded: (_) => true,
            ),
            listener: (BuildContext context, EditPageState state) {
              state.mapOrNull(loaded: (state) {
                if (_employeeController.text != state.employeeName) {
                  _employeeController.text = state.employeeName ?? "";
                }
              });
            },
            builder: (BuildContext context, EditPageState state) {
              return state.map(initial: (_) => const SizedBox(), loaded: _buildEditPage);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEditPage(EditPageStateLoaded state) {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Column(
                  children: [
                    ASTextFormField(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 11.5, horizontal: 10),
                        child: Assets.svg.user.svg(fit: BoxFit.contain),
                      ),
                      errorText: state.errorEmployeeName,
                      hintText: AppLocalizations.of(context).employeeName,
                      controller: _employeeController,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ASModalBottomPicker<ASRoles>(
                      key: ObjectKey(state.selectedRole),
                      value: state.selectedRole,
                      hintText: AppLocalizations.of(context).selectRole,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 10.5),
                        child: Assets.icons.briefcase.image(),
                      ),
                      stringError: state.roleError,
                      options: state.roleOptions,
                      onSelected: context.read<EditPageCubit>().selectRole,
                    ),
                    if (state.roleError != null) ...{
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        state.roleError!,
                        style: ASTextStyles.errorText,
                      )
                    }
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 14,
                      child: Column(
                        children: [
                          ASDatePicker(
                            key: ObjectKey(state.startDate.date),
                            view: ASDatePickerView.requiredStartDate,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 11.5),
                              child: Assets.icons.calendar.image(),
                            ),
                            hintText: AppLocalizations.of(context).noDate,
                            initialValue: state.startDate.datePresentationTitle,
                            initialDate: state.startDate.date,
                            onDateSaved: (date) =>
                                context.read<EditPageCubit>().onStartDatePicked(date!, AppLocalizations.of(context)),
                          ),
                          if (state.startDateError != null)
                            Text(
                              state.startDateError!,
                              style: ASTextStyles.errorText,
                            )
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 14,
                      child: Assets.icons.arrow.image(),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 14,
                      child: ASDatePicker(
                        key: ObjectKey(state.endDate?.date),
                        view: ASDatePickerView.endDate,
                        onDateSaved: (date) =>
                            context.read<EditPageCubit>().onEndDatePicked(date, AppLocalizations.of(context)),
                        prefixIcon: Assets.icons.calendar.image(),
                        hintText: AppLocalizations.of(context).noDate,
                        initialValue: state.endDate?.datePresentationTitle,
                        initialDate: state.endDate?.date,
                        dateTimeAvailableFromPick: state.endDateTimeAvailableFromPick,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: const BoxDecoration(border: Border(top: BorderSide(width: 2, color: ASColors.lightBackground))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ASSecondaryButton(
                onPressed: () => Navigator.of(context).pop(),
                text: AppLocalizations.of(context).cancel,
              ),
              const SizedBox(
                width: 16,
              ),
              ASPrimaryButton(
                onPressed: () {
                  context.read<EditPageCubit>().save(onCreatedEmployee: widget.onEmployeeChanged, context: context);
                },
                text: AppLocalizations.of(context).save,
              ),
            ],
          ),
        )
      ],
    );
  }
}
