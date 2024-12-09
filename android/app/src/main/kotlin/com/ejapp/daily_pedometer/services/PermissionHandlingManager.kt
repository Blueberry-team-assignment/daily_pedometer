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
        for (permission in requiredPermissions) {
            if (ContextCompat.checkSelfPermission(context, permission) != android.content.pm.PackageManager.PERMISSION_GRANTED) {
                return false
            }
        }
        return true
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
            Log.d("---> 퍼미션 체크", "requiredPermissions 체크")
            if (ContextCompat.checkSelfPermission(context, foregroundHealthPermission) != android.content.pm.PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(activity, arrayOf(foregroundHealthPermission), 1001)
                Log.d("---> 퍼미션 체크", "통과")
            }
            Log.d("---> 퍼미션 체크", "통과 못함")
        }

        /// 권한 승인, 서비스 시작
        Log.d("---> 퍼미션 체크", "requestForegroundPermission 체크")
        (activity as MainActivity).startNotificationService()
    }


}