import 'package:package_info/package_info.dart';
import 'package:sqflite_worker/providers/module.dart';

class PackageInfoProvider implements PackageInfoProviderType {
  @override
  Future<String> getAppVersion() async {
    String appVersion;
    await PackageInfo.fromPlatform().then((onValue) {
      appVersion = "${onValue.version} + ${onValue.buildNumber}";
    }).catchError((onError) {
      appVersion = "Uknown version";
    });
    return Future.value(appVersion);
  }
}
