import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/weather_app/models/weather_entity.dart';
import 'package:training_newwave/weather_app/models/weather_next_day_entity.dart';
import 'package:training_newwave/weather_app/models/weather_today_entity.dart';
import 'package:training_newwave/weather_app/networks/api_service.dart';

part 'weather_home_state.dart';

class WeatherHomeCubit extends Cubit<WeatherHomeState> {
  WeatherHomeCubit() : super(const WeatherHomeState());

  Future<void> initDataWeather({
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

      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.success,
          weather: responseWeather,
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

  Future<void> initDataWeatherToday({
    required String city,
  }) async {
    emit(
      state.copyWith(
        loadingStatusWeatherToday: LoadingStatus.loading,
      ),
    );
    try {
      final responWeatherToday = await ApiService.fetchWeatherToday(
        city: city,
      );
      emit(
        state.copyWith(
          loadingStatusWeatherToday: LoadingStatus.success,
          weatherToday: responWeatherToday,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingStatusWeatherToday: LoadingStatus.failure,
        ),
      );
    }
  }

  Future<void> initDataWeatherNextDay({
    required String city,
  }) async {
    emit(
      state.copyWith(
        loadingStatusWeatherNextDay: LoadingStatus.loading,
      ),
    );
    try {
      final responWeatherNextDay = await ApiService.fetchWeatherNextDay(
        city: city,
      );
      emit(
        state.copyWith(
          loadingStatusWeatherNextDay: LoadingStatus.success,
          weatherNextDay: responWeatherNextDay,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingStatusWeatherNextDay: LoadingStatus.failure,
        ),
      );
    }
  }
}
