package com.ejapp.daily_pedometer.providers

import io.flutter.plugin.common.EventChannel

object StepProvider {
    var eventSink: EventChannel.EventSink? = null

    fun sendStep(steps: Int) {
        eventSink?.success(steps)
//        eventSink?.success(
//            mapOf(
//                "steps" to steps,
//                "isSuccess" to true,
//            )
//        )
    }

    fun sendError(errorMessage: String) {
        eventSink?.error("Error", errorMessage, null)
    }

    fun sendEndOfStream() {
        eventSink?.endOfStream()
    }
}