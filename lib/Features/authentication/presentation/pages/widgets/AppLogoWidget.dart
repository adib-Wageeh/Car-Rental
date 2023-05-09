import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../application/core/assets.dart';

class OnBoardingAppLogo extends StatelessWidget {
  const OnBoardingAppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
      child: Column(
        children:[
          Image.asset(Assets.onBoardingAppLogo,width: 120),
          Text("Rent Me",style: GoogleFonts.anton(fontSize: 32))
        ],
      ),
    );
  }
}