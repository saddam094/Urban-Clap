import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:urban_clap/feature/authentication/login/presentation/controller/login_controller.dart';
import 'package:urban_clap/res/color/app_color.dart';
import 'package:urban_clap/res/common/common_button.dart';
import 'package:urban_clap/res/common/custom_app_bar.dart';
import 'package:urban_clap/res/constant/constant_data.dart';
import 'package:urban_clap/res/utils/utils.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final loginVM = Get.put(LoginController());

  bool isOnlyDigits(String str) {
    return RegExp(r'^[0-9]+$').hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        height: Constant.height * 1,
        width: Constant.width * 1,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Heading Container
              CustomAppBar(title: '', isBack: true, onBack: () => Navigator.pop(context)),

              Container(
                height: Constant.height * .87,
                width: Constant.width * 1,
                padding: EdgeInsets.only(
                    left: Constant.width * .03,
                    right: Constant.width * .03
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: Constant.height * .01),

                    Text('OTP Verification code', style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black)),

                    SizedBox(height: Constant.height * .01),

                    Text('Enter the code we sent to the number\n${widget.phone}', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextDarkColor)),

                    SizedBox(height: Constant.height * .04),

                    /// Pin put
                    Center(
                      child: Pinput(
                        controller: loginVM.otpController.value,
                        keyboardType: TextInputType.phone,
                        defaultPinTheme: PinTheme(
                          width: Constant.width * .18,
                          height: Constant.height * .06,
                          textStyle: TextStyle(fontSize: Constant.width * .04, color: Colors.black),
                          decoration: BoxDecoration(
                            color: Colors.transparent, // No background
                            border: Border.all(color: AppColors.greyTextLightColor), // No border
                            borderRadius: BorderRadius.circular(Constant.width * .08),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: Constant.width * .18,
                          height: Constant.height * .06,
                          textStyle: TextStyle(fontSize: Constant.width * .04, color: Colors.black),
                          decoration: BoxDecoration(
                            color: Colors.transparent, // No background
                            border: Border.all(color: AppColors.primaryColor), // No border
                            borderRadius: BorderRadius.circular(Constant.width * .08),
                          ),
                        ),
                      ),
                    ),



                    SizedBox(height: Constant.height * .52),

                    /// Send me The Code
                    Obx(() {
                      return CommonButton(
                        onTap: () {
                          if(isOnlyDigits(loginVM.otpController.value.text) && loginVM.otpController.value.text.length == 4){
                            loginVM.otpVerification(widget.phone);
                          } else{
                            Utils.toastMessageTop('Invalid OTP');
                          }
                        },
                        title: 'Submit',
                        height: Constant.height * .06,
                        isLoading: loginVM.isLoading.value,
                      );
                    },)
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
