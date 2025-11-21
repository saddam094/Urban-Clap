import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/feature/authentication/skill_test/presentation/controller/skill_test_controller.dart';
import 'package:urban_clap_vendor/feature/authentication/skill_test/presentation/view/review_screen.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/common/common_button.dart';
import 'package:urban_clap_vendor/res/common/custom_app_bar.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';
import 'package:urban_clap_vendor/res/utils/utils.dart';

class SkillTestScreen extends StatefulWidget {
  const SkillTestScreen({super.key});

  @override
  State<SkillTestScreen> createState() => _SkillTestScreenState();
}

class _SkillTestScreenState extends State<SkillTestScreen> {

  final skillTestVM = Get.put(SkillTestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        height: Constant.height * 1,
        width: Constant.width * 1,
        child: Column(
          children: [
            /// Heading
            CustomAppBar(title: 'Skill Test', isBack: true, onBack: () => Navigator.pop(context)),

            /// Main Container
            Expanded(
              child: Obx(() {
                var index = skillTestVM.currentQuestionIndex.value;
                var question = skillTestVM.questions[index] as Map<String, dynamic>;
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Constant.width * 0.05,
                    vertical: Constant.height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Question ${index + 1} of ${skillTestVM.questions.length}',
                        style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.greyTextDarkColor),
                      ),
                      SizedBox(height: 10),
                      Text(question['question'],
                        style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black),
                      ),
                      SizedBox(height: 20),
                      ...List.generate(4, (i) {
                        String option = question['options']?[i];
                        bool isSelected = skillTestVM.isSelected(index, option);
                        bool isCorrect = skillTestVM.isCorrect(index, option);

                        Color borderColor = Colors.grey.shade300;
                        Color bgColor = Colors.white;
                        if (isSelected) {
                          borderColor = isCorrect ? AppColors.primaryColor : AppColors.redColor;
                          bgColor = isCorrect ? AppColors.cardBg1 : AppColors.redColor;
                        }

                        return GestureDetector(
                          onTap: () {
                            if(skillTestVM.isSelectedOption.value){
                              Utils.toastMessageTop(index < skillTestVM.questions.length - 1 ? 'Click On Next' : 'Click on Submit Final Review');
                            }else{
                              skillTestVM.selectAnswer(index, option);
                            }

                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            padding: EdgeInsets.all(16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: bgColor,
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(option),
                          ),
                        );
                      }),

                      SizedBox(height: Constant.height * .01),

                      Text(skillTestVM.isSelectedOption.value ? question['answer'] : '', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greenTextColor)),

                      Spacer(),
                      CommonButton(
                        onTap: () {
                          if (index < skillTestVM.questions.length - 1) {
                            skillTestVM.isSelectedOption.value = false;
                            skillTestVM.currentQuestionIndex.value++;
                          } else {
                            int finalScore = skillTestVM.calculateScore();
                            Get.to(() => ReviewScreen(score: finalScore));
                          }
                        },
                        title: index < skillTestVM.questions.length - 1
                            ? "Next"
                            : "Submit for Final Review",
                        height: Constant.height * .055,
                        width: Constant.width * 1,
                      ),

                      SizedBox(height: Constant.height * .05)
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

