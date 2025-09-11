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

    String? phone = await preferences.getPhone();

    _api.userProfileApi(phone!).then((response) {

      if(kDebugMode){
        print('Response : $response');
      }

      try{

        ProfileModel profileModel = ProfileModel.fromJson(response['body']);
        setRxUserProfileModel(profileModel);

        var data = rxUserProfileModel.value!;

        nameController.value.text = data.name;
        locationController.value.text = data.location;
        // phoneController.value.text = data.phone;
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
      await uploadImageToS3(selectedImage.value!);

      if (profileImage.value.isEmpty) {
        loading.value = false;
        return;
      }
    }

    String? phone = await preferences.getPhone();

    Map<String, dynamic> data = {
      'phone': phone,
      'name': nameController.value.text,
      'location': locationController.value.text,
      'profile_image': profileImage.value,
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

      final responseStatusCode = response.statusCode;

      if (kDebugMode) {
        print('StatusCode = $responseStatusCode');
      }

      if (response.statusCode == 200) {

        profileImageURL.value = signedURL.split('?').first;
        profileImage.value = signedURL.split('?').first;

        if (kDebugMode) {
          print('IMAGE URL : ${profileImageURL.value}');
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