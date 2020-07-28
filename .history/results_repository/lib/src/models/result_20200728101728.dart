import 'dart:convert';

import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> allAnswers;

  Result({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.allAnswers,
  });

  Result copyWith({
    String category,
    String type,
    String difficulty,
    String question,
    String correctAnswer,
    List<String> allAnswers,
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
      'correctAnswer': correctAnswer,
      'allAnswers': allAnswers,
    };
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
        allAnswers,
      ];

  @override
  bool get stringify => true;

  static Result fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Result(
      category: map['category'],
      type: map['type'],
      difficulty: map['difficulty'],
      question: map['question'],
      correctAnswer: map['correct_answer'],
      allAnswers: List.from(map['incorrect_answers'])
        ..add(map['correct_answer'])
        ..shuffle(),
    );
  }
}
