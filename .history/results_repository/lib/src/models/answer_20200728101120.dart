// import 'dart:convert';

// import 'package:equatable/equatable.dart';
// import 'package:flutter/painting.dart';

// class Answer extends Equatable {
//   Color color;
//   final String asnwerText;
//   final bool correct;
//   Answer({
//     this.color,
//     this.asnwerText,
//     this.correct,
//   });

//   @override
//   List<Object> get props => [
//         color,
//         asnwerText,
//       ];

//   @override
//   bool get stringify => true;

//   Answer copyWith({
//     Color color,
//     String asnwerText,
//     bool correct,
//   }) {
//     return Answer(
//       color: color ?? this.color,
//       asnwerText: asnwerText ?? this.asnwerText,
//       correct: correct ?? this.correct,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'color': color?.value,
//       'asnwerText': asnwerText,
//       'correct': correct,
//     };
//   }

//   static Answer fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return Answer(
//       color: Color(map['color']),
//       asnwerText: map['asnwerText'],
//       correct: map['correct'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   static Answer fromJson(String source) => fromMap(json.decode(source));
// }
