abstract class UserProviderType {
  Future<String> getCurrentUserId();

  void saveCurrentUserId(String userId);
}