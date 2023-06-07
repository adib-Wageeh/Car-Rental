part of 'search_cars_bloc.dart';

@immutable
abstract class SearchCarsEvent {}

class EditSearchCarsEvent extends SearchCarsEvent{
  final String text;
  EditSearchCarsEvent({required this.text});
}

class EmptySearchCarsEvent extends SearchCarsEvent{}
