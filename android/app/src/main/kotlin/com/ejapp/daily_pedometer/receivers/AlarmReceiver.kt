package com.ejapp.daily_pedometer.receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.ejapp.daily_pedometer.services.StepSensorManager

class AlarmReceiver: BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {

        val intent = Intent(context, StepSensorManager::class.java)
        intent.putExtra("midnightReset", true)
        context?.startService(intent)
    }

}