import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/weather_app/models/weather.dart';
import 'package:training_newwave/weather_app/networks/api_service.dart';

part 'weather_home_state.dart';

class WeatherHomeCubit extends Cubit<WeatherHomeState> {
  WeatherHomeCubit() : super(const WeatherHomeState());

  Future<void> initData({
    required String city,
  }) async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );
    try {
      final response = await ApiService.fetchWeather(
        city: city,
      );

      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.success,
          weather: response,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.failure,
        ),
      );
    }
  }
}
