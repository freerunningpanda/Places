package com.unact.yandexmapkitexample

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setLocale("YOUR_LOCALE")
        MapKitFactory.setApiKey("45f6d5c0-c936-48a3-95a2-0c69b71c6ce8")
        super.configureFlutterEngine(flutterEngine)
    }
}






