import 'package:shared_preferences/shared_preferences.dart';

///MAnages the local storage of te browser or device
class StorageManager {
  ///Stores data in the local storage with the identifier key [key]
  ///and the value [value]
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }

  ///Reads data from the local storage with the identifier key [key]
  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  ///Deletes data from the local storage with the identifier key [key]
  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
