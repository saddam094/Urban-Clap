import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap/feature/authentication/set_profile/presentation/controller/set_profile_controller.dart';
import 'package:urban_clap/res/color/app_color.dart';
import 'package:urban_clap/res/common/common_button.dart';
import 'package:urban_clap/res/common/custom_app_bar.dart';
import 'package:urban_clap/res/constant/constant_data.dart';
import 'package:urban_clap/res/utils/utils.dart';

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
                    Obx(() {
                      return CircleAvatar(
                        radius: Constant.width * .15,
                        backgroundImage: setProfileVM.selectedImage.value != null
                            ? FileImage(setProfileVM.selectedImage.value!)
                            : AssetImage("assets/images/profile/person male.png") as ImageProvider,
                      );
                    }),

                    Positioned(
                      child: InkWell(
                        onTap: () {
                          setProfileVM.pickImage();
                        },
                        child: CircleAvatar(
                          radius: Constant.width * .05,
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(Icons.camera_alt, size: Constant.width * .06, color: AppColors.white),
                        ),
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
                Obx(() {
                  return CommonButton(
                    onTap: () {
                      if(setProfileVM.nameController.value.text.isNotEmpty && setProfileVM.locationController.value.text.isNotEmpty && setProfileVM.selectedSkills.isNotEmpty && setProfileVM.selectedImage.value != null){
                        setProfileVM.setProfile();
                      } else{
                        if(setProfileVM.nameController.value.text.isEmpty){
                          Utils.toastMessageTop('Enter Your Name');
                        }

                        if(setProfileVM.locationController.value.text.isEmpty){
                          Utils.toastMessageTop('Enter Your Location');
                        }

                        if(setProfileVM.selectedSkills.isEmpty){
                          Utils.toastMessageTop('Select Your Skills');
                        }

                        if(setProfileVM.selectedImage.value == null){
                          Utils.toastMessageTop('Select Profile Image');
                        }

                      }
                    },
                    title: 'Submit',
                    height: Constant.height * .06,
                    isLoading: setProfileVM.isLoading.value,
                  );
                }),

                SizedBox(height: Constant.height * .01),
              ],
            ),
          )

        ],
      ),
    );
  }
}
