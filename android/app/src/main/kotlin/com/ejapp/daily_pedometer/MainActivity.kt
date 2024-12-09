package com.ejapp.daily_pedometer

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import com.ejapp.daily_pedometer.providers.StepProvider
import com.ejapp.daily_pedometer.services.FlutterEngineManager
import com.ejapp.daily_pedometer.services.PermissionHandlingManager
import com.ejapp.daily_pedometer.services.PersistentNotificationService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    private lateinit var permissionHandlingManager: PermissionHandlingManager

    companion object {
        private const val  CHANNEL_BRIDGE = "com.ejapp.daily_pedometer"
    }


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val permissions = listOf(
            android.Manifest.permission.ACCESS_FINE_LOCATION,
            android.Manifest.permission.ACTIVITY_RECOGNITION,
            "android.permission.FOREGROUND_SERVICE_HEALTH"
        )
        permissionHandlingManager = PermissionHandlingManager(this, permissions)
        permissionHandlingManager.requestForegroundPermission(this)

    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        FlutterEngineManager.initialize(flutterEngine)
        FlutterEngineManager.setupEventChannel(CHANNEL_BRIDGE) { eventSink ->
            StepProvider.eventSink = eventSink
        }
    }

    fun sendPermissionStatusToFlutter(hasPermission: Boolean) {
        FlutterEngineManager.setupMethodChannel(CHANNEL_BRIDGE, "hasPermission", hasPermission)
    }

    fun startNotificationService() {
        Log.d("---> start Noti", "startNotificationService")
        val intent = Intent(this, PersistentNotificationService::class.java)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(intent)
        } else {
            startService(intent)
        }
    }
}
