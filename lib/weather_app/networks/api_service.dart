import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:training_newwave/weather_app/models/weather_entity.dart';
import 'package:training_newwave/weather_app/models/weather_next_day_entity.dart';
import 'package:training_newwave/weather_app/models/weather_today_entity.dart';

class ApiService {
  static const String baseUrl1 =
      "https://api.openweathermap.org/data/2.5/weather";
  static const String baseUrl2 =
      'https://pro.openweathermap.org/data/2.5/forecast/hourly';
  static const String baseUrl3 =
      "https://pro.openweathermap.org/data/2.5/forecast/climate";
  static const String apiKey = '905972eaff41a8bc1e2251372b003af4';
  static const String apiKeyPro = "b1b15e88fa797225412429c1c50c122a1";

  static Future<Weather> fetchWeather({
    required String city,
  }) async {
    String url = "$baseUrl1?q=$city&units=metric&appid=$apiKey";

    final apiResponse = await http.get(Uri.parse(url));

    if (apiResponse.statusCode == 200) {
      return Weather.fromJson(jsonDecode(apiResponse.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  static Future<WeatherToday> fetchWeatherToday({
    required String city,
  }) async {
    String url = "$baseUrl2?q=$city&cnt=16&units=metric&appid=$apiKeyPro";

    final apiResponse = await http.get(Uri.parse(url));

    if (apiResponse.statusCode == 200) {
      return WeatherToday.fromJson(jsonDecode(apiResponse.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  static Future<WeatherNextDay> fetchWeatherNextDay({
    required String city,
  }) async {
    String url = "$baseUrl3?q=$city&cnt=7&units=metric&appid=$apiKeyPro";

    final apiResponse = await http.get(Uri.parse(url));

    if (apiResponse.statusCode == 200) {
      return WeatherNextDay.fromJson(jsonDecode(apiResponse.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
