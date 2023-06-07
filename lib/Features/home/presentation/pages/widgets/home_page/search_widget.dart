import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../application/core/assets.dart';
import '../../../../../../application/core/routes.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
        child: InkWell(
          onTap: (){
            Navigator.push(context, Routes.routes(const RouteSettings(name: Routes.searchPage)));
          },
          child: Container(
            width: double.infinity,
            height: 7.h,
            decoration: BoxDecoration(
              color: Assets.searchBarColor,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children:  [
                SizedBox(width: 5.w,),
                Icon(FontAwesomeIcons.magnifyingGlass,color: Colors.black,size: 16.sp),
                SizedBox(width: 5.w,),
                Text("Search",style: TextStyle(fontSize: 16.sp,color: Colors.black54),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
