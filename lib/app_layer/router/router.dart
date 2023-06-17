import 'package:assignment/app_layer/app/injection.dart';
import 'package:assignment/app_layer/router/names.dart';
import 'package:assignment/domain_layer/entities/employee.dart';
import 'package:assignment/domain_layer/entities/employee_presentation.dart';
import 'package:assignment/presentation_payer/edit/cubit/edit_page_cubit.dart';
import 'package:assignment/presentation_payer/edit/edit.dart';
import 'package:assignment/presentation_payer/home/cubit/home_page_cubit.dart';
import 'package:assignment/presentation_payer/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

abstract class ASNavigator {
  Future showModalBottom({
    required ASModalBottomSheet widget,
    Color backgroundColor = Colors.white,
    double? height,
  });

  void showCustomDialog({
    required Widget widget,
  });

  GlobalKey<NavigatorState> get navigatorKey;

  Route<dynamic>? generateRoute(RouteSettings settings);
}

@Singleton(as: ASNavigator)
class ASNavigatorImpl implements ASNavigator {
  ASNavigatorImpl();

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Route<dynamic>? generateRoute(RouteSettings settings) {
    final routeName = getASRoutesNames(settings.name);

    switch (routeName) {
      case ASRoutesNames.home:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<HomePageCubit>(create: (_) => getIt<HomePageCubit>(), child: const HomePage());
          },
        );
      case ASRoutesNames.edit:
        final args = settings.arguments as Map<String, dynamic>;
        final employee = args["data"] as ASEmployee?;
        final func = args["func"] as Function(ASEmployeePresentation);
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
                create: (_) => getIt<EditPageCubit>(),
                child: EditPage(
                  employee: employee,
                  onEmployeeChanged: func,
                ));
          },
        );
    }
  }

  @override
  Future showModalBottom({
    required ASModalBottomSheet widget,
    Color backgroundColor = Colors.white,
    double? height,
  }) {
    return showModalBottomSheet(
      context: navigatorKey.currentContext!,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            color: backgroundColor,
            child: SizedBox(
              height: height != null ? height + keyboardHeight : null,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: IntrinsicHeight(
                  child: Container(
                    padding: EdgeInsets.only(bottom: keyboardHeight),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (height != null) Expanded(child: widget),
                        if (height == null) widget,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void showCustomDialog({
    required Widget widget,
  }) {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  child: widget,
                ),
              ),
            ),
          );
        });
  }
}

abstract class ASModalBottomSheet extends StatefulWidget {
  const ASModalBottomSheet({super.key});
}
