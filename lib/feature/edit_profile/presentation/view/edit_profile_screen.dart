import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap/core/response/status.dart';
import 'package:urban_clap/feature/profile/presentation/controller/profile_controller.dart';
import 'package:urban_clap/res/color/app_color.dart';
import 'package:urban_clap/res/common/common_button.dart';
import 'package:urban_clap/res/common/common_text_field.dart';
import 'package:urban_clap/res/common/custom_app_bar.dart';
import 'package:urban_clap/res/constant/constant_data.dart';
import 'package:urban_clap/res/utils/utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final editProfileVM = Get.put(ProfileController());

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editProfileVM.venderProfile();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// Heading Container
          CustomAppBar(title: 'Edit Profile', isBack: true, onBack: () => Navigator.pop(context)),

          Obx(() {
            switch (editProfileVM.rxRequestStatusUserProfile.value) {
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
                return Container(
                  height: Constant.height * .87,
                  width: Constant.width * 1,
                  padding: EdgeInsets.only(
                    left: Constant.width * .03,
                    right: Constant.width * .03,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [

                          Obx(() {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * .5),
                                  child: editProfileVM.selectedImage.value != null
                                      ? Image.file(
                                    editProfileVM.selectedImage.value!,
                                    height: MediaQuery.of(context).size.height * .2,
                                    width: MediaQuery.of(context).size.width * .45,
                                    fit: BoxFit.cover,
                                  )
                                      : Image.network(
                                    editProfileVM.profileImage.value,
                                    height: MediaQuery.of(context).size.height * .2,
                                    width: MediaQuery.of(context).size.width * .45,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: MediaQuery.of(context).size.height * .2,
                                        width: MediaQuery.of(context).size.width * .45,
                                        color: Colors.grey[300],
                                        child: Center(
                                          child: Icon(Icons.person, size: MediaQuery.of(context).size.width * .25),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                // Edit button at bottom-right
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: editProfileVM.pickImage,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 20),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },),

                          SizedBox(height: Constant.height * .01),

                          Row(
                            children: [
                              Text('Name', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black)),
                            ],
                          ),

                          /// Name ---> It will be TextField
                          CommonTextField(
                            obSecure: false,
                            controller: editProfileVM.nameController.value,
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                fontSize: Constant.width * .04,
                                color: AppColors.greyTextDarkColor),
                            icon: Icon(Icons.person_2_outlined,
                                color: AppColors.greyTextDarkColor),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if(value!.isEmpty){
                                Utils.toastMessageTop('Enter Name');
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: Constant.height * .01),

                          Row(
                            children: [
                              Text('Location', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black)),
                            ],
                          ),

                          /// About ---> It will be TextField
                          CommonTextField(
                            obSecure: false,
                            controller: editProfileVM.locationController.value,
                            hintText: 'Location',
                            hintStyle: TextStyle(
                                fontSize: Constant.width * .04,
                                color: AppColors.greyTextDarkColor),
                            icon: Icon(Icons.person_2_outlined,
                                color: AppColors.greyTextDarkColor),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if(value!.isEmpty){
                                Utils.toastMessageTop('Enter Location');
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: Constant.height * .04),

                          /// Create Account
                          Obx(() {
                            return CommonButton(
                              title: 'Update Profile',
                              onTap: () {
                                // function for Create Account
                                editProfileVM.editProfile();
                              },
                              height: Constant.height * .06,
                              isLoading: editProfileVM.loading.value,
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                );
            }
          }),
        ],
      ),

      
    );
  }
}