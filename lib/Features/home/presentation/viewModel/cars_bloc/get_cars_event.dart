part of 'get_cars_bloc.dart';

@immutable
abstract class GetCarsEvent {}

class GetFirstCarsEvent extends GetCarsEvent{
  GetFirstCarsEvent();
}

class GetNextCarsEvent extends GetCarsEvent{}

// class GetSortedCarsEvent extends GetCarsEvent{
//
//   final int type;
//   GetSortedCarsEvent({required this.type});
// }
//
// class GetNextSortedCarsEvent extends GetCarsEvent{}
