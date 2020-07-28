part of 'questions_bloc.dart';

@immutable
abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object> get props => [];
}

class QuestionsLoaded extends QuestionsEvent {}

class AnswerClicked extends QuestionsEvent {
  final Result result;
  final Answer index;

  const AnswerClicked(this.result, this.index);

  @override
  List<Object> get props => [result, index];

  @override
  bool get stringify => true;
}
