import 'dart:convert';

import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrect_answers;

  Result({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.incorrect_answers,
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
    String correctAnswer,
    List<String> incorrect_answers,
  }) {
    return Result(
      category: category ?? this.category,
      type: type ?? this.type,
      difficulty: difficulty ?? this.difficulty,
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      incorrect_answers: incorrect_answers ?? this.incorrect_answers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'type': type,
      'difficulty': difficulty,
      'question': question,
      'correctAnswer': correctAnswer,
      'allAnswers': incorrect_answers,
    };
  }

  static Result fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Result(
      category: map['category'],
      type: map['type'],
      difficulty: map['difficulty'],
      question: map['question'],
      correctAnswer: map['correctAnswer'],
      //todo: allAnswers does not exist, but "incorrect_answers"
      incorrect_answers: List<String>.from(map['incorrect_answers']),
    );
  }

  String toJson() => json.encode(toMap());

  static Result fromJson(String source) => fromMap(json.decode(source));

  @override
  List<Object> get props => [
        category,
        type,
        difficulty,
        question,
        correctAnswer,
        incorrect_answers,
      ];

  @override
  bool get stringify => true;
}
