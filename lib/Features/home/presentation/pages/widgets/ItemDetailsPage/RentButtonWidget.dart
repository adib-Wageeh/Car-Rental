import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_car/Features/home/presentation/viewModel/app_bar/app_bar_cubit.dart';
import 'package:rent_car/Features/home/presentation/viewModel/getUserData/get_user_data_cubit.dart';
import 'package:rent_car/Features/home/presentation/viewModel/offers_bloc/offers_cubit.dart';
import 'package:rent_car/models/entities/car_entity.dart';
import 'package:sizer/sizer.dart';

class RentButtonWidget extends StatelessWidget {
  final CarEntity carEntity;
  const RentButtonWidget({required this.carEntity,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 10.h,
        height: 9.h,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent)
            ,onPressed: (){
              if(carEntity.userEntity!.id != FirebaseAuth.instance.currentUser!.uid){
                context.read<OffersCubit>().addOffer(carEntity.id,carEntity.userEntity!.id);
              }
              Navigator.pop(context);
              context.read<AppBarCubit>().changePage(2);
        }, child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children:
              (context.read<UserCubit>().state.id != carEntity.userEntity!.id)?
              const[
                Icon(FontAwesomeIcons.arrowRight),
                Text("Rent")
              ]:
              const[
                Icon(FontAwesomeIcons.stackExchange),
                Text("Offers")
              ]
            )));
  }
}
