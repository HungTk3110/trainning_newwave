import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/movie_app/widget/loading_widget.dart';
import 'package:training_newwave/weather_app/database/sharedpreferences_manager.dart';
import 'package:training_newwave/weather_app/models/weather_entity.dart';
import 'package:training_newwave/weather_app/models/weather_next_day_entity.dart';
import 'package:training_newwave/weather_app/models/weather_today_entity.dart';
import 'package:training_newwave/weather_app/weather_home/weather_home_cubit.dart';
import 'package:training_newwave/weather_app/widget/weather_for_next_days_widget.dart';
import 'package:training_newwave/weather_app/widget/weather_in_city_more_widget.dart';
import 'package:training_newwave/weather_app/widget/weather_in_city_widget.dart';
import 'package:training_newwave/weather_app/widget/weather_today_widget.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({Key? key}) : super(key: key);

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  late final WeatherHomeCubit _cubit;
  bool isSeeMore = false;

  @override
  void initState() {
    super.initState();
    _cubit = WeatherHomeCubit();
    fetchData();
  }

  void fetchData() async {
    String city = await SharedPreferencesManager.getWeatherData() ?? '';
    if (city == '') {
      SharedPreferencesManager.saveWeatherData("Hà nội");
      String city = await SharedPreferencesManager.getWeatherData() ?? '';
      await _cubit.initDataWeather(
        city: city,
      );
    } else {
      await _cubit.initDataWeather(
        city: city,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BlocProvider(
          create: (context) => _cubit,
          child: BlocBuilder<WeatherHomeCubit, WeatherHomeState>(
            buildWhen: (previous, current) =>
                previous.loadingStatus != current.loadingStatus,
            builder: (context, state) {
              if (state.loadingStatus == LoadingStatus.loading) {
                return const LoadingWidget();
              } else {
                return isSeeMore == false
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 62,
                          ),
                          WeatherInCity(
                            weather: state.weather ?? Weather(),
                          ),
                          WeatherTodayWidget(
                            weatherToday: state.weatherToday ?? WeatherToday(),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isSeeMore = true;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Forcats for 7 Days ",
                                  style: AppTextStyles.blueRibbonS16Medium,
                                ),
                                SvgPicture.asset(
                                  AppVectors.icEvaWeather,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.blueRibbon,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 22,
                          )
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 62,
                            ),
                            WeatherInCityMore(
                              weather: state.weather ?? Weather(),
                            ),
                            WeatherTodayWidget(
                              weatherToday:
                                  state.weatherToday ?? WeatherToday(),
                            ),
                            WeatherForNextDay(
                              weatherNextDay: state.weatherNextDay ??
                                  WeatherNextDay(
                                      code: '', message: 0.0, cnt: 0, list: []),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSeeMore = false;
                                });
                              },
                              child: Text(
                                "Hide Forcats for 7 Days ",
                                style: AppTextStyles.blueRibbonS16Medium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 22,
                            )
                          ],
                        ),
                      );
              }
            },
          ),
        ),
      ),
    );
  }
}
