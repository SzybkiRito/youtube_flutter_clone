import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  const SharedPreference();

  static const _lastSearches = 'lastSearches';

  Future<List<String>> getLastSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSearches = prefs.getStringList(_lastSearches);
    return lastSearches ?? [];
  }

  Future<void> setLastSearches(List<String> lastSearches) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_lastSearches, lastSearches);
  }

  Future<void> clearLastSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastSearches);
  }
}
