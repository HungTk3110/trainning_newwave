import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/weather_app/models/weather_entity.dart';
import 'package:training_newwave/weather_app/models/weather_next_day_entity.dart';
import 'package:training_newwave/weather_app/models/weather_today_entity.dart';
import 'package:training_newwave/weather_app/networks/api_service.dart';

part 'weather_search_state.dart';

class WeatherSearchCubit extends Cubit<WeatherSearchState> {
  WeatherSearchCubit() : super(const WeatherSearchState());

  Future<void> searchByCity({
    required String city,
  }) async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );
    try {
      final responseWeather = await ApiService.fetchWeather(
        city: city,
      );
      if (responseWeather != null) {
        emit(
          state.copyWith(
            weather: responseWeather,
            loadingStatus: LoadingStatus.success,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.failure,
        ),
      );
    }
  }
}
