import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> storeData(String key, dynamic value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value is String) {
        await prefs.setString(key, value);
      } else if (value is int) {
        await prefs.setInt(key, value);
      } else if (value is bool) {
        await prefs.setBool(key, value);
      } else if (value is double) {
        await prefs.setDouble(key, value);
      } else if (value is List<String>) {
        await prefs.setStringList(key, value);
      } else {
        String jsonString = jsonEncode(value);
        await prefs.setString(key, jsonString);
      }
      print("===$key=======Data stored successfully============");
    } catch (e) {
      print("Error storing data for key: $key - $e");
    }
  }

  static Future<dynamic> getData(String key, {Type? type}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey(key)) {
        print("Key: $key does not exist.");
        return null;
      }

      if (type == String) {
        return prefs.getString(key);
      } else if (type == int) {
        return prefs.getInt(key);
      } else if (type == bool) {
        return prefs.getBool(key);
      } else if (type == double) {
        return prefs.getDouble(key);
      } else if (type == List<String>) {
        return prefs.getStringList(key);
      } else {
        String? jsonString = prefs.getString(key);
        if (jsonString != null) {
          return jsonDecode(jsonString);
        }
      }
    } catch (e) {
      print("Error retrieving data for key: $key - $e");
    }
    return null;
  }

  static Future<void> removeData(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
      print("Key: $key removed successfully.");
    } catch (e) {
      print("Error removing key: $key - $e");
    }
  }

  static Future<bool> containsKey(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<void> clearAllData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      print("All data cleared successfully.");
    } catch (e) {
      print("Error clearing all data - $e");
    }
  }
}
