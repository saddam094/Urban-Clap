import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/feature/authentication/schedule_skill/data/repository/schedule_skill_repository.dart';
import 'package:urban_clap_vendor/feature/dashboard/presentation/view/dashboard_screen.dart';
import 'package:urban_clap_vendor/res/preferences/user_preferences.dart';
import 'package:urban_clap_vendor/res/utils/utils.dart';

class ScheduleSkillController extends GetxController{

  final _api = ScheduleSkillRepository();
  final userPreferences = UserPreference();

  RxBool isReadyToSelectDate = false.obs;

  RxString selectedDate = ''.obs;

  RxInt selectedTab = 0.obs;
  RxString selectedSlot = ''.obs;

  RxBool isLoading = false.obs;

  final slots = {
    0: ["9 AM - 10 AM", "10 AM - 11 AM", "11 AM - 12 PM"],
    1: ["12 PM - 1 PM", "2 PM - 3 PM", "3 PM - 4 PM"],
    2: ["4 PM - 5 PM", "5 PM - 6 PM", "6 PM - 7 PM"],
  };




  /// Schedule Skill Test
  void scheduleSkillTest() async{

    isLoading.value = true;

    String? phone = await userPreferences.getPhone();

    Map<String, dynamic> data = {
      "phone": phone,
      "date": selectedDate.value,
      "shift": selectedTab.value == 0 ? 'morning' : selectedTab.value == 1 ? 'afternoon' : 'evening',
      "time": selectedSlot.value
    };

    _api.scheduleTestApi(data).then((response) {

      isLoading.value = false;

      if(kDebugMode){
        print('Response : $response');
      }

      try{

        if(response['body-json']['statusCode'] == 200){

          Utils.toastMessageTop('Skill Test Scheduled Successfully');
          Get.offAll(() => DashboardScreen());

        } else if(response['body-json']['statusCode'] == 400 || response['body-json']['statusCode'] == 401){
          Utils.toastMessageTop(response['body-json']['body']);
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

  /// ReSchedule Skill Test
  void reScheduleSkillTest() async{

    isLoading.value = true;

    String? phone = await userPreferences.getPhone();

    Map<String, dynamic> data = {
      "phone": phone,
      "date": selectedDate.value,
      "shift": selectedTab.value == 0 ? 'morning' : selectedTab.value == 1 ? 'afternoon' : 'evening',
      "time": selectedSlot.value
    };

    _api.reScheduleSkillTestApi(data).then((response) {

      isLoading.value = false;

      if(kDebugMode){
        print('Response : $response');
      }

      try{

        if(response['body-json']['statusCode'] == 200){

          Utils.toastMessageTop('Skill Test Re-Scheduled Successfully');
          Get.offAll(() => DashboardScreen());

        } else if(response['body-json']['statusCode'] == 400 || response['body-json']['statusCode'] == 404){
          Utils.toastMessageTop(response['body-json']['body']);
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
}