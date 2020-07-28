import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

class Answer extends Equatable {
  final Color color;
  final String asnwerText;
  Answer({
    this.color,
    this.asnwerText,
  });

  Answer copyWith({
    Color color,
    String asnwerText,
  }) {
    return Answer(
      color: color ?? this.color,
      asnwerText: asnwerText ?? this.asnwerText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color?.value,
      'asnwerText': asnwerText,
    };
  }

  static Answer fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Answer(
      color: Color.black,
      asnwerText: map['asnwerText'],
    );
  }

  String toJson() => json.encode(toMap());

  static Answer fromJson(String source) => fromMap(json.decode(source));

  @override
  List<Object> get props => [
        color,
        asnwerText,
      ];

  @override
  bool get stringify => true;
}
