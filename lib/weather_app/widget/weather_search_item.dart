import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/weather_app/models/weather_entity.dart';

class WeatherSearchItem extends StatelessWidget {
  final Weather weather;

  const WeatherSearchItem({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weather.name ?? '',
                  style: AppTextStyles.blackS16Medium,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${weather.main?.tempMin?.toStringAsFixed(0)}°/${weather.main?.tempMax?.toStringAsFixed(0)}°",
                  style: AppTextStyles.grayS12Medium,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      "${AppConstant.baseImageWeather}${weather.weather?[0].icon}@4x.png",
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  weather.weather?[0].main ?? '',
                  style: AppTextStyles.blackS12Medium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
