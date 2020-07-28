import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:results_repository/results_repository.dart';

class Result extends Equatable {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final Answer correctAnswer;
  final List<Answer> allAnswers;

  //todo: the answers should be objects that contain a String and a Color property
  //todo. create an Answers class

  Result({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.allAnswers,
  });

  // Results({
  //   this.category,
  //   this.type,
  //   this.difficulty,
  //   this.question,
  //   this.correctAnswer,
  // });

  // Results.fromJson(Map<String, dynamic> json) {
  //   category = json['category'];
  //   type = json['type'];
  //   difficulty = json['difficulty'];
  //   question = json['question'];
  //   correctAnswer = json['correct_answer'];
  //   allAnswers = json['incorrect_answers'].cast<String>();
  //   allAnswers.add(correctAnswer);
  //   allAnswers.shuffle();
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['category'] = this.category;
  //   data['type'] = this.type;
  //   data['difficulty'] = this.difficulty;
  //   data['question'] = this.question;
  //   data['correct_answer'] = this.correctAnswer;
  //   data['incorrect_answers'] = this.allAnswers;
  //   return data;
  // }

  Result copyWith({
    String category,
    String type,
    String difficulty,
    String question,
    Answer correctAnswer,
    List<Answer> allAnswers,
  }) {
    return Result(
      category: category ?? this.category,
      type: type ?? this.type,
      difficulty: difficulty ?? this.difficulty,
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      allAnswers: allAnswers ?? this.allAnswers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'type': type,
      'difficulty': difficulty,
      'question': question,
      'correctAnswer': correctAnswer?.toMap(),
      'allAnswers': allAnswers?.map((x) => x?.toMap())?.toList(),
    };
  }

  // static Result fromMap(Map<String, dynamic> map) {
  //   if (map == null) return null;
  //   return Result(
  //     category: map['category'],
  //     type: map['type'],
  //     difficulty: map['difficulty'],
  //     question: map['question'],
  //     correctAnswer: map['correct_answer'],
  //     allAnswers: List.from(map['incorrect_answers'])
  //       ..add(map['correct_answer'])..shuffle(),
  //   );
  // }

  String toJson() => json.encode(toMap());

  static Result fromJson(String source) => fromMap(json.decode(source));

  @override
  List<Object> get props => [
        category,
        type,
        difficulty,
        question,
        correctAnswer,
        allAnswers,
      ];

  @override
  bool get stringify => true;

  static Result fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    var t = List<Answer>.from(
        // map['incorrect_answers']?.map((x) => Answer.fromString(x)))
        map['incorrect_answers']
            ?.map((x) => Answer(asnwerText: x, color: Colors.black))
      ..add(Answer.fromString(map['correct_answer']))
      ..shuffle();

    return Result(
      category: map['category'],
      type: map['type'],
      difficulty: map['difficulty'],
      question: map['question'],
      correctAnswer: Answer.fromString(map['correctAnswer']),
      allAnswers: List<Answer>.from(
          map['incorrect_answers']?.map((x) => Answer.fromString(x)))
        ..add(Answer.fromString(map['correct_answer']))
        ..shuffle(),
    );
  }
}
