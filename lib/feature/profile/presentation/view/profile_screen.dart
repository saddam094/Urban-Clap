import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/core/response/status.dart';
import 'package:urban_clap_vendor/feature/authentication/schedule_skill/presentation/view/schedule_skill_screen.dart';
import 'package:urban_clap_vendor/feature/profile/presentation/controller/profile_controller.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/common/custom_app_bar.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final userProfileVM = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProfileVM.venderProfile();
    userProfileVM.venderDocument();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// Heading Container
          CustomAppBar(title: 'Profile', isBack: true, onBack: () => Navigator.pop(context)),

          Obx(() {
            return Container(
              height: Constant.height * .055,
              width: Constant.width * 1,
              margin: EdgeInsets.only(
                  left: Constant.width * .03,
                  right: Constant.width * .03
              ),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(Constant.width * .08),
                  border: Border.all(
                      color: AppColors.lightColor1
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// profile  button
                  InkWell(
                    onTap: () {
                      userProfileVM.isProfile.value = true;
                    },
                    child: Container(
                      height: Constant.height * .055,
                      width: Constant.width * .465,
                      decoration: BoxDecoration(
                          color: userProfileVM.isProfile.value ? AppColors.primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(Constant.width * .08)
                      ),
                      child: Center(
                        child: Text('Profile', style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: userProfileVM.isProfile.value ? AppColors.white : AppColors.greyTextDarkColor)),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      userProfileVM.isProfile.value = false;
                    },
                    child: Container(
                      height: Constant.height * .055,
                      width: Constant.width * .465,
                      decoration: BoxDecoration(
                          color: userProfileVM.isProfile.value ? Colors.transparent : AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(Constant.width * .08)
                      ),
                      child: Center(
                        child: Text('Documents', style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: userProfileVM.isProfile.value ? AppColors.greyTextDarkColor : AppColors.white)),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),

          SizedBox(height: Constant.height * .02),

          Obx(() {
            return userProfileVM.isProfile.value
                ? Expanded(
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
                    return SizedBox(
                      height: Constant.height * .87,
                      width: Constant.width * 1,
                      child: Column(
                        children: [
                          /// Profile Container
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Constant.width * .5),
                            child: Image.network(
                              data.profileImage,
                              height: Constant.height * .15,
                              width: Constant.width * .33,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: Constant.height * .2,
                                  width: Constant.width * .45,
                                  color: AppColors.cardBg,
                                  child: Center(
                                    child: Icon(Icons.person, size: Constant.width * .25),
                                  ),
                                );
                              },
                            ),
                          ),


                          SizedBox(
                            height: Constant.height * .01,
                          ),

                          /// Name
                          profileInfoTile(label: 'Name', value: data.name, maxLine: 1),
                          profileInfoTile(label: 'Phone', value: data.phone, maxLine: 1),
                          profileInfoTile(label: 'Account Status', value: data.accountVerified ? 'Verified' : 'Not Verified', maxLine: 1),
                          profileInfoTile(label: 'Skills', value: data.skills.join(',  '), maxLine: data.skills.length > 3 ? 2 : 1),
                          profileInfoTile(label: 'Address', value: data.location, maxLine: 2),
                        ],
                      ),
                    );
                }
              }),
            )
                : Expanded(
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
                    var data = userProfileVM.rxDocumentModel.value!;
                    return Container(
                      height: Constant.height * .87,
                      width: Constant.width * 1,
                      padding: EdgeInsets.only(
                        left: Constant.width * .03,
                        right: Constant.width * .03
                      ),
                      child: Column(
                        children: [
                          /// Id Proof ============================================
                          Container(
                            // height: Constant.height * .055,
                            width: Constant.width * 1,
                            padding: EdgeInsets.only(
                              left: Constant.width * .03,
                              right: Constant.width * .03,
                              top: Constant.height * .01,
                              bottom: Constant.height * .01
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Constant.width * .04),
                                border: Border.all(
                                    color: AppColors.greyTextLightColor
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /// Text
                                Text('ID Proof', style: TextStyle(fontSize: Constant.width * .035, color: AppColors.greyTextLightColor)),

                                data.idProof != "" ? Container(
                                  height: Constant.height * .15,
                                  width: Constant.width * .4,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(data.idProof),
                                      fit: BoxFit.cover
                                    ),
                                    borderRadius: BorderRadius.circular(Constant.width * .03)
                                  ),
                                ) : SizedBox()
                              ],
                            ),
                          ),

                          SizedBox(height: Constant.height * .015),


                          /// Skill Certificate ===================================
                          Container(
                            // height: Constant.height * .055,
                            width: Constant.width * 1,
                            padding: EdgeInsets.only(
                              left: Constant.width * .03,
                              right: Constant.width * .03,
                              top: Constant.height * .01,
                              bottom: Constant.height * .01
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Constant.width * .04),
                                border: Border.all(
                                    color: AppColors.greyTextLightColor
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /// Text
                                Text('Skill Certificate', style: TextStyle(fontSize: Constant.width * .035, color: AppColors.greyTextLightColor)),

                                data.idProof != "" ? Container(
                                  height: Constant.height * .15,
                                  width: Constant.width * .4,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(data.idProof),
                                          fit: BoxFit.cover
                                      ),
                                      borderRadius: BorderRadius.circular(Constant.width * .03)
                                  ),
                                ) : SizedBox()
                              ],
                            ),
                          ),


                          SizedBox(height: Constant.height * .015),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('SKILL TEST ', style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.black)),
                              Container(
                                height: Constant.height * .002,
                                width: Constant.width * .74,
                                decoration: BoxDecoration(
                                  color: AppColors.dashboardGradiant1
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: Constant.height * .01),

                          /// Detail Container
                          Container(
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
                                Text('📍 Test Center : ${data.appointment?.testCenter ?? "N/A"}', style: TextStyle(fontSize: Constant.width  * .04), maxLines: 2),

                                /// Date
                                Text('🗓  Date : ${data.appointment?.date ?? "N/A"}', style: TextStyle(fontSize: Constant.width  * .04), maxLines: 1),

                                /// Time
                                Text('⏰  Time : ${data.appointment?.time ?? "N/A"}', style: TextStyle(fontSize: Constant.width  * .04), maxLines: 1),
                              ],
                            ),
                          ),

                          SizedBox(height: Constant.height * .015),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Re-Schedule Button
                              InkWell(
                                onTap: () {
                                  Get.to(() => ScheduleSkillScreen(isReSchedule: true));
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
                              Obx(() {
                                return InkWell(
                                  onTap: () {
                                    userProfileVM.cancelSkillTest();
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
                                      child: userProfileVM.loadingCancelSkillTest.value ? CircularProgressIndicator(color: AppColors.primaryColor) : Text('Cancel Schedule', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),

                          // SizedBox(height: Constant.height * .02),

                          // Row(
                          //   children: [
                          //     /// Result ---> Text
                          //     Text('Result : ', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.black)),
                          //
                          //     Text('⏳ ${userProfileVM.detail['status']!.value}', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.redColor)),
                          //   ],
                          // ),

                          // SizedBox(height: Constant.height * .02),

                          /// message Box
                          // Container(
                          //   height: Constant.height * .055,
                          //   width: Constant.width * 1,
                          //   decoration: BoxDecoration(
                          //       color: AppColors.lightColor1,
                          //       borderRadius: BorderRadius.circular(Constant.width * .02)
                          //   ),
                          //   child: Center(child: Text(userProfileVM.detail['message']!.value.toString(), style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextDarkColor))),
                          // ),

                        ],
                      ),
                    );
                }
              }),
            );
          },)
        ],
      ),
    );
  }

  Widget profileInfoTile({
    required String label,
    required String value,
    required int maxLine,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: Constant.width * .03,
        right: Constant.width * .03,

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.greyTextDarkColor)),
          Container(
            width: Constant.width * 1,
            height: Constant.height * .06 * maxLine,
            margin: EdgeInsets.only(
                top: Constant.height * .004
            ),
            padding: EdgeInsets.only(
                left: Constant.width * .02,
                right: Constant.width * .02,
                top: Constant.height * .012
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyTextDarkColor),
              borderRadius: BorderRadius.circular(Constant.width * .02),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: Constant.width * .05, color: AppColors.greyTextLightColor),maxLines: maxLine,
            ),
          ),
        ],
      ),
    );
  }

}
