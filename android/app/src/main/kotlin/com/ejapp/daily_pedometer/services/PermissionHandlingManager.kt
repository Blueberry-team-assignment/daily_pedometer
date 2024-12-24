package com.ejapp.daily_pedometer.services
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import androidx.core.content.ContextCompat
import com.ejapp.daily_pedometer.MainActivity
import androidx.core.app.ActivityCompat

class PermissionHandlingManager(
    private val context: Context,
    private val requiredPermissions: List<String>
) {

    /// 권한 상태 확인
    fun checkPermissionStatus(): Boolean {
        return requiredPermissions.all {
            ContextCompat.checkSelfPermission(context, it) == PackageManager.PERMISSION_GRANTED
        }
    }

    /// 일반 권한 요청
    fun requestPermission(activity: Activity) {
        ActivityCompat.requestPermissions(activity, requiredPermissions.toTypedArray(), 1002)
    }



    /// Flutter와 통신하여 권한 상태 알림
    fun notifyPermissionStatusToFlutter(activity: Activity) {
        Log.d("---> 퍼미션 체크", "notifyPermissionStatusToFlutter 체크")
        (activity as MainActivity).sendPermissionStatusToFlutter(checkPermissionStatus())
    }


    /// Foreground Service 권한 확인 및 요청
    fun requestForegroundPermission(activity: Activity) {
        val foregroundHealthPermission = "android.permission.FOREGROUND_SERVICE_HEALTH"
        if (requiredPermissions.contains(foregroundHealthPermission)) {
            if (ContextCompat.checkSelfPermission(context, foregroundHealthPermission) != android.content.pm.PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(activity, arrayOf(foregroundHealthPermission), 1001)
            }
        }
        (activity as MainActivity).startNotificationService()
    }
}