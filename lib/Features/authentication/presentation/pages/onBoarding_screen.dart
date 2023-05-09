import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/AppLogoWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/onBoarding/OnBoardingButton.dart';
import '../../../../application/core/assets.dart';
import '../../../../application/core/routes.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(Assets.onBoardingScreenBackGroundSmall), fit: BoxFit.cover),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const OnBoardingAppLogo(),
                  const Spacer(),
                  OnBoardingButton(text: 'Log In',onPressed: (){
                    Navigator.of(context).pushReplacement(Routes.routes(const RouteSettings(name: Routes.login)));
                    },),
                  const SizedBox(height: 12,),
                  OnBoardingButton(text: "Sign Up",onPressed: (){
                    Navigator.of(context).pushReplacement(Routes.routes(const RouteSettings(name: Routes.register)));
                  },textColor: Colors.blueAccent,)
                ],
              ),
            ),
          ),
        ),
      )
      ,
    );
  }
}




