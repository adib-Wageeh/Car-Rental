import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../application/core/assets.dart';
import '../../../../../../application/core/routes.dart';
import '../../../../../../models/entities/car_entity.dart';

class CarListViewItemWidget extends StatelessWidget {

  final CarEntity carEntity;
  const CarListViewItemWidget({required this.carEntity,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
      child: Container(
        width: double.infinity,
        height: 110.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Colors.black26),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: (){
              // UserEntity userEntity = await context.read<CarDescriptionCubit>().getCarSeller(carEntity.sellerUid);
              Navigator.push(context, Routes.routes(RouteSettings(name: Routes.itemDetails,arguments: carEntity)));
            },
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1
                  ,child: Hero(
                  tag: carEntity.id,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      imageUrl: carEntity.images![0],
                    ),
                  ),
                ),
                ),
                const SizedBox(width: 4,),
                Padding(
                  padding: EdgeInsets.only(top: size.height*0.003),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: size.width*0.5
                          ,child: Text(carEntity.carName!,style: const TextStyle(fontSize: 20),overflow: TextOverflow.ellipsis)),
                      SizedBox(
                          width: size.width*0.5,
                          height: size.height*0.075,
                          child: Text(maxLines: 2,carEntity.location,style: const TextStyle(fontSize: 16,color: Colors.grey),overflow: TextOverflow.ellipsis)),
                      const Spacer(),
                      SizedBox(
                        width: size.width*0.55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("${double.parse(carEntity.pricePerDay!).toInt().toString()}\$/day",style: const TextStyle(fontSize: 18),overflow: TextOverflow.ellipsis,),
                            Text("${carEntity.addedDate} ago",style: TextStyle(fontSize: 14,color: Assets.appPrimaryWhiteColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}