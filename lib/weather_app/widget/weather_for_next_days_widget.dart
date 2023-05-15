import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/weather_app/models/weather_next_day_entity.dart';

import '../../configs/app_constant.dart';

class WeatherForNextDay extends StatelessWidget {
  final WeatherNextDay weatherNextDay;

  const WeatherForNextDay({
    required this.weatherNextDay,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 390,
      margin: const EdgeInsets.only(
        top: 16,
      ),
      padding: const EdgeInsets.all(16),
      color: AppColors.mariner,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Forcats for 7 Days",
            style: AppTextStyles.whiteS16Bold,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              itemCount: weatherNextDay.list.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 48,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat('EEEE').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                weatherNextDay.list[index].dt * 1000),
                          ),
                          style: AppTextStyles.whiteS16Medium,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "${AppConstant.baseImageWeather}${weatherNextDay.list[index].weather[0].icon}@4x.png",
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Text(
                              "${weatherNextDay.list[index].humidity}%humidity",
                              style: AppTextStyles.whiteS12Medium,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${weatherNextDay.list[index].temp.min.toStringAsFixed(0)}°/${weatherNextDay.list[index].temp.max.toStringAsFixed(0)}°",
                          style: AppTextStyles.whiteS14Medium,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
