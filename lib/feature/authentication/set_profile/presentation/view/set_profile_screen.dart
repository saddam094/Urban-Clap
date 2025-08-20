import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap/feature/authentication/set_profile/presentation/controller/set_profile_controller.dart';
import 'package:urban_clap/feature/dashboard/presentation/view/dashboard_screen.dart';
import 'package:urban_clap/res/color/app_color.dart';
import 'package:urban_clap/res/common/custom_app_bar.dart';
import 'package:urban_clap/res/constant/constant_data.dart';

class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen({super.key});

  @override
  State<SetProfileScreen> createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen> {

  final setProfileVM = Get.put(SetProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// Heading
          CustomAppBar(title: 'Profile Setup', isBack: false, onBack: () => Navigator.pop(context)),

          /// Main Container
          SingleChildScrollView(
            padding:  EdgeInsets.only(
              left: Constant.width * .03,
              right: Constant.width * .03,
            ),
            child: Column(
              children: [
                SizedBox(height: Constant.height * .05),

                /// Profile Image
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: Constant.width * .15,
                      backgroundImage: AssetImage("assets/images/profile/person male.png"), // Replace with Network or File
                    ),
                    Positioned(
                      child: CircleAvatar(
                        radius: Constant.width * .05,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(Icons.camera_alt, size: Constant.width * .06, color: AppColors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Constant.height * .05),

                /// Name Input
                TextField(
                  controller: setProfileVM.nameController.value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: Constant.height * .01),

                /// Location Input
                TextField(
                  controller: setProfileVM.locationController.value,
                  decoration:  InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    hintText: "Location",
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: Constant.height * .01),

                /// Skills
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Skills", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: Constant.height * .01),
                Obx(() => Wrap(
                  spacing: Constant.width * .03,
                  runSpacing: Constant.width * .03,
                  children: setProfileVM.allSkills.map((skill) {
                    bool isSelected = setProfileVM.selectedSkills.contains(skill);
                    return ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            skill == "Plumber"
                                ? Icons.plumbing
                                : skill == "Electrician"
                                ? Icons.electrical_services
                                : skill == "Cleaning"
                                ? Icons.cleaning_services
                                : Icons.ac_unit,
                            size: Constant.width * .035,
                            color: isSelected ? AppColors.white : AppColors.black,
                          ),
                          SizedBox(width: Constant.width * .03),
                          Text(skill),
                        ],
                      ),
                      selected: isSelected,
                      selectedColor: Colors.blue,
                      onSelected: (_) => setProfileVM.toggleSkill(skill),
                    );
                  }).toList(),
                )),

                SizedBox(height: Constant.height * .01),

                /// Confirm Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if(kDebugMode){
                        print("Name: ${setProfileVM.nameController.value.text}");
                        print("Location: ${setProfileVM.locationController.value.text}");
                        print("Selected Skills: ${setProfileVM.selectedSkills}");
                      }

                      Get.offAll(() => DashboardScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(vertical: Constant.height * .015),
                    ),
                    child: Text("Submit", style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: AppColors.white)),
                  ),
                ),

                SizedBox(height: Constant.height * .01),
              ],
            ),
          )

        ],
      ),
    );
  }
}
