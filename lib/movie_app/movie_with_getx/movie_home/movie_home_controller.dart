import 'package:get/get.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/popular_entity.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';

class MovieHomeController extends GetxController {
  var listMovies = <Movie>[].obs;
  Rx<LoadingStatus> loadingStatus = LoadingStatus.init.obs;
  var currentPosTop = 0.obs;
  var currentPosBottom = 0.obs;

  @override
  void onReady() {
    super.onReady();
    getMovies();
  }

  getMovies() async {
    try {
      loadingStatus(LoadingStatus.loading);
      final response = await ApiService.fetchPopular();
      listMovies.value = response.results;
      loadingStatus(LoadingStatus.success);
    } catch (e) {
      loadingStatus(LoadingStatus.failure);
    }
  }

  void setCurrentPosTop({
    required int currentPos,
  }) {
    currentPosTop(currentPos);
  }

  void setCurrentPosBottom({
    required int currentPos,
  }) {
    currentPosBottom(currentPos);
  }
}
