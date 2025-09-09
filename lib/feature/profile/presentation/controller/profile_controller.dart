import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urban_clap/core/response/status.dart';
import 'package:urban_clap/feature/profile/data/model/profile_model.dart';
import 'package:urban_clap/feature/profile/data/repository/profile_repository.dart';
import 'package:urban_clap/res/preferences/user_preferences.dart';
import 'package:urban_clap/res/utils/utils.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController{

  final _api = ProfileRepository();
  final preferences = UserPreference();

  final rxUserProfileModel = Rxn<ProfileModel>();
  final rxRequestStatusUserProfile = Status.LOADING.obs;

  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final locationController = TextEditingController().obs;
  RxString profileImage = ''.obs;

  RxString signedURL = ''.obs;
  RxString key = ''.obs;
  RxString profileImageURL = ''.obs;
  RxString selectedImageName = ''.obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  RxBool loading = false.obs;

  void setRxUserProfileModel(ProfileModel value) => rxUserProfileModel.value = value;
  void setRxRequestStatusUserProfile(Status value) => rxRequestStatusUserProfile.value = value;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      selectedImageName.value = pickedFile.name.toString();
    }
  }

  void venderProfile()async{

    // String? phone = await preferences.getEmail();

    _api.userProfileApi('6202548771').then((response) {

      if(kDebugMode){
        print('Response : $response');
      }

      try{

        ProfileModel profileModel = ProfileModel.fromJson(response['body']);
        setRxUserProfileModel(profileModel);

        var data = rxUserProfileModel.value!;

        nameController.value.text = data.name;
        locationController.value.text = data.location;
        phoneController.value.text = data.phone;
        profileImage.value = data.profileImage;

        setRxRequestStatusUserProfile(Status.COMPLETED);

        if(kDebugMode){
          print('User Profile Data Set Successfully');
        }

      }catch(e){
        setRxRequestStatusUserProfile(Status.ERROR);
        if(kDebugMode){
          print('Error While Set User Profile Data : $e');
        }
      }

    }).onError((error, stackTrace) {
      setRxRequestStatusUserProfile(Status.ERROR);
      if(kDebugMode){
        print('Error While Fetching User Profile Data : $error');
      }
    });

  }

  void editProfile() async {
    loading.value = true;

    if (selectedImage.value != null) {
      await uploadImageToS3();

      if (profileImage.value.isEmpty) {
        loading.value = false;
        return;
      }
    }

    Map<String, dynamic> data = {
      'phone': phoneController.value.text,
      'name': nameController.value.text,
      'location': locationController.value.text,
      'profile_image': profileImage.value, // this will have new uploaded URL/key
    };

    _api.editProfileApi(data).then((response) {
      loading.value = false;

      if (kDebugMode) {
        print('Response : $response');
      }

      try {
        if (response['body-json']['statusCode'] == 200) {
          Utils.toastMessageTop('Profile Updated Successfully');
        } else if (response['body-json']['statusCode'] == 400 || response['body-json']['statusCode'] == 401) {
          Utils.toastMessageTop(response['body-json']['body']);
        } else {
          if (kDebugMode) {
            print("Unexpected response: $response");
          }
        }
      } catch (e) {
        setRxRequestStatusUserProfile(Status.ERROR);
        if (kDebugMode) {
          print('Error While Set User Profile Data : $e');
        }
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      setRxRequestStatusUserProfile(Status.ERROR);
      if (kDebugMode) {
        print('Error While Fetching User Profile Data : $error');
      }
    });
  }

  Future<void> getPresigned() async {
    Map<String, dynamic> data = {"fileName": selectedImageName.value};

    _api.getPresignedApi(data).then((response) {
      if (kDebugMode) {
        print('Response : $response');
      }

      try {
        if (response['body-json']['statusCode'] == 200) {
          signedURL.value = response['body-json']['body']['uploadDetails'][0]['signedUrl'];
          key.value = response['body-json']['body']['uploadDetails'][0]['key'];

          if (kDebugMode) {
            print('Signed URL Fetch Successfully');
          }
        } else {
          if (kDebugMode) {
            print("Presigned failed with status: ${response['statusCode']}");
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print("Error in getPresigned(): $e");
        }
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      if (kDebugMode) {
        print("Error fetching presigned: $error");
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
        profileImage.value = key.value;
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