import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/core/response/status.dart';
import 'package:urban_clap_vendor/feature/particular_appointment/data/model/particular_appointment_model.dart';
import 'package:urban_clap_vendor/feature/particular_appointment/data/repository/particular_appointment_repository.dart';
import 'package:urban_clap_vendor/res/preferences/user_preferences.dart';
import 'package:urban_clap_vendor/res/utils/utils.dart';

class ParticularAppointmentController extends GetxController{

  final otpController = TextEditingController().obs;
  RxBool isServiceStarted = false.obs;

  final _api = ParticularAppointmentRepository();
  final userPreferences = UserPreference();
  final rxParticularAppointmentModel = Rxn<ParticularAppointmentModel>();
  final rxRequestStatusParticularAppointment = Status.LOADING.obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingOTP = false.obs;

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

  void setRxParticularAppointmentModel(ParticularAppointmentModel value) => rxParticularAppointmentModel.value = value;
  void setRxRequestStatusParticularAppointment(Status value) => rxRequestStatusParticularAppointment.value = value;


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

  void getParticularAppointment(String appointmentId)async{

    _api.particularAppointmentApi(appointmentId).then((response) {

      if(kDebugMode){
        print('Response : $response');
      }

      try{
        ParticularAppointmentModel particularAppointmentModel = ParticularAppointmentModel.fromJson(response['body-json']['body']);
        setRxParticularAppointmentModel(particularAppointmentModel);
        setRxRequestStatusParticularAppointment(Status.COMPLETED);

        if(rxParticularAppointmentModel.value!.booking.otpVerified){
          isServiceStarted.value = true;
        }


        if(kDebugMode){
          print('Particular Appointment Data Set Successfully');
        }

      }catch(e){
        setRxRequestStatusParticularAppointment(Status.ERROR);
        if(kDebugMode){
          print('Error While Set Particular Appointment Data : $e');
        }
      }

    }).onError((error, stackTrace) {
      setRxRequestStatusParticularAppointment(Status.ERROR);
      if(kDebugMode){
        print('Error While Fetching Particular Appointment Data : $error');
      }
    });

  }

  /// Send Start Service OTP
  void sendStartServiceOTP()async{

    isLoading.value = true;

    String? phone = await userPreferences.getPhone();

    Map<String, dynamic> data = {
      'id': rxParticularAppointmentModel.value!.booking.id,
      'venderPhone': phone,
      'userPhone': rxParticularAppointmentModel.value!.booking.userPhone
    };

    _api.sendStartServiceOtpApi(data).then((response) {

      isLoading.value = false;

      if(kDebugMode){
        print('Response : $response');
      }

      try{

        if(response['body-json']['statusCode'] == 200){
          Utils.toastMessageTop('OTP Sent Successfully');
        } else if(response['body-json']['statusCode'] == 400){
          Utils.toastMessageTop(response['body-json']['message']);
        } else{
          if (kDebugMode) {
            print(response['body-json']['statusCode']);
          }
        }

      }catch(e){
        if(kDebugMode){
          print('Error While Send Start Service OTP Data : $e');
        }
      }

    }).onError((error, stackTrace) {
      isLoading.value = false;
      if(kDebugMode){
        print('Error While Fetching Send Start Service OTP Data : $error');
      }
    });

  }

  /// Resend Start Service OTP
  void resendStartServiceOTP()async{

    Map<String, dynamic> data = {
      'id': rxParticularAppointmentModel.value!.booking.id
    };

    _api.resendStartServiceOtpApi(data).then((response) {

      if(kDebugMode){
        print('Response : $response');
      }

      try{

        if(response['body-json']['statusCode'] == 200){
          Utils.toastMessageTop('OTP Resent Successfully');
        } else if(response['body-json']['statusCode'] == 400){
          Utils.toastMessageTop(response['body-json']['message']);
        } else{
          if (kDebugMode) {
            print(response['body-json']['statusCode']);
          }
        }

      }catch(e){
        if(kDebugMode){
          print('Error While Re-Send Start Service OTP Data : $e');
        }
      }

    }).onError((error, stackTrace) {
      if(kDebugMode){
        print('Error While Fetching Re-Send Start Service OTP Data : $error');
      }
    });

  }

  /// Send Start Service OTP
  void verifyStartServiceOTP()async{

    isLoadingOTP.value = true;

    String? phone = await userPreferences.getPhone();

    Map<String, dynamic> data = {
      'id': rxParticularAppointmentModel.value!.booking.id,
      'venderPhone': phone,
      'otp': otpController.value.text
    };

    _api.verifyStartServiceOtpApi(data).then((response) {

      isLoadingOTP.value = false;

      if(kDebugMode){
        print('Response : $response');
      }

      try{

        if(response['body-json']['statusCode'] == 200){
          Utils.toastMessageTop('OTP Verified Successfully');
          setRxRequestStatusParticularAppointment(Status.LOADING);
          getParticularAppointment(rxParticularAppointmentModel.value!.booking.id);
        } else if(response['body-json']['statusCode'] == 400){
          Utils.toastMessageTop(response['body-json']['message']);
        } else{
          if (kDebugMode) {
            print(response['body-json']['statusCode']);
          }
        }

      }catch(e){
        if(kDebugMode){
          print('Error While Send Start Service OTP Data : $e');
        }
      }

    }).onError((error, stackTrace) {
      isLoadingOTP.value = false;
      if(kDebugMode){
        print('Error While Fetching Send Start Service OTP Data : $error');
      }
    });

  }

}