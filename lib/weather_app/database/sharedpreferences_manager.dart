import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static String valueSharedPreferences = 'City';
  // Write DATA
  static Future<void> saveUserData(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(valueSharedPreferences, value);
  }

// Read Data
  static Future<String?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(valueSharedPreferences);
  }
}
