part of 'cars_bloc.dart';

@immutable
abstract class CarsEvent extends Equatable{

}

class GetData extends CarsEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

  GetData();

}
