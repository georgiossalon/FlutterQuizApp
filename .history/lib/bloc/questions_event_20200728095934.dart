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
  final Answer answer;

  const AnswerClicked(this.result, this.answer);

  @override
  List<Object> get props => [result, answer];

  @override
  bool get stringify => true;
}
