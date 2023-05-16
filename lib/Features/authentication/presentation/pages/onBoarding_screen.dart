import 'package:flutter/material.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/onBoarding/OnBoardingSecondScreen.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/onBoarding/onBoardingFirstScreen.dart';
import '../../../../application/core/assets.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import '../../../../application/core/routes.dart';

class OnBoarding extends StatelessWidget {

  const OnBoarding({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OnBoardingSlider(
          centerBackground: true,
          headerBackgroundColor: ThemeData.light().scaffoldBackgroundColor,
          finishButtonText: 'Register',
          onFinish: (){
            Navigator.push(context, Routes.routes(const RouteSettings(name: Routes.register)));
          },
          hasFloatingButton: true,
          finishButtonStyle: FinishButtonStyle(
            backgroundColor: Assets.appPrimaryWhiteColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(42)),
          ),
          controllerColor: Assets.appPrimaryWhiteColor,
          background: [
            SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.2),
                  child: Image.asset(Assets.onBoardingScreenBackGround,),
                )),
            Container()
          ],
          totalPage: 2,
          finishButtonTextStyle: const TextStyle(fontSize: 24),
          speed: 1.8,
          pageBodies: [
            const OnBoardingFirstScreen(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OnBoardingSecondScreen(controller: ScrollController()),
            ),
          ],
        ),
      ),
    );
  }
}



