
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class RentButtonWidget extends StatelessWidget {
  const RentButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 8.h,
        height: 8.h,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent)
            ,onPressed: (){}, child: const Icon(FontAwesomeIcons.message)));
  }
}
