import 'package:flutter/material.dart';

import '../../../../../../application/core/routes.dart';


class ForgetYourPasswordWidget extends StatelessWidget {
  const ForgetYourPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Forget Your Password?",),
        TextButton(onPressed: (){
            Navigator.push(context, Routes.routes(const RouteSettings(name: Routes.reset)));
        }, child: const Text("RESET"))
      ],
    );
  }
}