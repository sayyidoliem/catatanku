import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
   static Future<void> saveUserUID(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
  }

  static Future<String?> getUserUID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  static Future<void> removeUserUID() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('uid');
  }
}