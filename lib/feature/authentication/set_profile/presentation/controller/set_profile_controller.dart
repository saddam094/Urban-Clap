import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urban_clap/feature/authentication/set_profile/data/repository/profile_setup_repository.dart';
import 'package:urban_clap/feature/dashboard/presentation/view/dashboard_screen.dart';
import 'package:urban_clap/res/preferences/user_preferences.dart';
import 'package:urban_clap/res/utils/utils.dart';
import 'package:http/http.dart' as http;

class SetProfileController extends GetxController {

  final _api = ProfileSetupRepository();
  final userPreferences = UserPreference();

  final nameController = TextEditingController().obs;
  final locationController = TextEditingController().obs;
  final selectedSkills = <String>[].obs;
  RxString signedURL = ''.obs;
  RxString key = ''.obs;
  RxString profileImageURL = ''.obs;
  RxString selectedImageName = ''.obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  final isLoading = false.obs;

  List<String> allSkills = ['Plumber', 'Electrician', 'Cleaning', 'Ac Repair'];

  void toggleSkill(String skill) {
    if (selectedSkills.contains(skill)) {
      selectedSkills.remove(skill);
    } else {
      selectedSkills.add(skill);
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

  void setProfile() async{

    isLoading.value = true;

    await uploadImageToS3();

    if(profileImageURL.value == '' || signedURL.value == ''){
      isLoading.value = false;
      return;
    }

    Map<String, dynamic> data = {
      "phone": "6202548771",
      "name": nameController.value.text,
      "location": locationController.value.text,
      "skills": selectedSkills,
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
          Get.offAll(() => DashboardScreen());

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

  Future<void> getPresigned() async{

    Map<String, dynamic> data = {
      "fileName": selectedImageName.value
    };

    _api.getPresignedApi(data).then((response) {

      if(kDebugMode){
        print('Response : $response');
      }

      try{

        if(response['body-json']['statusCode'] == 200){

          signedURL.value = response['body-json']['body']['uploadDetails'][0]['signedUrl'];
          key.value = response['body-json']['body']['uploadDetails'][0]['key'];

          if(kDebugMode){
            print('Signed URL Fetch Successfully');
          }

        } else if(response['body-json']['statusCode'] == 400 || response['body-json']['statusCode'] == 401){
          if(kDebugMode){
            print('statusCode : 400 || 401');
          }
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

  Future<void> uploadImageToS3() async {

    await getPresigned();

    if(signedURL.value == '' || key.value == ''){
      if (kDebugMode) {
        print('signed url not fetched');
      }
      return;
    }

    try {
      final request = http.Request('PUT', Uri.parse(signedURL.value));
      request.bodyBytes =
      await selectedImage.value!.readAsBytes();

      final response = await request.send();

      final responseStatusCode = response.statusCode;

      if (kDebugMode) {
        print('StatusCode = $responseStatusCode');
      }

      if (response.statusCode == 200) {
        profileImageURL.value = key.value;
        if (kDebugMode) {
          print("Profile Image Uploaded Successfully!");
        }
      } else {
        if (kDebugMode) {
          print("Failed to upload Profile Image : ${response.statusCode}");
        }
        if (kDebugMode) {
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
