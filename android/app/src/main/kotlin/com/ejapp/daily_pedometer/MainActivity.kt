package com.ejapp.daily_pedometer

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.annotation.RequiresApi
import com.ejapp.daily_pedometer.providers.StepProvider
import com.ejapp.daily_pedometer.receivers.AlarmReceiver
import com.ejapp.daily_pedometer.services.FlutterEngineManager
import com.ejapp.daily_pedometer.services.PermissionHandlingManager
import com.ejapp.daily_pedometer.services.PersistentNotificationService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    private lateinit var permissionHandlingManager: PermissionHandlingManager
    private val permissions = listOf(
        "android.permission.FOREGROUND_SERVICE_HEALTH",
        "android.permission.ACTIVITY_RECOGNITION",
        "android.permission.BODY_SENSORS",
        "android.permission.SCHEDULE_EXACT_ALARM",
        "android.permission.ACCESS_FINE_LOCATION",
        "android.permission.ACCESS_COARSE_LOCATION"
    )
    companion object {
        private const val  CHANNEL_BRIDGE = "com.ejapp.daily_pedometer"
    }


    @RequiresApi(Build.VERSION_CODES.M)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

//        permissionHandlingManager = PermissionHandlingManager(this, permissions)
//
//        if (!permissionHandlingManager.checkPermissionStatus()) {
//            permissionHandlingManager.requestForegroundPermission(this)
//        }
        requestPermissionsIfNeeded()
//        permissionHandlingManager.requestForegroundPermission(this)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when (requestCode) {
            1001, 1002 -> { // Foreground Service 또는 일반 권한 요청 결과
                if (grantResults.all { it == android.content.pm.PackageManager.PERMISSION_GRANTED }) {
//                    permissionHandlingManager.notifyPermissionStatusToFlutter(this)
                    startNotificationService()
                }
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        FlutterEngineManager.initialize(flutterEngine)
        // FlutterEngineManager.setupEventChannel(CHANNEL_BRIDGE) { eventSink ->
        //     StepProvider.eventSink = eventSink
        // }

        FlutterEngineManager.setupMethodChannel(CHANNEL_BRIDGE) { call, result ->
            if (call != null) {
                when (call.method) {
                    "startService" -> {
                        startNotificationService()
                        result.success(null)
                    }
                    "updateService" -> {
                        val steps = call.argument<Int>("steps") ?: 0
                        updateNotificationService(steps)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }

     fun startNotificationService() {
        val intent = Intent(this, PersistentNotificationService::class.java).apply {
            putExtra("action", "START")
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(intent)
        } else {
            startService(intent)
        }
    }

     private fun updateNotificationService(steps: Int) {
        val intent = Intent(this, PersistentNotificationService::class.java).apply {
            putExtra("steps", steps)
        }
//        startService(intent)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(intent) // Foreground Service 시작
        } else {
            startService(intent) // 일반 Service 시작
        }
    }

    fun sendPermissionStatusToFlutter(flag: Boolean) {
        FlutterEngineManager.setupInvokeMethod(CHANNEL_BRIDGE, "hasPermission", flag)
    }

    @RequiresApi(Build.VERSION_CODES.M)
    private fun requestPermissionsIfNeeded() {
        val missingPermissions = permissions.filter {
            checkSelfPermission(it) != android.content.pm.PackageManager.PERMISSION_GRANTED
        }
        if (missingPermissions.isNotEmpty()) {
            requestPermissions(missingPermissions.toTypedArray(), 1001)
        } else {
            startNotificationService()
        }
    }
}

