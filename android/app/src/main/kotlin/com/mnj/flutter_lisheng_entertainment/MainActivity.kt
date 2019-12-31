package com.mnj.flutter_lisheng_entertainment

import android.os.Build
import android.os.Bundle
import android.view.ViewTreeObserver
import android.view.WindowManager
import androidx.annotation.NonNull;
import com.tekartik.sqflite.SqflitePlugin
import flutter.plugins.screen.screen.ScreenPlugin
//import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.app.FlutterActivity
import io.flutter.app.FlutterPluginRegistry
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.packageinfo.PackageInfoPlugin
import io.flutter.plugins.pathprovider.PathProviderPlugin
import io.flutter.plugins.share.SharePlugin
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin
import io.flutter.plugins.videoplayer.VideoPlayerPlugin
import io.github.ponnamkarthik.toast.fluttertoast.FluttertoastPlugin

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val flutter_native_splash = false
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            window.statusBarColor = 0x00000000
        }

        //GeneratedPluginRegistrant.registerWith(FlutterEngine(this))

        SharedPreferencesPlugin.registerWith(this.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"))
        FluttertoastPlugin.registerWith(this.registrarFor("io.github.ponnamkarthik.toast.fluttertoast.FluttertoastPlugin"))
        PackageInfoPlugin.registerWith(this.registrarFor("io.flutter.plugins.packageinfo.PackageInfoPlugin"))
        PathProviderPlugin.registerWith(this.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"))
        ScreenPlugin.registerWith(registrarFor("flutter.plugins.screen.screen.ScreenPlugin"))
        SharePlugin.registerWith(registrarFor("io.flutter.plugins.share.SharePlugin"))
        VideoPlayerPlugin.registerWith(registrarFor("io.flutter.plugins.videoplayer.VideoPlayerPlugin"))
        SqflitePlugin.registerWith(registrarFor("com.tekartik.sqflite.SqflitePlugin"))

        val vto = flutterView.viewTreeObserver
        vto.addOnGlobalLayoutListener(object : ViewTreeObserver.OnGlobalLayoutListener {
            override fun onGlobalLayout() {
                flutterView.viewTreeObserver.removeOnGlobalLayoutListener(this)
                window.clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
            }
        })
    }
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine);
//    }
}
