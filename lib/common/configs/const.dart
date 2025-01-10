import 'package:flutter/services.dart';

/// [Android MethodChannel]
const platform = MethodChannel('com.ejapp.daily_pedometer');

/// [Storage Key]
const stepsKey = 'steps';
const initialStepsKey = 'initialSteps';
const targetedStepsKey = 'targetedSteps';
const maxStepsKey = 'maxSteps';
const isFirstTime = 'isFirstTime';
const resetTime = 'resetTime';

const themeMode = 'themeMode';

/// [Background Fetch TaskID]
const taskID = 'backgroundFetch';
