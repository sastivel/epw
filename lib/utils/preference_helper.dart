import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static Future saveSelectedDrawerIndex(int? selectedIndex) async {
    if (selectedIndex == null) return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("selectedIndex", selectedIndex);
  }

  static Future<int?> getSelectedDrawerIndex() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("selectedIndex");
  }

  static Future clearStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("uid");
  }
}
