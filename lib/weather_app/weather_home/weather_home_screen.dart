import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/movie_app/widget/loading_widget.dart';
import 'package:training_newwave/weather_app/models/weather_entity.dart';
import 'package:training_newwave/weather_app/models/weather_next_day_entity.dart';
import 'package:training_newwave/weather_app/models/weather_today_entity.dart';
import 'package:training_newwave/weather_app/weather_home/weather_home_cubit.dart';
import 'package:training_newwave/weather_app/widget/list_weather_today.dart';
import 'package:training_newwave/weather_app/widget/weather_for_next_days_widget.dart';
import 'package:training_newwave/weather_app/widget/weather_in_city_widget.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({Key? key}) : super(key: key);

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  late final WeatherHomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = WeatherHomeCubit();
    _cubit.initDataWeather(
      city: "HaNoi",
    );
    _cubit.initDataWeatherToday(
      city: 'HaNoi',
    );
    _cubit.initDataWeatherNextDay(
      city: 'HaNoi',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocBuilder<WeatherHomeCubit, WeatherHomeState>(
          buildWhen: (previous, current) =>
              previous.loadingStatus != current.loadingStatus,
          builder: (context, state) {
            return state.loadingStatus == LoadingStatus.loading &&
                    state.loadingStatusWeatherToday == LoadingStatus.init &&
                    state.loadingStatusWeatherNextDay == LoadingStatus.loading
                ? const LoadingWidget()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 62,
                        ),
                        WeatherInCity(
                          weather: state.weather ?? Weather(),
                        ),
                        ListWeatherToday(
                          weatherToday: state.weatherToday ?? WeatherToday(),
                        ),
                        WeatherForNextDay(
                          weatherNextDay:
                              state.weatherNextDay ?? WeatherNextDay(),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
