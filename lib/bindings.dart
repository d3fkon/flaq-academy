import 'package:flaq/services/api.service.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/services/scaffold.service.dart';
import 'package:flaq/services/tracking.service.dart';
import 'package:get/instance_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() async {
    Get.put(ScaffoldService());
    await Get.putAsync(() => TrackingService().init());
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => DataService());
    await Get.putAsync(() => AuthService().init());
  }
}
