import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../application/core/routes.dart';
import '../../../../../../models/entities/car_entity.dart';
import '../../../viewModel/searchCars/search_cars_bloc.dart';
import '../SplitterWidget.dart';
import '../loading_view.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        builder: (BuildContext context,
            AsyncSnapshot<List<CarEntity>> snapshot) {
          return BlocBuilder<SearchCarsBloc,SearchCarsState>(
              builder: (context,state){
                if(state is SearchCarsLoaded){
                  if(snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (context,index){
                        return Column(
                          children: const [
                            SizedBox(height: 8,),
                            SplitterWidget(),
                            SizedBox(height: 8,),
                          ],
                        );
                      },
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, Routes.routes(RouteSettings(name: Routes.itemDetails,arguments: snapshot.data![index])));
                          }
                          ,child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(snapshot.data![index].carName!,style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text(snapshot.data![index].location),
                              ],
                            ),
                          ),
                        ),
                        );
                      }, itemCount: snapshot.data!.length,);
                  }else{
                    return const LoadingSearchView();
                  }
                }else if(state is SearchCarsEmpty){
                  return const Center(child:
                  Text("No results !!!")
                  );
                }else{
                  return const LoadingSearchView();
                }
              });
        },
        stream: context.read<SearchCarsBloc>().carsStream,
      ),
    );
  }
}
