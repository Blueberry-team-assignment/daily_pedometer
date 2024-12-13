package com.ejapp.daily_pedometer.services

import android.content.Context
import android.content.SharedPreferences

object PreferenceManager {

    private const val PREF_NAME = "FlutterSharedPreferences"

    private fun getPreferences(context: Context): SharedPreferences {
        return context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
    }

    fun setInt(context: Context, key: String, value: Int) {
        val prefs = getPreferences(context)

        prefs.edit()
            .putInt(key, value)
            .apply()
    }

    fun setString(context: Context, key: String, value: String) {
        val prefs = getPreferences(context)

        prefs.edit()
            .putString(key, value)
            .apply()
    }

    fun getInt(context: Context, key: String): Int {
        val prefs = getPreferences(context)
//        return prefs.getInt(key, defaultValue ?: 0)
        return try {
            if (prefs.contains(key)) {
                prefs.getInt(key, 0)
            } else {
                prefs.getLong(key, 0L).toInt()
            }
        } catch (e: ClassCastException) {
            prefs.getLong(key, 0L).toInt()
        }
    }


    fun getString(context: Context, key: String, defaultValue: String?) : String {
        val prefs = getPreferences(context)
        return prefs.getString(key, defaultValue) ?: ""
    }
}