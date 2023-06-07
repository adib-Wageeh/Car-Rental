import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../application/core/assets.dart';
import '../../../../../../models/entities/car_entity.dart';
import '../../../viewModel/cars_bloc/get_cars_bloc.dart';
import '../loading_view.dart';
import 'CarListViewItemWidget.dart';

class CarsListView extends StatelessWidget {
  const CarsListView({
    super.key,
    required this.controller,
  });

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        builder: (BuildContext context,
            AsyncSnapshot<List<CarEntity>> snapshot) {
          return BlocConsumer<GetCarsBloc,GetCarsState>(
              listener: (context,state){
                if(state is GetCarsEnded){
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Sorry!',
                      color: Assets.appPrimaryWhiteColor,
                      message:
                      'No more Cars please come back later',
                      contentType: ContentType.warning,
                      messageFontSize: 10.sp,
                      titleFontSize: 12.sp,
                    ),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                }
              },
              buildWhen: (curr,next)=>(next is GetCarsEnded)?false:true
              ,builder: (context,state){
            if(state is GetCarsLoaded){
              if(snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: ()async{
                    context.read<GetCarsBloc>().add(GetFirstCarsEvent());
                  }
                  ,child: ListView.builder(
                  controller: controller
                  , itemBuilder: (context, index) {
                  return CarListViewItemWidget(
                      carEntity: snapshot.data![index]);
                }, itemCount: snapshot.data!.length,),
                );
              }else{
                return const LoadingView();
              }
            }else{
              return const LoadingView();
            }
          });
        },
        stream: context.read<GetCarsBloc>().carsStream,
      ),
    );
  }
}
