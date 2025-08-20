import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParticularAppointmentController extends GetxController{

  final otpController = TextEditingController().obs;
  RxBool isServiceStarted = true.obs;



  RxList taskList = [
    {
      'title': 'Something Short-circuit',
      'description': 'Lorem Ipsum is simply dummy text of the printing dummy text of the printing',
      'isChecked': false
    },
    {
      'title': 'Something Short-circuit',
      'description': 'Lorem Ipsum is simply dummy text of the printing dummy text of the printing',
      'isChecked': false
    }
  ].obs;


  /// Timer
  RxInt timerSeconds = 30.obs;
  Timer? _timer;

  void startTimer() {
    timerSeconds.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void resetTimer() {
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}