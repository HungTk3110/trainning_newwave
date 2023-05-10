import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:training_newwave/weather_app/models/weather.dart';
import 'package:training_newwave/weather_app/models/weather_today.dart';

class ApiService {
  static const String baseUrl1 =
      "https://api.openweathermap.org/data/2.5/weather";
  static const String baseUrl2 =
      'http://api.openweathermap.org/data/2.5/forecast';
  static const String apiKey = '905972eaff41a8bc1e2251372b003af4';

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
    String url = "$baseUrl2?q=$city&appid=$apiKey";

    final apiResponse = await http.get(Uri.parse(url));

    if (apiResponse.statusCode == 200) {
      return WeatherToday.fromJson(jsonDecode(apiResponse.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
