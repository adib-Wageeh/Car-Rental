import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/home_page/CarsListView.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/home_page/SortButtonWidget.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/home_page/search_widget.dart';
import 'package:rent_car/Features/home/presentation/viewModel/cars_bloc/get_cars_bloc.dart';
import '../../../../application/core/assets.dart';
import 'widgets/home_page/AddNewCarBottomSheet.dart';


class AppBarHomeView extends StatefulWidget {
  const AppBarHomeView({
    super.key,
  });

  @override
  State<AppBarHomeView> createState() => _AppBarHomeViewState();
}

class _AppBarHomeViewState extends State<AppBarHomeView> {

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }
  ScrollController controller = ScrollController();
  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
        context.read<GetCarsBloc>().add(GetNextCarsEvent());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         floatingActionButton: FloatingActionButton(
           backgroundColor: Assets.appPrimaryWhiteColor,
           onPressed: (){
             showModalBottomSheet(context: context, builder: (context){
              return const AddNewCarBottomSheet();
             },
               isScrollControlled: true,
             );
           },
           child: const Icon(Icons.add,size: 32,color: Colors.white),
         ),
        body: Column(
          children: [
            Row(
              children: const [
                SearchBarWidget(),
                SortButtonWidget(),
                SizedBox(width: 4,)
              ],
            )
            ,CarsListView(controller: controller),
          ],
        )
    );
  }
}
