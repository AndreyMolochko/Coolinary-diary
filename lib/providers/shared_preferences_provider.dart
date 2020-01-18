import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_worker/providers/shared_preferences_provider_type.dart';

class SharedPreferencesProvider implements SharedPreferencesProviderType {
  @override
  Future<bool> getShowingGuidePage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final isShowingGuide = sharedPreferences.getBool('isShowingGuidePage');
    if (isShowingGuide == null) {
      return false;
    } else {
      return isShowingGuide;
    }
  }

  @override
  void saveShowingGuidePage(bool isShowing) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isShowingGuidePage', isShowing);
  }
}
