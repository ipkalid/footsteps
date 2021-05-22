import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';

class StepCounterProvider with ChangeNotifier {
  String _status = '?';
  String get status => _status;
  set status(String value) {
    _status = value;
    notifyListeners();
  }

  int _steps = -2;
  int get steps => _steps;
  set steps(int value) {
    _steps = value;
    notifyListeners();
  }

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount event) {
    // print(event);

    //  _isWalking = true;
    _steps = event.steps;
    notifyListeners();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    _status = event.status;
    //_isWalking = false;
    notifyListeners();
  }

  void onPedestrianStatusError(error) {
    _status = 'Pedestrian Status not available';
    notifyListeners();
    //print(_status);
  }

  void onStepCountError(error) {
    // print('onStepCountError: $error');
    _steps = -1;
    notifyListeners();
  }
}
