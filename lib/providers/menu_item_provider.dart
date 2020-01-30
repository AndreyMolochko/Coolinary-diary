import 'package:sqflite_worker/providers/menu_item_provider_type.dart';

class MenuItemProvider implements MenuItemProviderType {
  @override
  List<String> getLanguages() {
    return ["English", "Russian", "Belarussian"];
  }
}
