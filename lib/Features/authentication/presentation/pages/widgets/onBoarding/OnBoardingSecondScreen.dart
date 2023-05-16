import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../application/core/assets.dart';
import '../../../../../../application/core/styles.dart';
import '../../../../../../constants.dart';

class OnBoardingSecondScreen extends StatelessWidget {

  final ScrollController controller;
  const OnBoardingSecondScreen({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children:  <Widget>[
          Text(onBoarding2Title2,style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.w700)),
          SizedBox(height: 3.h,),

          Icon(FontAwesomeIcons.addressCard,size: 50.sp,color: Assets.appPrimaryWhiteColor),
          Text(textAlign: TextAlign.center,onBoarding2subTitle1,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w300)),
          SizedBox(height: 2.h,),

          Icon(FontAwesomeIcons.car,size: 50.sp,color: Assets.appPrimaryWhiteColor),
          Text(textAlign: TextAlign.center,onBoarding2subTitle2,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w300)),
          SizedBox(height: 2.h,),

          Icon(FontAwesomeIcons.businessTime,size: 50.sp,color: Assets.appPrimaryWhiteColor),
          Text(textAlign: TextAlign.center,onBoarding2subTitle3,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w300)),
          SizedBox(height: 2.h,),

          Icon(FontAwesomeIcons.handshake,size: 50.sp,color: Assets.appPrimaryWhiteColor),
          Text(textAlign: TextAlign.center,onBoarding2subTitle4,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w300)),
          SizedBox(height: 12.h,)
        ],
      ),
    );
  }
}