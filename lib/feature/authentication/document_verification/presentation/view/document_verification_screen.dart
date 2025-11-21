import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/feature/authentication/document_verification/presentation/controller/document_verification_controller.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/common/common_button.dart';
import 'package:urban_clap_vendor/res/common/custom_app_bar.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';
import 'package:urban_clap_vendor/res/utils/utils.dart';

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
                  InkWell(
                    onTap: () => documentVerificationVM.pickImage(isIdProof: true),
                    child: Container(
                      height: documentVerificationVM.idProofImage.value == null ? Constant.height * .06 : Constant.height * .12,
                      width: Constant.width * 1,
                      padding: EdgeInsets.all(Constant.width * .03),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Constant.width * .04),
                        border: Border.all(color: AppColors.greyTextLightColor),
                      ),
                      child: Obx(() {
                        final image = documentVerificationVM.idProofImage.value;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.image_outlined,
                                size: Constant.width * .06, color: AppColors.primaryColor),
                            SizedBox(width: Constant.width * .02),
                            image == null
                                ? Text('Upload ID Proof',
                                style: TextStyle(
                                    fontSize: Constant.width * .035,
                                    color: AppColors.greyTextLightColor))
                                : Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text('ID Proof',
                                        style: TextStyle(
                                            fontSize: Constant.width * .035,
                                            color: AppColors.greyTextLightColor)),
                                  ),
                                  SizedBox(
                                    width: Constant.width * .28,
                                    child: ClipRRect(
                                      // borderRadius: BorderRadius.circular(Constant.width * .02),
                                      child: Image.file(image, fit: BoxFit.contain),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),

                  /// Upload ID Proof ---> Status
                  Row(
                    children: [
                      Text('Status : ', style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.black)),
                      Text('⏳ Pending', style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.redColor)),
                    ],
                  ),

                  SizedBox(height: Constant.height * .015),

                  /// Upload Skill Certificate ===================================
                  InkWell(
                    onTap: () => documentVerificationVM.pickImage(isIdProof: false),
                    child: Container(
                      height: documentVerificationVM.certificateImage.value == null ? Constant.height * .06 : Constant.height * .12,
                      width: Constant.width * 1,
                      padding: EdgeInsets.all(Constant.width * .03),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Constant.width * .04),
                        border: Border.all(color: AppColors.greyTextLightColor),
                      ),
                      child: Obx(() {
                        final image = documentVerificationVM.certificateImage.value;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.image_outlined,
                                size: Constant.width * .06, color: AppColors.primaryColor),
                            SizedBox(width: Constant.width * .02),
                            image == null
                                ? Text('Upload Skill Certificate',
                                style: TextStyle(
                                    fontSize: Constant.width * .035,
                                    color: AppColors.greyTextLightColor))
                                : Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text('Skill Certificate',
                                            style: TextStyle(
                                                fontSize: Constant.width * .035,
                                                color: AppColors.greyTextLightColor)),
                                      ),
                                      SizedBox(
                                        width: Constant.width * .28,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(Constant.width * .02),
                                          child: Image.file(image, fit: BoxFit.contain),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ],
                        );
                      }),
                    ),
                  ),

                  /// Upload Skill Certificate ---> Status
                  Row(
                    children: [
                      Text('Status : ', style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.black)),
                      Text('⏳ Pending', style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.redColor)),
                    ],
                  ),

                  Spacer(),

                  /// Submit Final Review ---> Button
                  CommonButton(
                    onTap: () {
                      if(documentVerificationVM.idProofImageName.value != '' && documentVerificationVM.certificateImageName.value != ''){
                        documentVerificationVM.uploadDocuments();
                      } else {
                        if(documentVerificationVM.idProofImageName.value == ''){
                          Utils.toastMessageTop('Select ID Proof');
                        }
                        if(documentVerificationVM.certificateImageName.value == ''){
                          Utils.toastMessageTop('Select Skill Certificate');
                        }
                      }
                    },
                    title: 'Submit',
                    height: Constant.height * .055,
                    width: Constant.width * 1,
                    isLoading: documentVerificationVM.isLoading.value,
                  ),

                  SizedBox(height: Constant.height * .08),
                ],
              ),
            );
          },)
        ],
      ),
    );
  }

}
