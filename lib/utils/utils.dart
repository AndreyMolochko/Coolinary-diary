
class Utils{
  static bool getValidation(String text) {
    if (text.isNotEmpty && text.trim().length > 0) {
      return true;
    } else {
      return false;
    }
  }
}