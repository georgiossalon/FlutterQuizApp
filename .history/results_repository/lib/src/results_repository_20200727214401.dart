import 'dart:convert';

import 'package:results_repository/src/models/models.dart';
// import 'package:http/http.dart';
import 'package:htt';

class ResultsRepository {
  final String url = 'https://opentdb.com/api.php?amount=20';

  Future<List<Result>> get results async {
    try {
      var res = await get(url);
      var decRes = jsonDecode(res.body);
      return decRes['results']
          .forEach((result) => Result.fromJson(result))
          .toList();
    } catch (e) {
      // todo: return something on error
      print(e);
      return null;
    }
  }
}
