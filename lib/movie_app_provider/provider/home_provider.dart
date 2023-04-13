import 'package:flutter/cupertino.dart';
import 'package:training_newwave/model/autogenerated_entity.dart';
import 'package:training_newwave/model/detail_movie_entity.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/movie_collection_entity.dart';
import 'package:training_newwave/model/popular_entity.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';

class HomeProvider extends ChangeNotifier {
  List<Movie> listMovies = [];
  LoadingStatus loadListPopularStatus = LoadingStatus.init;

  Future<void> getAllMovies() async {
    loadListPopularStatus = LoadingStatus.loading;
    try {
      final response = await ApiService.fetchPopular();
      listMovies = response.results;
      loadListPopularStatus = LoadingStatus.success;

      notifyListeners();
    } catch (e) {
      loadListPopularStatus = LoadingStatus.failure;
    }
  }


  //
  // Future<List<Cast>> getListCast(int id) async {
  //   final response = await ApiService.fetchAutogenerated(id);
  //   notifyListeners();
  //   return response.cast;
  // }
}
