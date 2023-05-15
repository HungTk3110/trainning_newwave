part of 'weather_search_cubit.dart';

class WeatherSearchState extends Equatable {
  final LoadingStatus loadingStatus;
  final Weather? weather;

  const WeatherSearchState({
    this.loadingStatus = LoadingStatus.init,
    this.weather,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        weather,
      ];

  WeatherSearchState copyWith({
    LoadingStatus? loadingStatus,
    Weather? weather,
  }) {
    return WeatherSearchState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      weather: weather ?? this.weather,
    );
  }
}
