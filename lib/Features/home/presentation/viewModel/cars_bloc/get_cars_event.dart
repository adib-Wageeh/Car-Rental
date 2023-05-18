part of 'get_cars_bloc.dart';

@immutable
abstract class GetCarsEvent {}

class GetFirstCarsEvent extends GetCarsEvent{}

class GetNextCarsEvent extends GetCarsEvent{}
