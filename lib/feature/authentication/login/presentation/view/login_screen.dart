import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/feature/authentication/login/presentation/controller/login_controller.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/common/common_button.dart';
import 'package:urban_clap_vendor/res/common/custom_app_bar.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';
import 'package:urban_clap_vendor/res/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
              CustomAppBar(title: ''),

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

                    Text('Enter Your Phone Number', style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black)),

                    SizedBox(height: Constant.height * .01),

                    Text('We’ll send an OTP verifcation code to you', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextDarkColor)),

                    SizedBox(height: Constant.height * .04),

                    Container(
                      height: Constant.height * .06,
                      width: Constant.width * 1,
                      padding: EdgeInsets.only(
                        left: Constant.width * .03,
                        right: Constant.width * .03,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Constant.width * .1),
                        border: Border.all(
                          color: AppColors.greyTextLightColor
                        )
                      ),
                      child: Row(
                        children: [
                          /// +91
                          Text('+ 91', style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),

                          SizedBox(width: Constant.width * .02),

                          /// Divider
                          Container(
                            height: Constant.height  * .04,
                            width: Constant.width * .006,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor
                            ),
                          ),

                          /// TextField ---> Phone Number
                          Expanded(
                            child: TextFormField(
                              controller: loginVM.phoneController.value,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(color: AppColors.greyTextDarkColor),
                                isDense: true,
                                // contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),


                    SizedBox(height: Constant.height * .55),

                    /// Send me The Code
                    Obx(() {
                      return CommonButton(
                        onTap: () {

                          if(isOnlyDigits(loginVM.phoneController.value.text) && loginVM.phoneController.value.text.length == 10){
                              loginVM.login();
                          } else{
                            Utils.toastMessageTop('Incorrect Phone Number');
                          }

                        },
                        title: 'Send me the code',
                        height: Constant.height * .06,
                        isLoading: loginVM.isLoading.value,
                      );
                    }),

                    SizedBox(height: Constant.height * .08)
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

