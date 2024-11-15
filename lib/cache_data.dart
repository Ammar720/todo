import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  static late SharedPreferences sharedPreferences;

  static initializeCache() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setlanguage({required String value}) {
    sharedPreferences.setString('language', value);
  }

  static String getlanguage() {
    return sharedPreferences.getString('language') ?? 'en';
  }
}
