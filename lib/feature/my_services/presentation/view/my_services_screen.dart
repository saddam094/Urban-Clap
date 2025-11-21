import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/core/response/status.dart';
import 'package:urban_clap_vendor/feature/profile/presentation/controller/profile_controller.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/common/custom_app_bar.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';

class MyServicesScreen extends StatefulWidget {
  const MyServicesScreen({super.key});

  @override
  State<MyServicesScreen> createState() => _MyServicesScreenState();
}

class _MyServicesScreenState extends State<MyServicesScreen> {

  final userProfileVM = Get.put(ProfileController());

  List<String> allSkills = ['Plumber', 'Electrician', 'Cleaning', 'Ac Repair'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProfileVM.venderProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// Heading Container
          CustomAppBar(title: 'My Services', isBack: true, onBack: () => Navigator.pop(context)),

          Expanded(
            child: Obx(() {
              switch (userProfileVM.rxRequestStatusUserProfile.value) {
                case Status.LOADING:
                  return SizedBox(
                    height: Constant.height * .87,
                    width: Constant.width * 1,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                case Status.ERROR:
                  return SizedBox(
                    height: Constant.height * .87,
                    width: Constant.width * 1,
                    child: Center(
                      child: Text('Something Went Wrong...',
                          style: TextStyle(
                              fontSize: Constant.width * .05,
                              color: AppColors.redColor)),
                    ),
                  );

                case Status.COMPLETED:
                  var data = userProfileVM.rxUserProfileModel.value!;
                  return Container(
                    height: Constant.height * .87,
                    width: Constant.width * 1,
                    padding: EdgeInsets.only(
                      left: Constant.width * .03,
                      right: Constant.width * .03
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Active Services
                        SizedBox(
                          height: Constant.height * .08 * data.skills.length,
                          width: Constant.width * 1,
                          child: ListView.builder(
                            itemCount: data.skills.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return serviceCard(data.skills[index], true);
                            },
                          ),
                        ),

                        SizedBox(height: Constant.height * .02),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Unactive Services ', style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.black)),
                            Container(
                              height: Constant.height * .002,
                              width: Constant.width * .63,
                              decoration: BoxDecoration(
                                  color: AppColors.dashboardGradiant1
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: Constant.height * .08 * (allSkills.length - data.skills.length),
                          width: Constant.width * 1,
                          child: ListView.builder(
                            itemCount: allSkills.where((skill) => !data.skills.contains(skill)).length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final unactiveSkill = allSkills.where((skill) => !data.skills.contains(skill)).toList()[index];
                              return serviceCard(unactiveSkill, false);
                            },
                          ),
                        ),


                      ],
                    ),
                  );

                default :
                  return SizedBox();
              }
            }),
          )
        ],
      ),
    );
  }

  Widget serviceCard(String title, bool isActive){
    return Container(
      height: Constant.height * .07,
      width: Constant.width * 1,
      margin: EdgeInsets.only(
        top: Constant.height * .01
      ),
      padding: EdgeInsets.only(
        left: Constant.width * .03,
        right: Constant.width * .03
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constant.width * .03),
        border: Border.all(
          color: AppColors.primaryColor
        )
      ),
      child: Row(
        children: [
          /// Icon
          Icon(isActive ? Icons.radio_button_checked : Icons.radio_button_off, size: Constant.width * .07, color: isActive ? AppColors.primaryColor : AppColors.greyTextLightColor),

          SizedBox(width: Constant.width * .05),

          /// Title
          Text(title, style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.primaryColor),)
        ],
      ),
    );
  }
}