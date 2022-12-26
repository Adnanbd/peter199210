import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  // Obtain shared preferences.
  saveCurrentDate(String day) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("day", day);
  }

  Future<String?> getPrevDate() async {
    final prefs = await SharedPreferences.getInstance();
    String? day = prefs.getString("day");
    return day;
  }

  saveCurrentIndex(int x) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("index", x);
  }

  Future<int?> getPrevIndex() async {
    final prefs = await SharedPreferences.getInstance();
    int? index = prefs.getInt("index");
    return index;
  }

}
