import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:training_newwave/model/detail_movie_entity.dart';
import 'package:training_newwave/model/popular_entity.dart';

class ApiService {
  static const String urlPopular =
      "https://api.themoviedb.org/3/movie/popular?api_key=9bb89316d8693b06d7a84980b29c011f";

  static Future<Popular> fetchPopular() async {
    final apiResponse = await http.get(Uri.parse(urlPopular));
    if (apiResponse.statusCode == 200) {
      return Popular.fromJson(jsonDecode(apiResponse.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<DetailMovie> fetchDetail(int id) async{

    String urlDetail = "https://api.themoviedb"
        ".org/3/movie/$id?api_key=9bb89316d8693b06d7a84980b29c011f";

    final apiResponse = await http.get(Uri.parse(urlDetail));
    if (apiResponse.statusCode == 200) {
      return DetailMovie.fromJson(jsonDecode(apiResponse.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
