import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap/feature/authentication/document_verification/presentation/controller/document_verification_controller.dart';
import 'package:urban_clap/feature/authentication/set_profile/presentation/view/set_profile_screen.dart';
import 'package:urban_clap/feature/authentication/skill_test/presentation/view/skill_test_screen.dart';
import 'package:urban_clap/res/color/app_color.dart';
import 'package:urban_clap/res/common/common_button.dart';
import 'package:urban_clap/res/common/custom_app_bar.dart';
import 'package:urban_clap/res/constant/constant_data.dart';

class DocumentVerificationScreen extends StatefulWidget {
  const DocumentVerificationScreen({super.key});

  @override
  State<DocumentVerificationScreen> createState() => _DocumentVerificationScreenState();
}

class _DocumentVerificationScreenState extends State<DocumentVerificationScreen> {

  final documentVerificationVM = Get.put(DocumentVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// Heading
          CustomAppBar(title: '', isBack: false, onBack: () => Navigator.pop(context)),

          /// Main Container
          Obx(() {
            return Container(
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
                  /// Title Text
                  Text('Document Verification', style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black)),

                  SizedBox(height: Constant.height * .02),

                  /// Upload Id Proof ============================================
                  Container(
                    height: Constant.height * .055,
                    width: Constant.width * 1,
                    padding: EdgeInsets.only(
                      left: Constant.width * .03,
                      right: Constant.width * .03,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Constant.width * .04),
                        border: Border.all(
                            color: AppColors.greyTextLightColor
                        )
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// Icon
                        Icon(Icons.image_outlined, size: Constant.width * .06, color: AppColors.primaryColor),

                        SizedBox(width: Constant.width * .02),

                        /// Text
                        Text('Upload ID Proof', style: TextStyle(fontSize: Constant.width * .035, color: AppColors.greyTextLightColor))
                      ],
                    ),
                  ),

                  /// Upload ID Proof ---> Status
                  Row(
                    children: [
                      Text('Status : ', style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.black)),
                      Text('Pending', style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.redColor)),
                    ],
                  ),

                  SizedBox(height: Constant.height * .015),


                  /// Upload Skill Certificate ===================================
                  Container(
                    height: Constant.height * .055,
                    width: Constant.width * 1,
                    padding: EdgeInsets.only(
                      left: Constant.width * .03,
                      right: Constant.width * .03,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Constant.width * .04),
                        border: Border.all(
                            color: AppColors.greyTextLightColor
                        )
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// Icon
                        Icon(Icons.image_outlined, size: Constant.width * .06, color: AppColors.primaryColor),

                        SizedBox(width: Constant.width * .02),

                        /// Text
                        Text('Upload Skill Certificate', style: TextStyle(fontSize: Constant.width * .035, color: AppColors.greyTextLightColor))
                      ],
                    ),
                  ),

                  /// Upload Skill Certificate ---> Status
                  Row(
                    children: [
                      Text('Status : ', style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.black)),
                      Text('Pending', style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.redColor)),
                    ],
                  ),

                  Divider(
                    indent: Constant.width * .03,
                    endIndent: Constant.width * .03,
                  ),

                  SizedBox(height: Constant.height * .005),


                  /// Background Check ---> Status =======================
                  Row(
                    children: [
                      Text('Background Check : ', style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.black)),
                      Text('Pending', style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.redColor)),
                    ],
                  ),

                  /// Background Check ---> Message ==============================
                  Container(
                    height: Constant.height * .05,
                    width: Constant.width * 1,
                    padding: EdgeInsets.only(
                      left: Constant.width * .03,
                      right: Constant.width * .03,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg1,
                      borderRadius: BorderRadius.circular(Constant.width * .02),
                    ),
                    child: Center(child: Text('(We`ll notify you once it`s verified by our team)', style: TextStyle(fontSize: Constant.width * .035, color: AppColors.greyTextDarkColor), maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ),

                  SizedBox(height: Constant.height * .005),

                  Divider(
                    indent: Constant.width * .03,
                    endIndent: Constant.width * .03,
                  ),

                  SizedBox(height: Constant.height * .005),

                  Text('Skill Test', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.black)),

                  SizedBox(height: Constant.height * .002),

                  Text('Take a short test to verify your knowledge', style: TextStyle(fontSize: Constant.width * .035, color: AppColors.greyTextDarkColor), maxLines: 2, overflow: TextOverflow.ellipsis),

                  SizedBox(height: Constant.height * .01),

                  /// Skill Test ---> Container ==================================
                  Container(
                    height: Constant.height * .06,
                    width: Constant.width * 1,
                    padding: EdgeInsets.only(
                      left: Constant.width * .03,
                      right: Constant.width * .03,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.cardBg1,
                        borderRadius: BorderRadius.circular(Constant.width * .04),
                        border: Border.all(
                            color: AppColors.greyTextLightColor
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Constant.width * .4,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /// Icon
                              Icon(Icons.menu_book, size: Constant.width * .06, color: AppColors.primaryColor),

                              SizedBox(width: Constant.width * .02),

                              /// Text
                              Text('Start Skill Test', style: TextStyle(fontSize: Constant.width * .035, color: AppColors.greyTextDarkColor))
                            ],
                          ),
                        ),

                        /// Start Button
                        InkWell(
                          onTap: () {
                            Get.to(() => SkillTestScreen());
                          },
                          child: Container(
                            height: Constant.height * .04,
                            width: Constant.width * .22,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(Constant.width * .02),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /// Text
                                Text('Start', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.white, fontWeight: FontWeight.bold)),

                                /// Icon
                                Icon(Icons.arrow_right, size: Constant.width * .08, color: AppColors.white)
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                  ),

                  SizedBox(height: Constant.height * .01),

                  /// Time & Question Text
                  Text('Time: 10 Min | Questions: 10 MCQs', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.greyTextDarkColor)),


                  SizedBox(height: Constant.height * .25),

                  /// Submit Final Review ---> Button
                  CommonButton(
                    onTap: () {
                      Get.to(() => SetProfileScreen());
                    },
                    title: 'Submit Final Review',
                    height: Constant.height * .055,
                    width: Constant.width * 1,
                    isEnabled: documentVerificationVM.isSubmit.value,
                  )
                ],
              ),
            );
          },)
        ],
      ),
    );
  }
}
