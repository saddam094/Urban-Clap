import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/core/response/status.dart';
import 'package:urban_clap_vendor/feature/authentication/set_profile/presentation/controller/set_profile_controller.dart';
import 'package:urban_clap_vendor/feature/map_picker/presentation/view/map_picker_screen.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/common/common_button.dart';
import 'package:urban_clap_vendor/res/common/custom_app_bar.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';
import 'package:urban_clap_vendor/res/utils/utils.dart';

class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen({super.key});

  @override
  State<SetProfileScreen> createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  final setProfileVM = Get.put(SetProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setProfileVM.fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// Heading
          CustomAppBar(
              title: 'Profile Setup',
              isBack: false,
              onBack: () => Navigator.pop(context)),

          /// Main Container
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
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
                        return Container(
                          height: Constant.height * .14,
                          width: Constant.width * .33,
                          decoration: BoxDecoration(
                            color: AppColors.cardBg,
                            borderRadius:
                                BorderRadius.circular(Constant.width * .05),
                            border: Border.all(color: AppColors.primaryColor),
                            image: setProfileVM.selectedImage.value != null
                                ? DecorationImage(
                                    image: FileImage(
                                        setProfileVM.selectedImage.value!),
                                    fit: BoxFit.cover)
                                : null,
                          ),
                          child: setProfileVM.selectedImage.value == null
                              ? Icon(Icons.person,
                                  size: Constant.width * .2,
                                  color: AppColors.greyTextDarkColor)
                              : null,
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
                            child: Icon(Icons.camera_alt,
                                size: Constant.width * .06,
                                color: AppColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Obx(() {
                    return SizedBox(
                      height: setProfileVM.isToggle.value
                          ? Constant.height * .02
                          : Constant.height * .05,
                    );
                  }),

                  /// Name Input
                  TextField(
                    controller: setProfileVM.nameController.value,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.black,
                      ),
                      hintText: "Name",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                          borderRadius:
                              BorderRadius.circular(Constant.width * .03)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                          borderRadius:
                              BorderRadius.circular(Constant.width * .03)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor)),
                    ),
                  ),

                  SizedBox(height: Constant.height * .01),

                  /// Location Input
                  SizedBox(
                    height: Constant.height * .064,
                    width: Constant.width * 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Constant.width * .62,
                          child: TextField(
                            controller: setProfileVM.locationController.value,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_on,
                                  color: AppColors.black),
                              hintText: "Location",
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      Constant.width * .03)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      Constant.width * .03)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor)),
                            ),
                          ),
                        ),

                        SizedBox(height: Constant.width * .02),

                        /// Location Detector Button
                        CommonButton(
                          onTap: () async {
                            final result =
                                await Get.to(() => const MapPickerScreen());
                            if (result != null) {
                              if (kDebugMode) {
                                print(result);
                              }
                              setProfileVM.locationController.value.text =
                                  result['address'];
                              setProfileVM.longitude.value = result['lng'];
                              setProfileVM.latitude.value = result['lat'];
                            }
                          },
                          title: 'Location',
                          width: Constant.width * .3,
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: Constant.height * .01),

                  /// Skills Section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Category",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  /// Category + Skill
                  Obx(() {
                    switch (setProfileVM.rxRequestStatusCategory.value) {
                      case Status.LOADING:
                        return SizedBox(
                          height: Constant.height * .3,
                          width: Constant.width * 1,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                      case Status.ERROR:
                        return SizedBox(
                          height: Constant.height * .3,
                          width: Constant.width * 1,
                          child: Center(
                            child: Text('Unable To Get Category...',
                                style: TextStyle(
                                    fontSize: Constant.width * .05,
                                    color: AppColors.redColor)),
                          ),
                        );

                      case Status.COMPLETED:
                        return SizedBox(
                          height: Constant.height * .065 * setProfileVM.rxCategoryModel.value!.items.length,
                          width: Constant.width * 1,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: setProfileVM
                                .rxCategoryModel.value!.items.length,
                            itemBuilder: (context, index) {
                              var data = setProfileVM
                                  .rxCategoryModel.value!.items[index];
                              return Obx(
                                () {
                                  return Container(
                                    height: Constant.height * .05,
                                    width: Constant.width * 1,
                                    margin: EdgeInsets.only(
                                        top: Constant.width * .025),
                                    decoration: BoxDecoration(
                                        color: setProfileVM.isToggle.value &&
                                                setProfileVM.selectedIndex.value == index
                                            ? AppColors.primaryColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                            Constant.width * .03),
                                        border: Border.all(
                                          color: AppColors.buttonBorderColor,
                                        )),
                                    child: Center(
                                            child: InkWell(
                                              onTap: () {
                                                if (setProfileVM.selectedIndex.value == index) {
                                                  setProfileVM.selectedMainSkill.value = '';
                                                  setProfileVM.selectedIndex.value = 10000;
                                                  setProfileVM.isToggle.value = false;
                                                } else {
                                                  setProfileVM.selectedMainSkill.value = data.category;
                                                  setProfileVM.selectedSubSkills.clear();
                                                  setProfileVM.selectedIndex.value = index;
                                                  setProfileVM.fetchSkill(setProfileVM.selectedMainSkill.value);
                                                  setProfileVM.isToggle.value = true;

                                                  // setProfileVM.fetchSkill(setProfileVM.selectedMainSkill.value);
                                                }
                                              },
                                              child: Text(
                                                  data.category.toString(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          Constant.width * .04,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: setProfileVM
                                                                  .selectedIndex
                                                                  .value ==
                                                              index
                                                          ? AppColors.white
                                                          : AppColors.black)),
                                            ),
                                          ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                    }
                  }),


                  Obx(() {
                    return setProfileVM.isToggle.value
                        ? Padding(
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Skills
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Skills",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),

                          SizedBox(height: Constant.height * .005),

                          /// Sub Skill List
                          setProfileVM.rxRequestStatusSkills.value == Status.ERROR
                              ? SizedBox(
                            height: Constant.height * .1,
                            width: Constant.width * 1,
                            child: Center(
                              child: Text('Unable To Get Skills...', style: TextStyle(fontSize: Constant.width * .05, color: AppColors.redColor)),
                            ),
                          )
                              : setProfileVM.rxRequestStatusSkills.value == Status.LOADING
                              ? SizedBox(
                            height: Constant.height * .1,
                            width: Constant.width * 1,
                            child: Center(
                              child: CircularProgressIndicator(color: AppColors.primaryColor),
                            ),
                          )
                              : setProfileVM.rxSkillModel.value!.data.isNotEmpty
                              ? Container(
                            height: Constant.height * .041 * setProfileVM.rxSkillModel.value!.data.length,
                            width: Constant.width * 1,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(Constant.width * .03)
                            ),
                            child: ListView.builder(
                              itemCount: setProfileVM.rxSkillModel.value!.data.length,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var subSkill = setProfileVM.rxSkillModel.value!.data[index];
                                return SizedBox(
                                  height: Constant.height * .04,
                                  width: Constant.width * 1,
                                  child: Row(
                                    children: [
                                      /// Checkbox
                                      Checkbox(
                                        value: setProfileVM.selectedSubSkills.contains(subSkill.serviceName),
                                        activeColor: AppColors.greenTextColor,
                                        side: BorderSide(color: AppColors.white),
                                        onChanged: (bool? value) {
                                          if (setProfileVM.selectedSubSkills.contains(subSkill.serviceName)) {
                                            setProfileVM.selectedSubSkills.remove(subSkill.serviceName);
                                          } else {
                                            setProfileVM.selectedSubSkills.add(subSkill.serviceName);
                                          }
                                          if (kDebugMode) {
                                            print('selected Sub-Skill : ${setProfileVM.selectedSubSkills}');
                                          }
                                          setProfileVM.isToggle.value = false;
                                          setProfileVM.isToggle.value = true;
                                        },
                                      ),

                                      /// Sub Skill
                                      Text(subSkill.serviceName, style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.white)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                              : SizedBox(
                            height: Constant.height * .1,
                            width: Constant.width * 1,
                            child: Center(
                              child: Text('Skill List Is Empty', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.redColor)),
                            ),
                          ),
                        ],
                      ),
                    )
                        : const SizedBox();
                  },),

                  Obx(() {
                    return SizedBox(
                      height: setProfileVM.isToggle.value
                          ? Constant.height * .02
                          : Constant.height * .05,
                    );
                  }),


                  /// Confirm Button
                  Obx(() {
                    return CommonButton(
                      onTap: () {
                        if (setProfileVM.nameController.value.text.isNotEmpty &&
                            setProfileVM
                                .locationController.value.text.isNotEmpty &&
                            setProfileVM.selectedMainSkill.isNotEmpty &&
                            setProfileVM.selectedSubSkills.isNotEmpty &&
                            setProfileVM.selectedImage.value != null) {
                          setProfileVM.setProfile();
                        } else {
                          if (setProfileVM.nameController.value.text.isEmpty) {
                            Utils.toastMessageTop('Enter Your Name');
                          }

                          if (setProfileVM
                              .locationController.value.text.isEmpty) {
                            Utils.toastMessageTop('Enter Your Location');
                          }

                          if (setProfileVM.selectedMainSkill.isEmpty ||
                              setProfileVM.selectedSubSkills.isEmpty) {
                            Utils.toastMessageTop('Select Your Skills');
                          }

                          if (setProfileVM.selectedImage.value == null) {
                            Utils.toastMessageTop('Select Profile Image');
                          }
                        }
                      },
                      title: 'Submit',
                      height: Constant.height * .06,
                      isLoading: setProfileVM.isLoading.value,
                    );
                  }),

                  Obx(() => SizedBox(height: setProfileVM.isToggle.value ? Constant.height * .07 : 0.0))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
