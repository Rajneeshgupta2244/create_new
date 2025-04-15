import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  /// Store data in SharedPreferences with support for multiple data types.
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

      log("✅ Stored Data: Key = $key, Value = $value");

    } catch (e) {
      log("❌ Error storing data for key: $key - $e");
    }
  }

  /// Retrieve data from SharedPreferences with an optional type hint.
  static Future<dynamic> getData(String key, {Type? type}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey(key)) {
        log("⚠️ Key: $key does not exist.");
        return null;
      }

      dynamic data;
      if (type == String) {
        data = prefs.getString(key);
      } else if (type == int) {
        data = prefs.getInt(key);
      } else if (type == bool) {
        data = prefs.getBool(key);
      } else if (type == double) {
        data = prefs.getDouble(key);
      } else if (type == List<String>) {
        data = prefs.getStringList(key);
      } else {
        String? jsonString = prefs.getString(key);
        data = jsonString != null ? jsonDecode(jsonString) : null;
      }

      log("📥 Retrieved Data: Key = $key, Value = $data");
      return data;

    } catch (e) {
      log("❌ Error retrieving data for key: $key - $e");
      return null;
    }
  }

  /// Remove a specific key from SharedPreferences.
  static Future<void> removeData(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
      log("🗑️ Key removed: $key");
    } catch (e) {
      log("❌ Error removing key: $key - $e");
    }
  }

  /// Check if a key exists in SharedPreferences.
  static Future<bool> containsKey(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool exists = prefs.containsKey(key);
    log("🔍 Key exists check: $key -> $exists");
    return exists;
  }

  /// Clear all stored data in SharedPreferences.
  static Future<void> clearAllData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      log("🧹 All data cleared successfully.");
    } catch (e) {
      log("❌ Error clearing all data - $e");
    }
  }
}


///How To Store Data By Using Above Functions
/*
await SharedPreferencesHelper.storeData("username", "JohnDoe");
await SharedPreferencesHelper.storeData("isLoggedIn", true);
await SharedPreferencesHelper.storeData("userAge", 25);
await SharedPreferencesHelper.storeData("height", 5.9);
await SharedPreferencesHelper.storeData("hobbies", ["Reading", "Gaming"]);
await SharedPreferencesHelper.storeData("userProfile", {"id": 1, "name": "John"});
*/

///How To Retrieve Data By Using Above Functions
/*
String? username = await SharedPreferencesHelper.getData("username", type: String);
bool? isLoggedIn = await SharedPreferencesHelper.getData("isLoggedIn", type: bool);
int? userAge = await SharedPreferencesHelper.getData("userAge", type: int);
double? height = await SharedPreferencesHelper.getData("height", type: double);
List<String>? hobbies = await SharedPreferencesHelper.getData("hobbies", type: List<String>);
Map<String, dynamic>? userProfile = await SharedPreferencesHelper.getData("userProfile");
 */


///How To Remove Data By Using Above Functions
// await SharedPreferencesHelper.removeData("username");


///How To Remove All Data By Using Above Functions At A Time
// await SharedPreferencesHelper.clearAllData();

///How To Check Key is Present or Not By Using Above Functions At A Time
// bool exists = await SharedPreferencesHelper.containsKey("username");




