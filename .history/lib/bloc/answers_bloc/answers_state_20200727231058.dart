part of 'answers_bloc.dart';

abstract class AnswersState extends Equatable {
  const AnswersState();
}

class AnswersInitial extends AnswersState {
  @override
  List<Object> get props => [];
}
