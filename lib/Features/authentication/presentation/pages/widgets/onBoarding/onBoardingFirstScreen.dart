import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../application/core/styles.dart';
import '../../../../../../constants.dart';

class OnBoardingFirstScreen extends StatelessWidget {
  const OnBoardingFirstScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.40),
      child: Column(
        children: [
          Text(onBoarding1Title1,style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.w700)),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Text(onBoarding1subtitle1,style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w300)),
          ),
        ],
      ),
    );
  }
}