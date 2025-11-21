import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/feature/authentication/login/presentation/view/login_screen.dart';
import 'package:urban_clap_vendor/feature/authentication/set_profile/presentation/view/set_profile_screen.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';

class CleaningScreen extends StatefulWidget {
  const CleaningScreen({super.key});

  @override
  State<CleaningScreen> createState() => _CleaningScreenState();
}

class _CleaningScreenState extends State<CleaningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          /// Image Container
          Container(
            height: Constant.height * .7,
            width: Constant.width * 1,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/auth_image/cleaning.png'),
                    fit: BoxFit.cover
                )
            ),
          ),

          /// Main Content
          Container(
            height: Constant.height * .35,
            width: Constant.width * 1,
            margin: EdgeInsets.only(
                top: Constant.height * .65
            ),
            padding: EdgeInsets.only(
              top: Constant.height * .025,
              left: Constant.width * .05,
              right: Constant.width * .05,
            ),
            decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white,
                    spreadRadius: Constant.width * .1,
                    blurRadius: Constant.width * .1,
                  )
                ]
            ),
            child: Column(
              children: [
                /// Title
                Text('Pick a service choose a time, and we’ll handle the rest', style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: AppColors.black), textAlign: TextAlign.center),

                SizedBox(height: Constant.height * .01),

                /// Description
                Text('Expert cleaning service for spotless \nhome everyday', style: TextStyle(fontSize: Constant.width * .035, color: AppColors.greyTextLightColor), textAlign: TextAlign.center),

                SizedBox(height: Constant.height * .025),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Constant.height * .005,
                      width: Constant.width * .1,
                      decoration: BoxDecoration(
                        color: AppColors.lightPrimaryColor,
                        borderRadius: BorderRadius.circular(Constant.width * .04),
                      ),
                    ),

                    SizedBox(width: Constant.width * .025),

                    Container(
                      height: Constant.height * .005,
                      width: Constant.width * .1,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(Constant.width * .04),
                      ),
                    )
                  ],
                ),

                Spacer(),

                InkWell(
                  onTap: () {
                    Get.to(() => const LoginScreen());
                  },
                  child: Container(
                    height: Constant.height * .06,
                    width: Constant.width * 1,
                    decoration: BoxDecoration(
                        color: AppColors.lightPrimaryColor,
                        borderRadius: BorderRadius.circular(Constant.width * .07)
                    ),
                    child: Center(
                      child: Text('Get Started', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.w800, color: AppColors.primaryColor)),
                    ),
                  ),
                ),

                SizedBox(height: Constant.height * .08),
              ],
            ),
          )
        ],
      ),
    );
  }
}