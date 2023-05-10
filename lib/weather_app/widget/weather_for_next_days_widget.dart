import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training_newwave/configs/app_colors.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/weather_app/models/weather_next_day_entity.dart';

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
              itemCount: weatherNextDay.list?.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 48,
                  child: Row(
                    children: [
                      Text(
                        DateFormat('EEEE').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              weatherNextDay.list?[index].dt ?? 0),
                        ),
                        style: AppTextStyles.whiteS16Medium,
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
