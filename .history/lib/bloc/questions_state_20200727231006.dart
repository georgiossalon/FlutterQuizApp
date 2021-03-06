part of 'questions_bloc.dart';

@immutable
abstract class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object> get props => [];
}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoadSucess extends QuestionsState {
  final List<Result> results;

  const QuestionsLoadSucess([this.results = const []]);

  @override
  List<Object> get props => [results];

  @override
  bool get stringify => true;
}

class QuestionsLoading extends QuestionsState {}

class ResultsLoadFailure extends QuestionsState {
  final String errorMessage;

  ResultsLoadFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  bool get stringify => true;
}
