import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'app_bar_state.dart';

class AppBarCubit extends Cubit<AppBarState> {
  AppBarCubit() : super(AppBarInitial());

  final Map<String,IconData> icons={
    "Home":Icons.home,
    "Notifications":Icons.notifications_active,
    "Favorite":Icons.chat,
    "Settings":Icons.local_offer_rounded
  };
  int curPage=0;

  void changePage(int index){

    if(index == 0){
      curPage = 0;
      emit(AppBarInitial());
    }else
    if(index ==1){
      curPage = 1;
      emit(AppBarNotifications());
    }else
    if(index ==2){
      curPage = 2;
      emit(AppBarChats());
    }else{
      curPage = 3;
      emit(AppBarOffers());
    }

  }


}
