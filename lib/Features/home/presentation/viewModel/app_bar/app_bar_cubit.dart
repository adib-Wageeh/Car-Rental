import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_bar_state.dart';

class AppBarCubit extends Cubit<AppBarState> {
  AppBarCubit() : super(AppBarInitial());

  int currIndex = 0;

  void setDefaultView(){
    currIndex = 0;
    emit(AppBarInitial());
  }

  void setHomeView(){
    currIndex = 0;
    emit(AppBarHome());
  }

  void setNotificationsView(){
    currIndex = 1;
    emit(AppBarNotifications());
  }

  void setChatsView(){
    currIndex = 2;
    emit(AppBarChats());
  }

  void setOffersView(){
    currIndex = 3;
    emit(AppBarOffers());
  }

}
