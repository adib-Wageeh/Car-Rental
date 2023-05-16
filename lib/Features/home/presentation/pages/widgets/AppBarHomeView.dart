import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../application/core/assets.dart';
import '../../viewModel/cars_bloc/cars_bloc.dart';
import 'loading_view.dart';

class AppBarHomeView extends StatelessWidget {
  const AppBarHomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         floatingActionButton: FloatingActionButton(
           backgroundColor: Assets.appPrimaryWhiteColor,
           onPressed: (){
             showModalBottomSheet(context: context, builder: (context){
              return const AddNewCarBottomSheet();
             });
           },
           child: const Icon(Icons.add,size: 32,color: Colors.white),
         ),
        body: BlocConsumer<CarsBloc,CarsState>(
          listener: (context,state){
            if(state is CarsError){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          buildWhen: (curr,next)=>(next is CarsError)?false:true,
          builder: (context,state){

            if(state is CarsLoaded){
              if(state.cars.isEmpty){
                return RefreshIndicator(
                  onRefresh: ()async{
                    BlocProvider.of<CarsBloc>(context).add(GetData());
                  }
                  ,child: ListView.builder(
                  itemBuilder: (context,index){
                    return const Text("Empty");
                  },
                  itemCount: state.cars.length,
                  ),
                );
              }else{
                return RefreshIndicator(
                  onRefresh: ()async{
                    BlocProvider.of<CarsBloc>(context).add(GetData());
                  },
                  child: ListView.builder(itemBuilder: (context,index){
                    return Text(state.cars[index].carName!);
                  },itemCount: state.cars.length,),
                );
              }
            }else{
              return const LoadingView();
            }
          },
        ),
    );
  }
}


class AddNewCarBottomSheet extends StatelessWidget {
  const AddNewCarBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: ListView(
          children: [

          ],
        ),
      ),
    );
  }
}
