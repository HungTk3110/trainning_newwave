import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/movie_app/widget/loading_widget.dart';
import 'package:training_newwave/weather_app/models/weather_entity.dart';
import 'package:training_newwave/weather_app/models/weather_next_day_entity.dart';
import 'package:training_newwave/weather_app/models/weather_today_entity.dart';
import 'package:training_newwave/weather_app/weather_home/weather_home_cubit.dart';
import 'package:training_newwave/weather_app/widget/weather_today_widget.dart';
import 'package:training_newwave/weather_app/widget/weather_for_next_days_widget.dart';
import 'package:training_newwave/weather_app/widget/weather_in_city_more_widget.dart';

class WeatherHomeWidget extends StatefulWidget {
  final String city;
  const WeatherHomeWidget({
    required this.city,
    Key? key,
  }) : super(key: key);

  @override
  State<WeatherHomeWidget> createState() => _WeatherHomeWidgetState();
}

class _WeatherHomeWidgetState extends State<WeatherHomeWidget> {
  late final WeatherHomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = WeatherHomeCubit();
    _cubit.initDataWeatherNextDay(
      city: widget.city,
    );
    _cubit.initDataWeather(
      city: widget.city,
    );
    _cubit.initDataWeatherToday(
      city: widget.city,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocProvider(
        create: (context) => _cubit,
        child: BlocBuilder<WeatherHomeCubit, WeatherHomeState>(
          buildWhen: (previous, current) =>
              previous.loadingStatus != current.loadingStatus ||
              previous.loadingStatusWeatherToday !=
                  current.loadingStatusWeatherToday ||
              previous.loadingStatusWeatherNextDay !=
                  current.loadingStatusWeatherNextDay,
          builder: (context, state) {
            if (state.loadingStatus == LoadingStatus.loading &&
                state.loadingStatusWeatherToday == LoadingStatus.init &&
                state.loadingStatusWeatherNextDay == LoadingStatus.loading) {
              return const LoadingWidget();
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 62,
                    ),
                    WeatherInCityMore(
                      weather: state.weather ?? Weather(),
                    ),
                    WeatherTodayWidget(
                      weatherToday: state.weatherToday ?? WeatherToday(),
                    ),
                    WeatherForNextDay(
                      weatherNextDay: state.weatherNextDay ??
                          WeatherNextDay(
                              code: '', message: 0.0, cnt: 0, list: []),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
