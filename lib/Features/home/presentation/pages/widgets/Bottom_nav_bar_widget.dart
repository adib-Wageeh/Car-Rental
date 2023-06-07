import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../application/core/assets.dart';
import '../../viewModel/app_bar/app_bar_cubit.dart';
import '../../viewModel/cars_bloc/get_cars_bloc.dart';

class BottomNavigationBarWidget extends StatelessWidget {

  final BuildContext contextTheme;
  const BottomNavigationBarWidget(this.contextTheme,{
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBarCubit, AppBarState>(
      builder: (context, state) {
        return BottomNavigationBar(
          items: bottomNavigationBarItems(contextTheme),
          onTap: (index)async{
            BlocProvider.of<AppBarCubit>(contextTheme).changePage(index);
          },
          currentIndex: BlocProvider.of<AppBarCubit>(contextTheme).curPage,
          elevation: 20,
          showSelectedLabels: false,
          // selectedLabelStyle: TextStyle(color: Assets.appPrimaryWhiteColor),
          selectedItemColor: Assets.appPrimaryWhiteColor,
          unselectedItemColor: Colors.black,
        );
      },
    );
  }
}


List<BottomNavigationBarItem> bottomNavigationBarItems(BuildContext context){
  final bloc = BlocProvider.of<AppBarCubit>(context);
  return List.generate(4, (index){
    if(bloc.curPage == index){
      return BottomNavigationBarItem(label: bloc.icons.keys.elementAt(index),icon: Icon(bloc.icons.values.elementAt(index),size: 34),);
    }
    return BottomNavigationBarItem(label: bloc.icons.keys.elementAt(index),icon: Icon(bloc.icons.values.elementAt(index),size: 28),);
  });
}