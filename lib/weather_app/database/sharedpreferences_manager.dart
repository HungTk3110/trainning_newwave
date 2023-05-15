import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static String keyCity = 'City';
  // Write DATA
  static Future<void> saveWeatherData(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(keyCity, value);
  }

// Read Data
  static Future<String?> getWeatherData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(keyCity);
  }
}
