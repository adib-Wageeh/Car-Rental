import 'package:flutter/material.dart';
import '../../../../../../application/core/routes.dart';
import '../SwitchModeWidget.dart';

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SwitchModeWidget(theme: theme,text: 'CREATE ACCOUNT',route: Routes.register,);
  }
}