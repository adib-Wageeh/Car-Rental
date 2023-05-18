import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplitterWidget extends StatelessWidget {
  const SplitterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.black),
        height: 0.2,
      ),
    );
  }
}
