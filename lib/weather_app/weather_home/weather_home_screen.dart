import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/weather_app/models/weather.dart';
import 'package:training_newwave/weather_app/weather_home/weather_home_cubit.dart';
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
    _cubit.initData(
      city: "HaNoi",
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
            return SafeArea(
              child: Column(
                children: [
                  WeatherInCity(
                    weather: state.weather ??
                        Weather(
                          weather: [],
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
