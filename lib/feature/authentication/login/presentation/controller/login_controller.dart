import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/feature/authentication/login/data/repository/login_repository.dart';
import 'package:urban_clap_vendor/feature/authentication/login/presentation/view/otp_screen.dart';
import 'package:urban_clap_vendor/feature/authentication/set_profile/presentation/view/set_profile_screen.dart';
import 'package:urban_clap_vendor/feature/dashboard/presentation/view/dashboard_screen.dart';
import 'package:urban_clap_vendor/res/preferences/user_preferences.dart';
import 'package:urban_clap_vendor/res/utils/utils.dart';

class LoginController extends GetxController {

  final _api = LoginRepository();
  final usePreferences = UserPreference();

  final phoneController = TextEditingController().obs;
  final otpController = TextEditingController().obs;

  final isLoading = false.obs;


  void login(){

    isLoading.value = true;

    Map<String, dynamic> data = {
      "phone": phoneController.value.text
    };

    _api.loginApi(data).then((response){

      isLoading.value = false;

      try{

        if(kDebugMode){
          print('Response : $response');
        }

        if(response['body-json']['statusCode'] == 200){

          Utils.toastMessageTop(response['body-json']['body']);

          Get.to(() => OtpScreen(phone: phoneController.value.text));

        } else if(response['body-json']['statusCode'] == 401 || response['body-json']['statusCode'] == 400){

          Utils.toastMessageTop(response['body-json']['body']);

        } else {
          if(kDebugMode){
            print(response.toString());
          }
        }

      }catch(e){
        if(kDebugMode){
          print(e.toString());
        }
      }

    }).onError((error, stackTrace) {

      isLoading.value = false;

      if(kDebugMode){
        print(error.toString());
      }

    });
  }

  void otpVerification(String phone){

    isLoading.value = true;

    Map<String, dynamic> data = {
      "phone": phone,
      "otp": otpController.value.text
    };

    _api.otpVerificationApi(data).then((response){

      isLoading.value = false;

      try{

        if(kDebugMode){
          print('Response : $response');
        }

        if(response['body-json']['statusCode'] == 200){

          Utils.toastMessageTop('OTP Verified Successfully');

          usePreferences.setPhone(phone);

          if(response['body-json']['new_user'] == false && response['body-json']['isProfileExist']){
            usePreferences.setToken(response['body-json']['body']['token']);
            Get.offAll(() => DashboardScreen());
          }else{
            Get.to(() => const SetProfileScreen());
          }

        } else if(response['body-json']['statusCode'] == 401 || response['body-json']['statusCode'] == 400){
          Utils.toastMessageTop(response['body-json']['body']);
        } else {
          if(kDebugMode){
            print(response.toString());
          }
        }

      }catch(e){
        if(kDebugMode){
          print(e.toString());
        }
      }

    }).onError((error, stackTrace) {

      isLoading.value = false;

      if(kDebugMode){
        print(error.toString());
      }

    });
  }

}