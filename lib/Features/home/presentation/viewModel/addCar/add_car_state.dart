part of 'add_car_cubit.dart';

@immutable
abstract class AddCarState {}

class AddCarInitial extends AddCarState {}

class AddCarLoading extends AddCarState {}

class AddCarError extends AddCarState {

  final String error;
  AddCarError({required this.error});
}

class AddCarSuccessfully extends AddCarState {}
