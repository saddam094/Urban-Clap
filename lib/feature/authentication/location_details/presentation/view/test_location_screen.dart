import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/feature/authentication/location_details/presentation/controller/test_location_details_controller.dart';
import 'package:urban_clap_vendor/feature/dashboard/presentation/view/dashboard_screen.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/common/common_button.dart';
import 'package:urban_clap_vendor/res/common/custom_app_bar.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';

class TestLocationScreen extends StatefulWidget {
  const TestLocationScreen({super.key});

  @override
  State<TestLocationScreen> createState() => _TestLocationScreenState();
}

class _TestLocationScreenState extends State<TestLocationScreen> {

  final testLocationController = Get.put(TestLocationDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Heading
            CustomAppBar(title: 'Location Details', isBack: false, onBack: () => Navigator.pop(context)),

            /// Main Container
            Container(
              height: Constant.height * .87,
              width: Constant.width * 1,
              padding: EdgeInsets.only(
                left: Constant.width * .03,
                right: Constant.width * .03,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Detail Container
                  Obx(() {
                    return Container(
                      height: Constant.height * .14,
                      width: Constant.width * 1,
                      padding: EdgeInsets.only(
                          left: Constant.width * .03,
                          right: Constant.width * .03,
                          top: Constant.height * .015,
                          bottom: Constant.height * .015
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Constant.width * .03),
                          border: Border.all(color: AppColors.darkPrimaryColor)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          /// Test Center
                          Text('📍 Test Center : ${testLocationController.detail['testCenter']!.value}', style: TextStyle(fontSize: Constant.width  * .04), maxLines: 2),

                          /// Date
                          Text('🗓  Date : ${testLocationController.detail['date']!.value}', style: TextStyle(fontSize: Constant.width  * .04), maxLines: 1),

                          /// Time
                          Text('⏰  Time : ${testLocationController.detail['time']!.value}', style: TextStyle(fontSize: Constant.width  * .04), maxLines: 1),
                        ],
                      ),
                    );
                  },),

                  SizedBox(height: Constant.height * .015),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Re-Schedule Button
                      InkWell(
                        onTap: () {

                        },
                        child: Container(
                          height: Constant.height * .055,
                          width: Constant.width * .37,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(Constant.width * .02),
                          ),
                          child: Center(
                            child: Text('Re-Schedule', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.white)),
                          ),
                        ),
                      ),

                      /// Cancel Schedule Button
                      InkWell(
                        onTap: () {

                        },
                        child: Container(
                          height: Constant.height * .055,
                          width: Constant.width * .37,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Constant.width * .02),
                              border: Border.all(
                                  color: AppColors.primaryColor
                              )
                          ),
                          child: Center(
                            child: Text('Cancel Schedule', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: Constant.height * .02),

                  Row(
                    children: [
                      /// Result ---> Text
                      Text('Result : ', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.black)),

                      Text('⏳ ${testLocationController.detail['status']!.value}', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.redColor)),
                    ],
                  ),

                  SizedBox(height: Constant.height * .02),

                  /// message Box
                  Container(
                    height: Constant.height * .055,
                    width: Constant.width * 1,
                    decoration: BoxDecoration(
                        color: AppColors.lightColor1,
                        borderRadius: BorderRadius.circular(Constant.width * .02)
                    ),
                    child: Center(child: Text(testLocationController.detail['message']!.value.toString(), style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextDarkColor))),
                  ),

                  Spacer(),

                  CommonButton(
                    onTap: () {
                      Get.offAll(() => DashboardScreen());
                    },
                    title: 'Move To Home Page',
                    height: Constant.height * .055,
                    width: Constant.width * 1,
                  ),

                  SizedBox(height: Constant.height * .08)

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
