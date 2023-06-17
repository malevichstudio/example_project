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
              for (final i in state.currentEmployee)
                ListTile(
                  onTap: () => Navigator.of(context).pushNamed(ASRoutesNames.edit.path,
                      arguments: {"func": context.read<HomePageCubit>().onEmployeeChanged, "data": i}),
                  contentPadding: const EdgeInsets.all(16),
                  tileColor: Colors.white,
                  title: Text(
                    i.employeeName,
                    style: ASTextStyles.listTitle,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        i.role.name(AppLocalizations.of(context)),
                        style: ASTextStyles.secondaryButtonText.copyWith(color: ASColors.darkGrey),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        i.datePresentationString(AppLocalizations.of(context)),
                        style: ASTextStyles.trailingText,
                      ),
                    ],
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
              for (final i in state.previousEmployee)
                ListTile(
                  onTap: () => Navigator.of(context).pushNamed(ASRoutesNames.edit.path,
                      arguments: {"func": context.read<HomePageCubit>().onEmployeeChanged, "data": i}),
                  contentPadding: const EdgeInsets.all(16),
                  tileColor: Colors.white,
                  title: Text(
                    i.employeeName,
                    style: ASTextStyles.listTitle,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        i.role.name(AppLocalizations.of(context)),
                        style: ASTextStyles.secondaryButtonText.copyWith(color: ASColors.darkGrey),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        i.datePresentationString(AppLocalizations.of(context)),
                        style: ASTextStyles.trailingText,
                      ),
                    ],
                  ),
                )
            ],
          ],
        ),
      ),
    );
  }
}
