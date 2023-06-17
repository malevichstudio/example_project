import 'package:assignment/app_layer/router/names.dart';
import 'package:assignment/domain_layer/entities/roles.dart';
import 'package:assignment/generated/assets.gen.dart';
import 'package:assignment/presentation_payer/common/buttons/primaty_button.dart';
import 'package:assignment/presentation_payer/common/colors.dart';
import 'package:assignment/presentation_payer/common/text_styles.dart';
import 'package:assignment/presentation_payer/home/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ASColors.lightBackground,
      appBar: AppBar(
        backgroundColor: ASColors.primary,
        title: Text(
          AppLocalizations.of(context).employeeList,
          style: ASTextStyles.headerPage,
        ),
      ),
      floatingActionButton: ASPrimaryButton(
        height: 50,
        width: 50,
        onPressed: () => Navigator.of(context)
            .pushNamed(ASRoutesNames.edit.path, arguments: {"func": context.read<HomePageCubit>().onEmployeeChanged}),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: BlocBuilder<HomePageCubit, HomePageState>(
          buildWhen: (oldState, newState) => newState.map(
            initial: (_) => false,
            loaded: (_) => true,
          ),
          builder: (BuildContext context, HomePageState state) {
            return state.map(initial: (_) => const SizedBox(), loaded: _buildHomePage);
          },
        ),
      ),
    );
  }

  Widget _buildHomePage(HomePageStateLoaded state) {
    if (state.currentEmployee.isEmpty && state.previousEmployee.isEmpty) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 260,
              height: 245,
              child: Assets.images.noEmployee.noEmployee.image(fit: BoxFit.contain),
            ),
            Text(
              AppLocalizations.of(context).noEmployeeFound,
              style: ASTextStyles.headerPage.copyWith(color: ASColors.black),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state.currentEmployee.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      child: Text(
                        AppLocalizations.of(context).currentEmployees,
                        style: ASTextStyles.sectionTitle,
                      ),
                    ),
                    for (int i = 0; i < state.currentEmployee.length; i++)
                      Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          _showDismissibleSnackBar(context);
                          context.read<HomePageCubit>().deleteCurrentEmployeeUI(i);
                        },
                        background: ColoredBox(
                          color: ASColors.redAccent,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(23.0),
                              child: Assets.icons.trash.image(),
                            ),
                          ),
                        ),
                        child: ListTile(
                          onTap: () => Navigator.of(context).pushNamed(ASRoutesNames.edit.path, arguments: {
                            "func": context.read<HomePageCubit>().onEmployeeChanged,
                            "data": state.currentEmployee[i]
                          }),
                          contentPadding: const EdgeInsets.all(16),
                          tileColor: Colors.white,
                          title: Text(
                            state.currentEmployee[i].employeeName,
                            style: ASTextStyles.listTitle,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                state.currentEmployee[i].role.name(AppLocalizations.of(context)),
                                style: ASTextStyles.secondaryButtonText.copyWith(color: ASColors.darkGrey),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                state.currentEmployee[i].datePresentationString(AppLocalizations.of(context)),
                                style: ASTextStyles.trailingText,
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                  if (state.previousEmployee.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      child: Text(
                        AppLocalizations.of(context).previousEmployee,
                        style: ASTextStyles.sectionTitle,
                      ),
                    ),
                    for (int i = 0; i < state.previousEmployee.length; i++)
                      Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          _showDismissibleSnackBar(context);
                          context.read<HomePageCubit>().deletePreviousEmployeeUI(i);
                        },
                        background: ColoredBox(
                          color: ASColors.redAccent,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(23.0),
                              child: Assets.icons.trash.image(),
                            ),
                          ),
                        ),
                        child: ListTile(
                          onTap: () => Navigator.of(context).pushNamed(ASRoutesNames.edit.path, arguments: {
                            "func": context.read<HomePageCubit>().onEmployeeChanged,
                            "data": state.previousEmployee[i]
                          }),
                          contentPadding: const EdgeInsets.all(16),
                          tileColor: Colors.white,
                          title: Text(
                            state.previousEmployee[i].employeeName,
                            style: ASTextStyles.listTitle,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                state.previousEmployee[i].role.name(AppLocalizations.of(context)),
                                style: ASTextStyles.secondaryButtonText.copyWith(color: ASColors.darkGrey),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                state.previousEmployee[i].datePresentationString(AppLocalizations.of(context)),
                                style: ASTextStyles.trailingText,
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: ASColors.lightBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).swipeLeftToDelete,
                  style: ASTextStyles.calendarDaysTextStyle.copyWith(color: ASColors.darkGrey),
                ),
                const SizedBox(
                  height: 32,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showDismissibleSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final dismissibleSnackBar = SnackBar(
      backgroundColor: ASColors.black,
      content: Text(
        AppLocalizations.of(context).employeeDataDeleted,
        style: ASTextStyles.calendarDaysTextStyle.copyWith(color: Colors.white),
      ),
      action: SnackBarAction(
        label: AppLocalizations.of(context).undo,
        textColor: ASColors.primary,
        onPressed: () {
          context.read<HomePageCubit>().undoDeletion();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(dismissibleSnackBar);
  }
}
