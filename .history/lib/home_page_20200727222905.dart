import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/bloc/results_bloc.dart';
import 'package:quizapp/core/constants.dart';
import 'package:quizapp/quiz.dart';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:results_repository/results_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResultsBloc>(
      create: (context) =>
          ResultsBloc(ResultsRepository())..add(ResultsLoaded()),
      child: HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  // final String url = 'https://opentdb.com/api.php?amount=20';

  // Quiz quiz;
  // List<Result> results;
  // Color c;
  Random random = Random();

  // @override
  // void initState() {
  //   super.initState();
  // }

  // Future<void> fetchQuestions() async {
  //   // var res = await http.get("https://opentdb.com/api.php?amount=20");
  //   var res = await get(url);
  //   var decRes = jsonDecode(res.body);
  //   print(decRes);
  //   //! c brauche ich nicht
  //   // c = Colors.black;
  //   quiz = Quiz.fromJson(decRes);
  //   results = quiz.results;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
        elevation: 0.0,
      ),
      body: BlocListener<ResultsBloc, ResultsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: BlocBuilder<ResultsBloc, ResultsState>(
          builder: (context, state) {
            if (state is ResultsLoadSucess) {
              return RefreshIndicator(
                  //todo add an event for the onRefresh to fetch the questions
                  onRefresh: getQuestions,
                  child: const QuestionList()
                  // FutureBuilder(
                  //     future: get(url),
                  //     // future: http.get("https://opentdb.com/api.php?amount=20"),
                  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //       switch (snapshot.connectionState) {
                  //         case ConnectionState.none:
                  //           return Text('Press button to start.');
                  //         //! case without return
                  //         case ConnectionState.active:
                  //         case ConnectionState.waiting:
                  //           return const Center(
                  //             child: const CircularProgressIndicator(),
                  //           );
                  //         case ConnectionState.done:
                  //           if (snapshot.hasError) return errorData(snapshot);
                  //           return QuestionList(results: results);
                  //       }
                  //       return null;
                  //     }),
                  );
            } if (state is ResultsInitial) {
              
            }
          },
        ),
      ),
    );
  }

  Future<Null> getQuestions() async {
    context.bloc<ResultsBloc>().add(ResultsLoaded());
  }

  Padding errorData(AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Error: ${snapshot.error}',
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            child: Text("Try Again"),
            onPressed: () {
              context.bloc<ResultsBloc>().add(ResultsLoaded());
            },
          )
        ],
      ),
    );
  }
}

class QuestionList extends StatelessWidget {
  const QuestionList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultsBloc, ResultsState>(
      builder: (context, state) {
        if (state is ResultsLoadSucess) {
          return ListView.builder(
            itemCount: state.results.length,
            itemBuilder: (context, index) => Card(
              color: Colors.white,
              elevation: 0.0,
              child: ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        state.results[index].question,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FilterChip(
                              backgroundColor: Colors.grey[100],
                              label: Text(state.results[index].category),
                              onSelected: (b) {},
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            FilterChip(
                              backgroundColor: Colors.grey[100],
                              label: Text(
                                state.results[index].difficulty,
                              ),
                              onSelected: (b) {},
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  child: Text(
                      state.results[index].type.startsWith("m") ? "M" : "B"),
                ),
                children: state.results[index].allAnswers.map((m) {
                  return AnswerWidget(index, m);
                }).toList(),
              ),
            ),
          );
        }
        return kEmptyWidget;
      },
    );
  }
}

class AnswerWidget extends StatefulWidget {
  final int index;
  final String m;

  AnswerWidget(this.index, this.m);

  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  Color c = Colors.black;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultsBloc, ResultsState>(
      builder: (context, state) {
        if (state is ResultsLoadSucess) {
          return ListTile(
            onTap: () {
              //todo: add event
              setState(() {
                if (widget.m == state.results[widget.index].correctAnswer) {
                  c = Colors.green;
                } else {
                  c = Colors.red;
                }
              });
            },
            title: Text(
              widget.m,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: c,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return kEmptyWidget;
      },
    );
  }
}
