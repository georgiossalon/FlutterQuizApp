import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'answers_event.dart';
part 'answers_state.dart';

class AnswersBloc extends Bloc<AnswersEvent, AnswersState> {
  AnswersBloc() : super(AnswersInitial());

  @override
  Stream<AnswersState> mapEventToState(
    AnswersEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
