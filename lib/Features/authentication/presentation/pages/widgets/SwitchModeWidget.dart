import 'package:flutter/material.dart';
import '../../../../../application/core/routes.dart';



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