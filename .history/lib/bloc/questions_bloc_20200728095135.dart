import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:results_repository/results_repository.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  ResultsRepository _resultsRepository;

  QuestionsBloc(ResultsRepository resultsRepository)
      : assert(resultsRepository != null),
        _resultsRepository = resultsRepository,
        super(QuestionsInitial());

  @override
  Stream<QuestionsState> mapEventToState(
    QuestionsEvent event,
  ) async* {
    if (event is QuestionsLoaded) {
      yield* _mapResultsLoadedToState();
    } else if (event is AnswerClicked) {
      yield* _mapAnswerClickedToState(event);
    }
  }

  Stream<QuestionsState> _mapResultsLoadedToState() async* {
    try {
      yield QuestionsLoading();
      var results = await _resultsRepository.results;
      yield QuestionsLoadSucess(results);
    } catch (e) {
      yield QuestionsLoadFailure(e.message);
    }
  }

  _mapAnswerClickedToState(AnswerClicked event) {}
}
