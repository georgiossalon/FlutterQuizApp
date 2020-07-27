import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:results_repository/results_repository.dart';

import 'package:results_repository/results_repository.dart';

part 'results_event.dart';
part 'results_state.dart';

class ResultsBloc extends Bloc<ResultsEvent, ResultsState> {
  ResultsRepository _resultsRepository;

  ResultsBloc(@required ResultsRepository resultsRepository)
      : assert(resultsRepository != null),
        _resultsRepository = resultsRepository,
        super(ResultsInitial());

  @override
  Stream<ResultsState> mapEventToState(
    ResultsEvent event,
  ) async* {
    if (event is ResultsLoaded) {
      yield* _mapResultsLoadedToState();
    }
  }

  Stream<ResultsState> _mapResultsLoadedToState() async* {
    try {
      
      var results = await _resultsRepository.results;
      yield ResultsLoadSucess(results);
    } catch (e) {
      print(e);
      yield ResultsLoadFailure();
    }
  }
}
