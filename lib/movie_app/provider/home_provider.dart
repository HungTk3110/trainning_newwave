import 'package:flutter/cupertino.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
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
}
