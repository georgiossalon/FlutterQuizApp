part of 'questions_bloc.dart';

@immutable
abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object> get props => [];
}

class QuestionsLoaded extends QuestionsEvent {}

class AnswerClicked extends QuestionsEvent {
  final Answer answer;
}