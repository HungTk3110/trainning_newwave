import 'package:get/get.dart';
import 'package:training_newwave/model/popular_entity.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';

class MovieController extends GetxController {
  var listMovies = <Movie>[].obs;
  var loading = true.obs;

  @override
  void onReady() {
    super.onReady();
    getMovies();
  }

  getMovies() async {
    try {
      loading(true);
      final response = await ApiService.fetchPopular();
      listMovies.value = response.results;
      loading(false);
    } catch (e) {
      loading(true);
    }
  }
}
