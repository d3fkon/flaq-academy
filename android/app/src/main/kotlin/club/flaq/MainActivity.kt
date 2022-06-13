package club.flaq


import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "club.flaq/notify";

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
                var intentService = Intent(this, FlaqService("FlaqService")::class.java)
                intentService.putExtra("amount", "100")
                intentService.putExtra("token", "XABCD")
                startService(intentService)
                result.success(1)
        }
    }
}
