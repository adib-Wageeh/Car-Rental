import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/AppLogoWidget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: OnBoardingAppLogo(),
          ),
        ],
      ),
    );
  }
}
