import 'package:get/get.dart';
import 'package:training_newwave/model/autogenerated_entity.dart';
import 'package:training_newwave/model/detail_movie_entity.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';

class MovieDetailController extends GetxController {
  int id = 0;
  var loadCast = LoadingStatus.init.obs;
  var loadDetail = LoadingStatus.init.obs;
  var detailMovie = DetailMovie().obs;
  var listCast = <Cast>[].obs;

  MovieDetailController({
    required this.id,
  });

  @override
  void onReady() {
    super.onReady();
    getDetail();
    getCast();
  }

  void getCast() async {
    try {
      loadCast(
        LoadingStatus.loading,
      );
      final response = await ApiService.fetchAutogenerated(id);
      listCast.value = response.cast ?? [];
      loadCast(
        LoadingStatus.success,
      );
    } catch (e) {
      loadCast(
        LoadingStatus.failure,
      );
    }
  }

  void getDetail() async {
    try {
      loadDetail(
        LoadingStatus.loading,
      );
      final response = await ApiService.fetchDetail(id);
      detailMovie.value = response;
      loadDetail(
        LoadingStatus.success,
      );
    } catch (e) {
      loadDetail(
        LoadingStatus.failure,
      );
    }
  }
}