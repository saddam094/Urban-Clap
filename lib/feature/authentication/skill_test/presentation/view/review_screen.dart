import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap/feature/authentication/document_verification/presentation/view/document_verification_screen.dart';
import 'package:urban_clap/feature/authentication/skill_test/presentation/controller/skill_test_controller.dart';
import 'package:urban_clap/res/color/app_color.dart';
import 'package:urban_clap/res/common/common_button.dart';
import 'package:urban_clap/res/common/custom_app_bar.dart';
import 'package:urban_clap/res/constant/constant_data.dart';

class ReviewScreen extends StatelessWidget {
  final int score;
  final SkillTestController controller = Get.find();

  ReviewScreen({super.key, required this.score});

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
            CustomAppBar(title: 'Your Score: $score / ${controller.questions.length}', isBack: true, onBack: () => Navigator.pop(context)),

            /// Main Container
            Expanded(
              child: Obx(() {
                return Padding(
                  padding: EdgeInsets.only(
                    left: Constant.width * .03,
                    right: Constant.width * .03
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.questions.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final question = controller.questions[index];
                            final userAnswer = controller.selectedAnswers[index] ?? 'Not Answered';
                            final correctAnswer = question['answer'];

                            return Card(
                              child: ListTile(
                                title: Text("${index + 1}. ${question['question']}", style: TextStyle(fontSize: Constant.width * .035, color: AppColors.black)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: Constant.width * .01),
                                    Text("Your Answer: $userAnswer",
                                        style: TextStyle(fontSize: Constant.width * .035, color: userAnswer == correctAnswer ? AppColors.greenTextColor : AppColors.redColor)),
                                    Text("Correct Answer: $correctAnswer",
                                        style:  TextStyle(fontSize: Constant.width * .035, color: AppColors.greenTextColor)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: Constant.height * .01),

                      CommonButton(
                        onTap: () {
                          Get.offAll(() => DocumentVerificationScreen());
                        },
                        title: "Submit",
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
