import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/weather_app/database/sharedpreferences_manager.dart';
import 'package:training_newwave/weather_app/models/weather_entity.dart';
import 'package:training_newwave/weather_app/weather_home/weather_home_screen.dart';
import 'package:training_newwave/weather_app/weather_search/weather_search_cubit.dart';
import 'package:training_newwave/weather_app/widget/weather_search_item.dart';

class WeatherSearchScreen extends StatefulWidget {
  const WeatherSearchScreen({Key? key}) : super(key: key);

  @override
  State<WeatherSearchScreen> createState() => _WeatherSearchScreenState();
}

class _WeatherSearchScreenState extends State<WeatherSearchScreen> {
  late TextEditingController _searchController;
  late WeatherSearchCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = WeatherSearchCubit();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.only(
          top: 62,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              AppColors.malibu,
              AppColors.mariner,
            ],
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            appBarSearchWidget(context: context),
            searchWidget(),
            BlocProvider(
              create: (context) => _cubit,
              child: BlocBuilder<WeatherSearchCubit, WeatherSearchState>(
                  buildWhen: (previous, current) =>
                      previous.loadingStatus != current.loadingStatus,
                  builder: (context, state) {
                    return state.loadingStatus == LoadingStatus.success
                        ? InkWell(
                            onTap: () async {
                              SharedPreferencesManager.saveWeatherData(
                                  _searchController.text);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const WeatherHomeScreen(),
                                ),
                              );
                            },
                            child: WeatherSearchItem(
                              weather: state.weather ?? Weather(),
                            ),
                          )
                        : const SizedBox();
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget appBarSearchWidget({
    required BuildContext context,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            AppVectors.icBackWeather,
            fit: BoxFit.cover,
            width: 32,
            height: 32,
          ),
        ),
        const Spacer(),
        Text(
          "Manage location",
          style: AppTextStyles.whiteS16Bold,
        ),
        const Spacer(),
      ],
    );
  }

  Widget searchWidget() {
    return Container(
      margin: const EdgeInsets.only(
        top: 36,
        bottom: 32,
      ),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 8,
        top: 8,
      ),
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.white,
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        style: AppTextStyles.blackS12Medium,
        textInputAction: TextInputAction.done,
        onSubmitted: (value) {
          _cubit.searchByCity(city: value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: "Search Your City",
          hintStyle: AppTextStyles.grayS12Medium,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              right: 8,
            ),
            child: SvgPicture.asset(
              AppVectors.icSearchWeather,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 16,
            minHeight: 16,
          ),
        ),
      ),
    );
  }
}
