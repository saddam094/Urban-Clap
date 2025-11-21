import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urban_clap_vendor/core/response/status.dart';
import 'package:urban_clap_vendor/feature/authentication/document_verification/presentation/view/document_verification_screen.dart';
import 'package:urban_clap_vendor/feature/authentication/set_profile/data/model/category_model.dart';
import 'package:urban_clap_vendor/feature/authentication/set_profile/data/model/skills_model.dart';
import 'package:urban_clap_vendor/feature/authentication/set_profile/data/repository/profile_setup_repository.dart';
import 'package:urban_clap_vendor/res/preferences/user_preferences.dart';
import 'package:urban_clap_vendor/res/utils/utils.dart';
import 'package:http/http.dart' as http;

class SetProfileController extends GetxController {

  final _api = ProfileSetupRepository();
  final userPreferences = UserPreference();

  final rxCategoryModel = Rxn<CategoryModel>();
  final rxRequestStatusCategory = Status.LOADING.obs;

  final rxSkillModel = Rxn<SkillsModel>();
  final rxRequestStatusSkills = Status.LOADING.obs;

  final nameController = TextEditingController().obs;
  final locationController = TextEditingController().obs;
  final selectedSkills = <String>[].obs;
  RxString signedURL = ''.obs;
  RxString key = ''.obs;
  RxString profileImageURL = ''.obs;
  RxString selectedImageName = ''.obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  RxDouble longitude = 0.0.obs;
  RxDouble latitude = 0.0.obs;

  final isLoading = false.obs;

  final isToggle = false.obs;
  RxInt selectedIndex = 10000.obs;

  final selectedMainSkill = ''.obs;
  final selectedSubSkills = <String>[].obs;

  void setRxCategoryModel(CategoryModel value) => rxCategoryModel.value = value;
  void setRxRequestStatusCategory(Status value) => rxRequestStatusCategory.value = value;

  void setRxSkillModel(SkillsModel value) => rxSkillModel.value = value;
  void setRxRequestStatusSkill(Status value) => rxRequestStatusSkills.value = value;

  void selectMainSkill(String skill) {
    if (selectedMainSkill.value == skill) {
      // Unselect if already selected
      selectedMainSkill.value = '';
      selectedSubSkills.clear();
    } else {
      selectedMainSkill.value = skill;
      selectedSubSkills.clear();
    }
  }

  void toggleSubSkill(String subSkill) {
    if (selectedSubSkills.contains(subSkill)) {
      selectedSubSkills.remove(subSkill);
    } else {
      selectedSubSkills.add(subSkill);
    }
  }


  void toggleSkill(String skill) {
    if (selectedSkills.contains(skill)) {
      selectedSkills.remove(skill);
    } else {
      if(selectedSkills.isEmpty){
        selectedSkills.add(skill);
      }
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      selectedImageName.value = pickedFile.name.toString();
    }
  }

  /// Set Profile Details
  void setProfile() async{

    isLoading.value = true;

    await uploadImageToS3(selectedImage.value!);

    if(profileImageURL.value == '' || signedURL.value == ''){
      isLoading.value = false;
      return;
    }

    String? phone = await userPreferences.getPhone();

    Map<String, dynamic> data = {
      "phone": phone,
      "name": nameController.value.text,
      "location": locationController.value.text,
      "landmark": {
        "longitude": longitude.value,
        "latitude": latitude.value
      },
      "category": [selectedMainSkill.value],
      "skills": selectedSubSkills,
      "profile_image": profileImageURL.value
    };

    _api.profileSetupApi(data).then((response) {

      isLoading.value = false;

      if(kDebugMode){
        print('Response : $response');
      }

      try{
        
        if(response['body-json']['statusCode'] == 200){

          Utils.toastMessageTop('Profile Updated Successfully');
          Get.offAll(() => DocumentVerificationScreen());

        } else if(response['body-json']['statusCode'] == 400 || response['body-json']['statusCode'] == 401){
          Utils.toastMessageTop('400 || 401');
        } else{
          if(kDebugMode){
            print(response.toString());
          }
        }
        
      } catch(e){
        
        if(kDebugMode){
          print(e.toString());
        }
      }
      
    }).onError((error, stackTrace) {
      isLoading.value = false;
      if(kDebugMode){
        print(error.toString());
      }
    });

  }

  /// Fetch Category
  void fetchCategory() async{

    _api.fetchCategoryApi().then((response) {

      if(kDebugMode){
        print('Response : $response');
      }

      try{

        CategoryModel categoryModel = CategoryModel.fromJson(response['body-json']['body']);
        setRxCategoryModel(categoryModel);
        setRxRequestStatusCategory(Status.COMPLETED);

        if(kDebugMode){
          print('Category Data Fetched Successfully');
        }

      } catch(e){

        setRxRequestStatusCategory(Status.ERROR);
        if(kDebugMode){
          print('Error While Set Category Data : $e');
        }
      }

    }).onError((error, stackTrace) {
      setRxRequestStatusCategory(Status.ERROR);
      if(kDebugMode){
        print('Error While Fetching Category Data : $error');
      }
    });

  }

  /// Fetch Skill
  void fetchSkill(String category) async{

    setRxRequestStatusSkill(Status.LOADING);

    _api.fetchSkillApi(category).then((response) {

      if(kDebugMode){
        print('Response : $response');
      }

      try{

        SkillsModel skillsModel = SkillsModel.fromJson(response['body-json']['body']);
        setRxSkillModel(skillsModel);
        setRxRequestStatusSkill(Status.COMPLETED);

        if(kDebugMode){
          print('Skill Data Set Successfully');
        }

      } catch(e){

        setRxRequestStatusSkill(Status.ERROR);
        if(kDebugMode){
          print('Error While Set Skill Data : $e');
        }
      }

    }).onError((error, stackTrace) {
      setRxRequestStatusSkill(Status.ERROR);
      if(kDebugMode){
        print('Error While Fetching Skill Data : $error');
      }
    });

  }

  Future<String?> getPresigned(String fileName) async {
    Map<String, dynamic> data = {
      "fileName": fileName
    };

    final response = await _api.getPresignedApi(data);

    if (kDebugMode) {
      print('Response : $response');
    }

    try {
      if (response['body-json']['statusCode'] == 200) {
        if (kDebugMode) {
          print('Signed URL Fetch Successfully');
        }
        return response['body-json']['body']['uploadDetails'][0]['signedUrl'];
      } else {
        if (kDebugMode) {
          print("Failed: ${response['body-json']['statusCode']}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return null;
  }

  Future<void> uploadImageToS3(File file) async {

    String? preSignedUrl = await getPresigned(selectedImageName.value);

    if(preSignedUrl == null){
      if (kDebugMode) {
        print('signed url not fetched');
      }
      return;
    }

    signedURL.value = preSignedUrl;

    try {
      final request = http.Request('PUT', Uri.parse(signedURL.value));

      request.bodyBytes = await file.readAsBytes();

      final response = await request.send();

      if (kDebugMode) {
        print('S3 Response = ${response.statusCode}');
      }

      if (response.statusCode == 200) {

        profileImageURL.value = signedURL.split('?').first;

        if (kDebugMode) {
          print('IMAGE URL : ${profileImageURL.value}');
          print("Profile Image Uploaded Successfully!  ==========================================");
        }
      } else {
        if (kDebugMode) {
          print("Failed to upload Profile Image : ${response.statusCode}");
          print('Response: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error uploading Profile Image : $e");
      }
    }
  }

}
