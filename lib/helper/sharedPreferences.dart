import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final String _backgroundColor = 'backgroundColor';

  Future<String> getBackgroundColor() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_backgroundColor) ?? '0xff305A3F';
  }

  Future<bool> setBackgroundColor(List<String> value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setStringList(_backgroundColor, value);
  }
}
