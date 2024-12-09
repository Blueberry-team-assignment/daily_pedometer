package com.ejapp.daily_pedometer.services
import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.util.Log
import com.ejapp.daily_pedometer.providers.StepProvider

class StepSensorManager(
    private val context: Context,
    private val onStepCountUpdated: (Int) -> Unit, // 걸음 데이터 갱신 시 콜백
    private val onNotificationUpdate: (String) -> Unit, // 지속 알림 갱신 시 콜백
): SensorEventListener {

    private var sensorManager: SensorManager? = null
    private var stepSensor: Sensor? = null

    /// 현재 걸음
    private var steps: Int = 0

    /// 기기 초기화 걸음
    private var initialSteps: Int = -1

    private var maxSteps: Int = 10000

    /// 센서 정확도 flag
    private var isCalibrated = false

    companion object {
        const val STEPS_KEY = "flutter.steps"
    }


    /// 초기화
    fun initialize() {
        sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
        stepSensor = sensorManager?.getDefaultSensor(Sensor.TYPE_STEP_COUNTER)

        if (stepSensor != null) {
            sensorManager?. registerListener(this, stepSensor, SensorManager.SENSOR_DELAY_UI)
            onNotificationUpdate("오늘도 힘차게 걸어보세요!")
            Log.d("---> initialize", "센서 매니저가 초기화 되었습니다...")
        } else {
            Log.e("---> initialize", "걸음 센서를 사용할 수 없습니다")
        }

        loadSteps()
    }

    /// 저장된 걸음이 있다면 불러오기
    fun loadSteps() {
        val savedSteps = PreferenceManager.getInt(context, STEPS_KEY, 0)
        if (savedSteps != 0) {
            steps = savedSteps
            initialSteps = 0
        }
    }

    fun midnightReset(context: Context) {
        initialSteps = -1
        steps = 0

        PreferenceManager.setInt(context, STEPS_KEY, 0)
        onStepCountUpdated(steps)
        onNotificationUpdate("걸음을 새로 시작하세요")
        Log.d("---> MidnightReset", "MidnightReset Success")
    }

    fun dispose() {
        sensorManager?.unregisterListener(this)
    }


    override fun onSensorChanged(event: SensorEvent?) {
        if (event?.sensor?.type == Sensor.TYPE_STEP_COUNTER) {

            var eventSteps = event.values[0].toInt()

            if (initialSteps == -1) {
                initialSteps = eventSteps - steps

                if (initialSteps < 0) {
                    initialSteps = 0
                }
                return
            }

            var newSteps = eventSteps - initialSteps

            if (newSteps < 0) {
                newSteps = 0
            }

            steps = if (newSteps > maxSteps) {
                maxSteps
            } else {
                newSteps
            }

            Log.d("---> eventSteps:", "${eventSteps}")
            Log.d("---> initialSteps:", "${initialSteps}")
            Log.d("---> steps:", "${steps}")

            /// Flutter로 데이터 전송
            StepProvider.sendStep(steps)
            onStepCountUpdated(steps)
            onNotificationUpdate("걸음수: $steps 보")
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
        if (sensor?.type == Sensor.TYPE_MAGNETIC_FIELD) {
            if (accuracy == SensorManager.SENSOR_STATUS_ACCURACY_HIGH) {
                isCalibrated = true
                println("---> 센서 정확도가 높습니다.")
            } else {
                isCalibrated = false
                println("---> 센서 정확도가 별롭니다.")
            }
        }
    }
}