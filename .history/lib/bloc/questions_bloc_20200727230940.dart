import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:results_repository/results_repository.dart';

import 'package:results_repository/results_repository.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, ResultsState> {
  ResultsRepository _resultsRepository;

  QuestionsBloc(@required ResultsRepository resultsRepository)
      : assert(resultsRepository != null),
        _resultsRepository = resultsRepository,
        super(ResultsInitial());

  @override
  Stream<ResultsState> mapEventToState(
    QuestionsEvent event,
  ) async* {
    if (event is QuestionsLoaded) {
      yield* _mapResultsLoadedToState();
    }
  }

  Stream<ResultsState> _mapResultsLoadedToState() async* {
    try {
      yield ResultsLoading();
      var results = await _resultsRepository.results;
      yield ResultsLoadSucess(results);
    } catch (e) {
      yield ResultsLoadFailure(e.message);
    }
  }
}
