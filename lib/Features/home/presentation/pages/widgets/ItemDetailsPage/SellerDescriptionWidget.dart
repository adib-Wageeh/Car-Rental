import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../models/entities/user_entity.dart';
import 'RentButtonWidget.dart';

class SellerDescriptionWidget extends StatelessWidget {
  final UserEntity userEntity;
  const SellerDescriptionWidget({required this.userEntity,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(userEntity);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
      child: Container(
        height: 8.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(128),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CachedNetworkImage(
              width: 8.h,
              height: 8.h,
              placeholder: (context, url) => const CircularProgressIndicator(),
              imageUrl: userEntity.photo!,
              imageBuilder: (context, imageProvider) { // you can access to imageProvider
                return CircleAvatar( // or any widget that use imageProvider like (PhotoView)
                  backgroundImage: imageProvider,
                );
              },
            ),
            const SizedBox(width: 8,),
            Text(userEntity.name!,style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
            const Spacer(),
            const RentButtonWidget()
          ],
        ),
      ),
    );
  }
}