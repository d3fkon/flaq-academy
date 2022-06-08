import 'package:flaq/services/api.service.dart';
import 'package:flaq/services/auth.service.dart';
import 'package:flaq/services/data.service.dart';
import 'package:flaq/services/messaging.service.dart';
import 'package:flaq/services/root.service.dart';
import 'package:get/instance_manager.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => ApiService());
    await Get.putAsync(() => AuthService().init());
    Get.lazyPut(() => DataService());
    await Get.putAsync(() => RootService().init());
    await Get.putAsync(() => MessagingService().init());
  }
}
