part of 'results_bloc.dart';

@immutable
abstract class ResultsState extends Equatable {
  const ResultsState();

  @override
  List<Object> get props => [];
}

class ResultsInitial extends ResultsState {}

class ResultsLoadSucess extends ResultsState {
  final List<Result> results;

  const ResultsLoadSucess([this.results = const []]);

  @override
  List<Object> get props => [results];

  @override
  bool get stringify => true;
}

class ResultsLoading extends ResultsState {}

class ResultsLoadFailure extends ResultsState {
  String error;

  const ResultsLoadFailure()
}
