part of 'cars_bloc.dart';

@immutable
abstract class CarsState  extends Equatable{}

class CarsInitial extends CarsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CarsError extends CarsState {

  final String error;
  CarsError({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class CarsLoading extends CarsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CarsLoaded extends CarsState {

  final List<CarEntity> cars;
  CarsLoaded({required this.cars});

  @override
  // TODO: implement props
  List<Object?> get props => [cars];
}

