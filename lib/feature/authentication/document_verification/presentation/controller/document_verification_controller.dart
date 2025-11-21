import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urban_clap_vendor/feature/authentication/document_verification/data/repository/document_verification_repository.dart';
import 'package:urban_clap_vendor/feature/authentication/schedule_skill/presentation/view/schedule_skill_screen.dart';
import 'package:urban_clap_vendor/res/preferences/user_preferences.dart';
import 'package:urban_clap_vendor/res/utils/utils.dart';
import 'package:http/http.dart' as http;

class DocumentVerificationController extends GetxController{

  final _api = DocumentVerificationRepository();
  final userPreferences = UserPreference();

  RxBool isLoading = false.obs;

  /// Picked image files
  Rx<File?> idProofImage = Rx<File?>(null);
  Rx<File?> certificateImage = Rx<File?>(null);

  RxString idProofImageUrl = ''.obs;
  RxString certificateImageUrl = ''.obs;
  RxString idProofSignedUrl = ''.obs;
  RxString certificateSignedUrl = ''.obs;
  RxString idProofImageName = ''.obs;
  RxString certificateImageName = ''.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage({required bool isIdProof}) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isIdProof) {
        idProofImage.value = File(pickedFile.path);
        idProofImageName.value = pickedFile.name.toString();
      } else {
        certificateImage.value = File(pickedFile.path);
        certificateImageName.value = pickedFile.name.toString();
      }
    }
  }

  /// Upload Documents
  void uploadDocuments() async{

    isLoading.value = true;

    await uploadImageToS3(idProofImage.value!, true);

    await uploadImageToS3(certificateImage.value!, false);

    if(idProofImageUrl.value == '' || idProofSignedUrl.value == '' || certificateImageUrl.value == '' || certificateSignedUrl.value == ''){
      isLoading.value = false;
      return;
    }

    String? phone = await userPreferences.getPhone();

    Map<String, dynamic> data = {
      "phone": phone,
      "id_proof": idProofImageUrl.value,
      "skill_certificate": certificateImageUrl.value
    };

    _api.uploadDocumentsApi(data).then((response) {

      isLoading.value = false;

      if(kDebugMode){
        print('Response : $response');
      }

      try{

        if(response['body-json']['statusCode'] == 200){

          Utils.toastMessageTop('Document Uploaded Successfully');
          Get.offAll(() => ScheduleSkillScreen());

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

  Future<void> uploadImageToS3(File file, bool isId) async {

    String? preSignedUrl = await getPresigned(isId ? idProofImageName.value : certificateImageName.value);

    if(preSignedUrl == null){
      if (kDebugMode) {
        print('signed url not fetched');
      }
      return;
    }

    if(isId){
      idProofSignedUrl.value = preSignedUrl;
    }else {
      certificateSignedUrl.value = preSignedUrl;
    }

    try {
      final request = http.Request('PUT', Uri.parse(isId ? idProofSignedUrl.value : certificateSignedUrl.value));

      request.bodyBytes = await file.readAsBytes();

      final response = await request.send();

      if (kDebugMode) {
        print('S3 Response = ${response.statusCode}');
      }

      if (response.statusCode == 200) {

        if(isId){
          idProofImageUrl.value = idProofSignedUrl.split('?').first;
        }else {
          certificateImageUrl.value = certificateSignedUrl.split('?').first;
        }

        if (kDebugMode) {
          if(isId){
            print('ID Proof IMAGE URL : ${idProofImageUrl.value}');
            print("ID Proof Image Uploaded Successfully!  ==========================================");
          } else {
            print('Certificate IMAGE URL : ${certificateImageUrl.value}');
            print("Certificate Image Uploaded Successfully!  ==========================================");
          }
        }
      } else {
        if (kDebugMode) {
          if(isId){
            print("Failed to upload ID Proof Image : ${response.statusCode}");
            print('Response: ${response.reasonPhrase}');
          }else{
            print("Failed to upload Certificate Image : ${response.statusCode}");
            print('Response: ${response.reasonPhrase}');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        if(isId){
          print("Error While uploading ID Proof Image : $e");
        } else{
          print("Error While uploading Certificate Image : $e");
        }
      }
    }
  }

}