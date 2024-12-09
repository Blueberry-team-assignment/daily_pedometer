package com.ejapp.daily_pedometer.services

import android.content.Context
import android.content.SharedPreferences

object PreferenceManager {

    private const val PREF_NAME = "app_preferences"

    fun getPreferences(context: Context): SharedPreferences {
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

    fun getInt(context: Context, key: String, defaultValue: Int?): Int {
        val prefs = getPreferences(context)
        return prefs.getInt(key, defaultValue ?: 0)
    }

    fun getString(context: Context, key: String, defaultValue: String?) : String {
        val prefs = getPreferences(context)
        return prefs.getString(key, defaultValue) ?: ""
    }
}