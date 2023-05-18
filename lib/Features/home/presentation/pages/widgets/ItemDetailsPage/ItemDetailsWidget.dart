import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../application/core/assets.dart';

class ItemDetailsWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String text;
  const ItemDetailsWidget({required this.icon,required this.title,required this.text,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon,color: Assets.appPrimaryWhiteColor,size: 20.sp),
          const SizedBox(width: 8,)
          ,Expanded(
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp),)),
                SizedBox(
                  width: double.infinity,
                  child: ReadMoreText(
                    text,
                    trimLines: 2,
                    style: TextStyle(fontSize: 14.sp,),
                    colorClickableText: Assets.appPrimaryWhiteColor,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                    lessStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}