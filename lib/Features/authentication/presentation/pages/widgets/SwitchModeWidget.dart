import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../application/core/routes.dart';
import '../../viewModel/signUp_cubit/sign_up_cubit.dart';

class SwitchModeWidget extends StatelessWidget {
  const SwitchModeWidget({
    super.key,
    required this.theme,
    required this.text,
    required this.route
  });
  final String text;
  final ThemeData theme;
  final String route;
  @override
  Widget build(BuildContext context) {
    context.read<SignUpCubit>().clearState();
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(context, Routes.routes(RouteSettings(name: route)));
      },
      child: Text(
        text,
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}