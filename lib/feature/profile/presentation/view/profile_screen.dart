import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap/core/response/status.dart';
import 'package:urban_clap/feature/profile/presentation/controller/profile_controller.dart';
import 'package:urban_clap/res/color/app_color.dart';
import 'package:urban_clap/res/common/custom_app_bar.dart';
import 'package:urban_clap/res/constant/constant_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final userProfileVM = Get.put(ProfileController());

  // Reusable widget for profile info
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
          CustomAppBar(title: 'Profile', isBack: true, onBack: () => Navigator.pop(context)),

          Obx(() {
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
                      /// Edit Button
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     CommonButton(
                      //       height: Constant.height * .05,
                      //       width: Constant.width * .25,
                      //       margin: EdgeInsets.only(
                      //           right: Constant.width * .03,
                      //           top: Constant.height * .01
                      //       ),
                      //       title: 'Edit',
                      //       onTap: () {
                      //         // Get.to(() => EditProfileScreen());
                      //       },
                      //     )
                      //   ],
                      // ),

                      /// Profile Container
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Constant.width * .5),
                        child: Image.network(
                          data.profileImage,
                          height: Constant.height * .2,
                          width: Constant.width * .45,
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
        ],
      ),

      
    );
  }
}
