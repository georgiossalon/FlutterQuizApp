import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/bloc/questions_bloc.dart';
import 'package:quizapp/core/constants.dart';

import 'package:results_repository/results_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuestionsBloc>(
      create: (context) => QuestionsBloc(ResultsRepository()),
      child: HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
        elevation: 0.0,
      ),
      body: BlocListener<QuestionsBloc, QuestionsState>(
        listener: (context, state) {
          if (state is QuestionsLoadFailure) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Row(
                children: <Widget>[
                  Expanded(child: Text(state.errorMessage)),
                  Icon(Icons.error),
                ],
              ),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: BlocBuilder<QuestionsBloc, QuestionsState>(
          builder: (context, state) {
            if (state is QuestionsLoadSucess) {
              return RefreshIndicator(
                  onRefresh: getQuestions, child: const QuestionList()
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
            }
            if (state is QuestionsInitial) {
              return Center(
                child: RaisedButton(
                  onPressed: () =>
                      context.bloc<QuestionsBloc>().add(QuestionsLoaded()),
                  child: Text('Press button to start.'),
                ),
              );
            }
            if (state is QuestionsLoading) {
              return Center(child: const CircularProgressIndicator());
            }
            if (state is QuestionsLoadFailure) {
              return Center(
                child: RaisedButton(
                  child: Text("Try Again"),
                  onPressed: () {
                    context.bloc<QuestionsBloc>().add(QuestionsLoaded());
                  },
                ),
              );
            }
            return kEmptyWidget;
          },
        ),
      ),
    );
  }

  Future<Null> getQuestions() async {
    context.bloc<QuestionsBloc>().add(QuestionsLoaded());
  }

  // Padding errorData(AsyncSnapshot snapshot) {
  //   return Padding(
  //     padding: const EdgeInsets.all(12.0),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Text(
  //           'Error: ${snapshot.error}',
  //         ),
  //         SizedBox(
  //           height: 20.0,
  //         ),
  //         RaisedButton(
  //           child: Text("Try Again"),
  //           onPressed: () {
  //             context.bloc<QuestionsBloc>().add(QuestionsLoaded());
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }
}

class QuestionList extends StatelessWidget {
  const QuestionList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (context, state) {
        if (state is QuestionsLoadSucess) {
          return ListView.builder(
            itemCount: state.results.length,
            itemBuilder: (context, index) => Card(
              color: Colors.white,
              elevation: 0.0,
              child: ExpansionTile(
                title: ExpansionTileTitle(index: index),
                leading: ExpansionTileLeading(index: index),
                //todo: extract children as Widget
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

class ExpansionTileLeading extends StatelessWidget {
  final int index;
  const ExpansionTileLeading({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey[100],
      child: BlocBuilder<QuestionsBloc, QuestionsState>(
        builder: (context, state) {
          if (state is QuestionsLoadSucess) {
            return Text(state.results[index].type.startsWith("m") ? "M" : "B");
          }
          return kEmptyWidget;
        },
      ),
    );
  }
}

class ExpansionTileTitle extends StatelessWidget {
  final int index;
  const ExpansionTileTitle({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: BlocBuilder<QuestionsBloc, QuestionsState>(
        builder: (context, state) {
          if (state is QuestionsLoadSucess) {
            return Column(
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
            );
          }
          return kEmptyWidget;
        },
      ),
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
    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (context, state) {
        if (state is QuestionsLoadSucess) {
          return ListTile(
            onTap: () {
              // //todo: add event
              // context.bloc<QuestionsBloc>().add(AnswerClicked(state.results[widget.index],widget.m));
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
