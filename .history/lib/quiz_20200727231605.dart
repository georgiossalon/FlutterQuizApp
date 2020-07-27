// import 'package:results_repository/results_repository.dart';


// class Quiz {
//   int responseCode;
//   List<Result> results;

//   Quiz({this.responseCode, this.results});

//   Quiz.fromJson(Map<String, dynamic> json) {
//     responseCode = json['response_code'];
//     if (json['results'] != null) {
//       results = new List<Result>();
//       json['results'].forEach((v) {
//         // results.add(new Result.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['response_code'] = this.responseCode;
//     if (this.results != null) {
//       data['results'] = this.results.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }


