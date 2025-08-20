import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap/feature/authentication/login/presentation/view/login_screen.dart';
import 'package:urban_clap/res/color/app_color.dart';
import 'package:urban_clap/res/constant/constant_data.dart';

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

                SizedBox(height: Constant.height * .07),

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
                )
              ],
            ),
          )
        ],
      ),
      // body: SafeArea(
      //   child: Column(
      //     children: [
      //       // Image
      //       Expanded(
      //         flex: 6,
      //         child: Image.asset(
      //           'assets/images/auth_image/washing.png',
      //           fit: BoxFit.cover,
      //           width: double.infinity,
      //         ),
      //       ),
      //       // Text content
      //       Expanded(
      //         flex: 4,
      //         child: Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               const Text(
      //                 "Clean Simple Convenient",
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   fontSize: 22,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.black,
      //                 ),
      //               ),
      //               const SizedBox(height: 12),
      //               const Text(
      //                 "Get your laundry cleaned with care\nand exception service",
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   fontSize: 16,
      //                   color: Colors.grey,
      //                 ),
      //               ),
      //               const SizedBox(height: 20),
      //               // Progress indicator
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Container(
      //                     height: 4,
      //                     width: 30,
      //                     decoration: BoxDecoration(
      //                       color: Colors.blue,
      //                       borderRadius: BorderRadius.circular(10),
      //                     ),
      //                   ),
      //                   const SizedBox(width: 6),
      //                   Container(
      //                     height: 4,
      //                     width: 8,
      //                     decoration: BoxDecoration(
      //                       color: Colors.grey.shade300,
      //                       borderRadius: BorderRadius.circular(10),
      //                     ),
      //                   ),
      //                   const SizedBox(width: 6),
      //                   Container(
      //                     height: 4,
      //                     width: 8,
      //                     decoration: BoxDecoration(
      //                       color: Colors.grey.shade300,
      //                       borderRadius: BorderRadius.circular(10),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               const SizedBox(height: 30),
      //               // Buttons
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   TextButton(
      //                     onPressed: () {
      //                       // Skip logic
      //                     },
      //                     child: const Text(
      //                       'Skip',
      //                       style: TextStyle(color: Colors.blue, fontSize: 16),
      //                     ),
      //                   ),
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       // Next screen logic
      //                     },
      //                     style: ElevatedButton.styleFrom(
      //                       backgroundColor: Colors.blue.shade100,
      //                       foregroundColor: Colors.blue,
      //                       shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(20),
      //                       ),
      //                       padding: const EdgeInsets.symmetric(
      //                         vertical: 10,
      //                         horizontal: 24,
      //                       ),
      //                     ),
      //                     child: const Text('Next'),
      //                   ),
      //                 ],
      //               )
      //             ],
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}