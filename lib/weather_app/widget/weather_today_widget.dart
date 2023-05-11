import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/weather_app/models/weather_today_entity.dart';

class WeatherTodayWidget extends StatelessWidget {
  final WeatherToday weatherToday;
  const WeatherTodayWidget({
    required this.weatherToday,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Container(
      height: 140,
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 16,
      ),
      padding: const EdgeInsets.only(
        top: 8,
        left: 16,
        right: 16,
      ),
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                DateFormat('EEEE').format(
                  now,
                ),
                style: AppTextStyles.whiteS16Bold,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: SvgPicture.asset(
                  AppVectors.icRectangleWeather,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                DateFormat.MMMd('en_US').format(
                  now,
                ),
                style: AppTextStyles.whiteS16Bold,
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            width: double.infinity,
            height: 104,
            child: listWeatherInToDay(
              weatherToday: weatherToday,
            ),
          ),
        ],
      ),
    );
  }
}

Widget listWeatherInToDay({required WeatherToday weatherToday}) {
  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: weatherToday.list?.length,
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) {
      return SizedBox(
        width: 98,
        height: 104,
        child: Column(
          children: [
            Text(
              weatherToday.list == null
                  ? ''
                  : DateFormat.Hm().format(weatherToday.list![index].dtTxt),
              style: AppTextStyles.whiteS16Medium,
            ),
            const SizedBox(
              height: 6,
            ),
            CachedNetworkImage(
              imageUrl:
                  "${AppConstant.baseImageWeather}${weatherToday.list?[0].weather[0].icon}@4x.png",
              width: 24,
              height: 24,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Text(
              "${weatherToday.list?[index].main.tempMin.toStringAsFixed(0)}°/${weatherToday.list?[index].main.tempMax.toStringAsFixed(0)}°",
              style: AppTextStyles.whiteS14Medium,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "${weatherToday.list?[index].main.humidity}% humidity",
              style: AppTextStyles.whiteS14Medium,
            ),
          ],
        ),
      );
    },
  );
}
