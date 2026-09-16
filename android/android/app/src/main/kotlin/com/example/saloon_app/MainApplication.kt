package com.example.saloon_app

import androidx.multidex.MultiDexApplication
import io.flutter.app.FlutterApplication
import androidx.multidex.MultiDex
import android.content.Context

class MainApplication : FlutterApplication() {
    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }

    override fun onCreate() {
        super.onCreate()
    }
} 