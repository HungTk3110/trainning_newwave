part of 'weather_home_cubit.dart';

class WeatherHomeState extends Equatable {
  final LoadingStatus loadingStatus;
  final Weather? weather;

  const WeatherHomeState({
    this.loadingStatus = LoadingStatus.init,
    this.weather,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        weather,
      ];

  WeatherHomeState copyWith({
    LoadingStatus? loadingStatus,
    Weather? weather,
  }) {
    return WeatherHomeState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      weather: weather ?? this.weather,
    );
  }
}
