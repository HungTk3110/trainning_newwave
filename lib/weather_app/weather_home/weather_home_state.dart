part of 'weather_home_cubit.dart';

class WeatherHomeState extends Equatable {
  final LoadingStatus loadingStatus;
  final LoadingStatus loadingStatusWeatherToday;
  final LoadingStatus loadingStatusWeatherNextDay;
  final Weather? weather;
  final WeatherToday? weatherToday;
  final WeatherNextDay? weatherNextDay;

  const WeatherHomeState({
    this.loadingStatus = LoadingStatus.init,
    this.loadingStatusWeatherToday = LoadingStatus.init,
    this.loadingStatusWeatherNextDay = LoadingStatus.init,
    this.weather,
    this.weatherToday,
    this.weatherNextDay,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        loadingStatusWeatherToday,
        loadingStatusWeatherNextDay,
        weather,
        weatherToday,
        weatherNextDay,
      ];

  WeatherHomeState copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? loadingStatusWeatherToday,
    LoadingStatus? loadingStatusWeatherNextDay,
    Weather? weather,
    WeatherToday? weatherToday,
    WeatherNextDay? weatherNextDay,
  }) {
    return WeatherHomeState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      loadingStatusWeatherToday:
          loadingStatusWeatherToday ?? this.loadingStatusWeatherToday,
      loadingStatusWeatherNextDay:
          loadingStatusWeatherNextDay ?? this.loadingStatusWeatherNextDay,
      weather: weather ?? this.weather,
      weatherToday: weatherToday ?? this.weatherToday,
      weatherNextDay: weatherNextDay ?? this.weatherNextDay,
    );
  }
}
