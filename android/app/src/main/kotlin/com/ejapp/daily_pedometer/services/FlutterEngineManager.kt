package com.ejapp.daily_pedometer.services

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

object FlutterEngineManager {
    var flutterEngine: FlutterEngine?= null

    fun initialize(flutterEngine: FlutterEngine) {
        this.flutterEngine = flutterEngine
    }

    fun setupEventChannel(channelId: String, eventSinkProvider: (EventChannel.EventSink?) -> Unit) {
        flutterEngine?.let { engine ->
            EventChannel(engine.dartExecutor.binaryMessenger, channelId)
                .setStreamHandler(object: EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        eventSinkProvider(events)
                    }

                    override fun onCancel(arguments: Any?) {
                        eventSinkProvider(null)
                    }
                })
        }
    }

    fun setupMethodChannel(channelId: String, key: String, value: Boolean) {
        flutterEngine?.let { engine ->
            MethodChannel(engine.dartExecutor.binaryMessenger, channelId)
                .invokeMethod(key, value)
        }
    }
}