import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/model/detail_movie_entity.dart';
import 'package:training_newwave/model/popular_entity.dart';

class ApiService {

  static Future<Popular> fetchPopular() async {
    final response = await http.get(Uri.parse(AppConstant.urlPopular));
    if (response.statusCode == 200) {
      return Popular.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception("Not Found");
    } else {
      throw Exception("Cant get Popular");
    }
  }

  static Future<DetailMovie> fetchDetailMovie(int id) async {
    String urlDetail = "https://api.themoviedb.org/3/movie/$id?api_key=9bb89316d8693b06d7a84980b29c011f";
    final response = await http.get(Uri.parse(urlDetail));
    if (response.statusCode == 200) {
      return DetailMovie.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception("Not Found");
    } else {
      throw Exception("Cant get Popular");
    }
  }

  static Future<List<Movie>> fetchMovie() async{

    final response = await http.get(Uri.parse(AppConstant.urlPopular));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return (responseJson['results'] as List).map((json) => Movie.fromJson(json)).toList();
    }else if (response.statusCode == 404) {
      throw Exception("Not Found");
    } else {
      throw Exception("Cant get Movie");
    }
  }
}
