part of 'questions_bloc.dart';

@immutable
abstract class ResultsEvent extends Equatable {
  const ResultsEvent();

  @override
  List<Object> get props => [];
}

class ResultsLoaded extends ResultsEvent {}


