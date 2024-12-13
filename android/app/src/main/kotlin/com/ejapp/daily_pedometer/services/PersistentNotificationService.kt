package com.ejapp.daily_pedometer.services

import android.annotation.SuppressLint
import android.app.AlarmManager
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import com.ejapp.daily_pedometer.providers.StepProvider
import com.ejapp.daily_pedometer.receivers.AlarmReceiver
import java.util.Calendar

class PersistentNotificationService : Service() {

    private lateinit var stepSensorManager: StepSensorManager

    companion object {
        const val NOTIFICATION_CHANNEL = "STEPS_NOTIFICATION"
        const val NOTIFICATION_ID = 100
        const val RESET_KEY = "midnight_reset"
    }

    @RequiresApi(Build.VERSION_CODES.M)
    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
        startForeground(NOTIFICATION_ID, makeNotification("걸음을 추적 중입니다..."))
        scheduleMidnightReset()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val isResetMidnight = intent?.getBooleanExtra(RESET_KEY, false) ?: false
        if (isResetMidnight) {
            reset()
        }
        val savedSteps = PreferenceManager.getInt(this, StepSensorManager.STEPS_KEY)
        val steps = intent?.getIntExtra("steps", savedSteps) ?: 0
        updateNotification("걸음수: $steps 보")

        val action = intent?.getStringExtra("action")
        when (action) {
            "START" -> startStepSensorManager()
        }
        return START_STICKY
    }

    private fun startStepSensorManager() {
        stepSensorManager = StepSensorManager(
            context = this,
            onNotificationUpdate = {
                    content ->
                updateNotification(content)
            },
            onStepCountUpdated = {
                    steps ->
                PreferenceManager.setInt(this, StepSensorManager.STEPS_KEY, steps)
            },
        )
        stepSensorManager.initialize()
    }


    private fun makeNotification(content: String): Notification {
        return NotificationCompat.Builder(this, NOTIFICATION_CHANNEL)
            .setContentText(content)
            .setSmallIcon(com.ejapp.daily_pedometer.R.drawable.launch_background)
            .setOngoing(true)
            .build()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                NOTIFICATION_CHANNEL,
                "1",
                NotificationManager.IMPORTANCE_DEFAULT
            ).apply {
                setShowBadge(false)
            }
            val notificationManager: NotificationManager? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                getSystemService(NotificationManager::class.java)
            } else {
                getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            }
            notificationManager?.createNotificationChannel(channel)
        }
    }

    private fun updateNotification(content: String) {
        val notificationManager: NotificationManager? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getSystemService(NotificationManager::class.java)
        } else {
            getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        }
        val notification = makeNotification(content)
        notificationManager?.notify(NOTIFICATION_ID, notification)
    }

    @SuppressLint("ScheduleExactAlarm")
    @RequiresApi(Build.VERSION_CODES.M)
    private fun scheduleMidnightReset() {
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(this, AlarmReceiver::class.java)
        val pendingIntent = PendingIntent.getBroadcast(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT)
        val calendar = Calendar.getInstance()
        calendar.set(Calendar.HOUR_OF_DAY, 0) // 자정
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)

        if (System.currentTimeMillis() > calendar.timeInMillis) {
            calendar.add(Calendar.DAY_OF_MONTH, 1)
        }

//        alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, pendingIntent)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S && !AlarmReceiver().hasExactAlarmPermission(this)) {
            AlarmReceiver().requestExactAlarmPermission(this)
        } else {
            alarmManager.setExactAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP,
                calendar.timeInMillis,
                pendingIntent
            )
        }
    }

    private fun reset() {
        stepSensorManager.midnightReset(this)
    }

    override fun onBind(intent: Intent?): IBinder? {
        TODO("Not yet implemented")
    }


    override fun onDestroy() {
        super.onDestroy()
        stepSensorManager.dispose()
    }
}