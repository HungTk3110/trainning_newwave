import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/configs/app_vectors.dart';
import 'package:training_newwave/weather_app/models/weather_entity.dart';

class WeatherInCityMore extends StatelessWidget {
  final Weather weather;

  const WeatherInCityMore({
    required this.weather,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    double temperature = weather.main?.temp ?? 0;

    return Container(
      height: 354,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
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
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  AppVectors.icAddWeather,
                  fit: BoxFit.cover,
                ),
                Text(
                  weather.name ?? "",
                  style: AppTextStyles.whiteS16Bold,
                ),
                SvgPicture.asset(
                  AppVectors.icMenuWeather,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Row(
            children: [
              CachedNetworkImage(
                imageUrl:
                    "${AppConstant.baseImageWeather}${weather.weather?[0].icon}@4x.png",
                width: 160,
                height: 160,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const Spacer(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EEEE').format(
                          now,
                        ),
                        style: AppTextStyles.whiteS16Medium,
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
                        style: AppTextStyles.whiteS16Medium,
                      ),
                    ],
                  ),
                  Text(
                    temperature == temperature.toInt()
                        ? "${temperature.toInt()}°"
                        : "${temperature.toStringAsFixed(0)}°",
                    style: AppTextStyles.whiteS72Bold,
                  ),
                  Text(
                    weather.weather?[0].main ?? "",
                    style: AppTextStyles.whiteS16Medium,
                  ),
                ],
              ),
              const SizedBox(
                width: 26,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            child: SvgPicture.asset(
              AppVectors.icRectangleHrzWeather,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 38,
              right: 38,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    itemWeather(
                        icon: AppVectors.icWindWeather,
                        statisticalValue: "${weather.wind?.speed} km/h",
                        statisticalQuantity: "Wind"),
                    const SizedBox(
                      height: 24,
                    ),
                    itemWeather(
                        icon: AppVectors.icPressureWeather,
                        statisticalValue: "${weather.main?.pressure} mbar",
                        statisticalQuantity: "Pressure"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    itemWeather(
                        icon: AppVectors.icChanceOfRainWeather,
                        statisticalValue: "${weather.wind?.speed} %",
                        statisticalQuantity: "Chance of rain"),
                    const SizedBox(
                      height: 24,
                    ),
                    itemWeather(
                        icon: AppVectors.icHumidityWeather,
                        statisticalValue: "${weather.main?.humidity} %",
                        statisticalQuantity: " humidity"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget itemWeather({
  required String icon,
  required String statisticalValue,
  required String statisticalQuantity,
}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(
          right: 4,
        ),
        child: SvgPicture.asset(
          icon,
          width: 32,
          height: 32,
          fit: BoxFit.cover,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 4,
            ),
            child: Text(
              statisticalValue,
              style: AppTextStyles.whiteS12Medium,
            ),
          ),
          Text(
            " $statisticalQuantity",
            style: AppTextStyles.whiteS12Medium,
          )
        ],
      ),
    ],
  );
}
