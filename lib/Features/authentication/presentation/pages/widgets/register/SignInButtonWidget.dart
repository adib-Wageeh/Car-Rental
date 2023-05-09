import 'package:flutter/material.dart';
import '../../../../../../application/core/routes.dart';
import '../SwitchModeWidget.dart';

class SignInButtonWidget extends StatelessWidget {
  const SignInButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SwitchModeWidget(theme: theme,text: 'SIGN IN',route: Routes.login,);
  }
}