import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urban_clap/feature/authentication/document_verification/presentation/view/document_verification_screen.dart';
import 'package:urban_clap/feature/authentication/set_profile/data/repository/profile_setup_repository.dart';
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
