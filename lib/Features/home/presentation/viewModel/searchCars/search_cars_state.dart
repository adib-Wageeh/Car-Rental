part of 'search_cars_bloc.dart';

@immutable
abstract class SearchCarsState {}

class SearchCarsInitial extends SearchCarsState {}

class SearchCarsLoading extends SearchCarsState {}

class SearchCarsLoaded extends SearchCarsState {}

class SearchCarsEmpty extends SearchCarsState {}

