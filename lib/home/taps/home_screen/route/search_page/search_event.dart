import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddSearchEvent extends SearchEvent {
  final String query;

  AddSearchEvent(this.query);

  @override
  List<Object> get props => [query];
}

class RemoveSearchEvent extends SearchEvent {
  final String query;

  RemoveSearchEvent(this.query);

  @override
  List<Object> get props => [query];
}

class UpdateSearchQueryEvent extends SearchEvent {
  final String query;

  UpdateSearchQueryEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ClearAllSearchEvent extends SearchEvent {}
