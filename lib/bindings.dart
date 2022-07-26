import 'package:flaq/services/api.service.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/services/root.service.dart';
import 'package:get/instance_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => DataService());
    await Get.putAsync(() => AuthService().init());
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool permissionAsked = prefs.getBool('permissionAsked') ?? false;
    Get.putAsync(() => RootService().init());
  }
}
