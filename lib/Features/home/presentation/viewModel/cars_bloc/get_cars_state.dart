part of 'get_cars_bloc.dart';

@immutable
abstract class GetCarsState {}

class GetCarsInitial extends GetCarsState {}

class GetCarsLoading extends GetCarsState {}


class GetCarsLoaded extends GetCarsState {}
