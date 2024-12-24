import 'package:flutter/services.dart';

/// [Android MethodChannel]
const platform = MethodChannel('com.ejapp.daily_pedometer');

/// [Storage Key]
const stepsKey = 'steps';
const initialStepsKey = 'initialSteps';
const targetedStepsKey = 'targetedSteps';
const maxStepsKey = 'maxSteps';

/// [Background Fetch TaskID]
const taskID = 'backgroundFetch';
