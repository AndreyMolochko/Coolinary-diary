import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_worker/providers/user_provider_type.dart';

class UserProvider implements UserProviderType {
  @override
  Future<String> getCurrentUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String currentUserId = sharedPreferences.getString('current_user_id');
    return currentUserId;
  }

  @override
  void saveCurrentUserId(String userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('current_user_id', userId);
  }

  @override
  void logout() {
    saveCurrentUserId("");
  }
}
