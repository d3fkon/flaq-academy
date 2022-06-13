package club.flaq

import android.app.IntentService
import android.content.Intent
import android.util.Log
import android.widget.Toast

public class FlaqService(name: String = "FlaqIntentService") : IntentService(name) {

    override fun onHandleIntent(intent: Intent?) {
        if(intent != null) {
            var token: String? = intent.getStringExtra("token");
            var amount: String? = intent.getStringExtra("amount");
            Log.i("FLAQ INTENT SERVICE", "$amount $token");
            Toast.makeText(this.applicationContext, "Handling Intent", Toast.LENGTH_LONG);
        }
    }
}