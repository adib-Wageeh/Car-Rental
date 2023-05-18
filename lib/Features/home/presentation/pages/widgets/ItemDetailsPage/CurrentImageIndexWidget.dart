import 'package:flutter/material.dart';

import '../../../../../../application/core/assets.dart';
import '../../../../../../models/entities/car_entity.dart';

class CurrentImageIndexWidget extends StatelessWidget {
  const CurrentImageIndexWidget({required this.carEntity,required this.selectedIndex,Key? key}) : super(key: key);
  final int selectedIndex;
  final CarEntity carEntity;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      List.generate(carEntity.images!.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 4),
          child: Container(
            width: (selectedIndex == index)? 15:10,
            height: (selectedIndex == index)? 15:10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (selectedIndex == index)? Assets.appPrimaryWhiteColor:Colors.grey,
            ),
          ),
        );
      }).toList()
      ,
    );
  }
}