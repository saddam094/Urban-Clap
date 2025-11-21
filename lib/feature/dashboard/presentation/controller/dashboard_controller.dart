import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/core/response/status.dart';
import 'package:urban_clap_vendor/feature/dashboard/data/model/accept_and_reject_count_model.dart';
import 'package:urban_clap_vendor/feature/dashboard/data/model/appointment_list_model.dart';
import 'package:urban_clap_vendor/feature/dashboard/data/repository/dashboard_repository.dart';
import 'package:urban_clap_vendor/res/preferences/user_preferences.dart';
import 'package:urban_clap_vendor/res/utils/utils.dart';

class DashboardController extends GetxController{

  final _api = DashboardRepository();
  final userPreferences = UserPreference();

  final rxAppointmentListModel = Rxn<AppointmentListModel>();
  final rxRequestStatusAppointmentList = Status.LOADING.obs;

  final rxCountModel = Rxn<AcceptAndRejectCountModel>();
  final rxRequestStatusCount = Status.LOADING.obs;



  RxBool isLoading = false.obs;

  final name = 'John Deo'.obs;

  final selectedPage = 'Home'.obs;

  void getEmail()async{
    String? e = await userPreferences.getEmail();
    name.value = e!;
  }

  void setRxAppointmentListModel(AppointmentListModel value) => rxAppointmentListModel.value = value;
  void setRxRequestStatusAppointmentList(Status value) => rxRequestStatusAppointmentList.value = value;

  void setRxCountModel(AcceptAndRejectCountModel value) => rxCountModel.value = value;
  void setRxRequestStatusCount(Status value) => rxRequestStatusCount.value = value;

  /// Get All Appointment Or Booking List
  void getAppointmentList()async{

    String? phone = await userPreferences.getPhone();

    _api.getAllAppointmentsApi(phone!).then((response) {

      if(kDebugMode){
        print('Response : $response');
      }

      try{
        AppointmentListModel appointmentListModel = AppointmentListModel.fromJson(response['body-json']['body']);
        setRxAppointmentListModel(appointmentListModel);
        setRxRequestStatusAppointmentList(Status.COMPLETED);


        if(kDebugMode){
          print('Appointment List Data Set Successfully');
        }

      }catch(e){
        setRxRequestStatusAppointmentList(Status.ERROR);
        if(kDebugMode){
          print('Error While Set Appointment List Data : $e');
        }
      }

    }).onError((error, stackTrace) {
      setRxRequestStatusAppointmentList(Status.ERROR);
      if(kDebugMode){
        print('Error While Fetching Appointment List Data : $error');
      }
    });

  }

  /// Get Accepted and Rejected Counts
  void getAcceptedAndRejectedCount()async{

    String? phone = await userPreferences.getPhone();

    _api.acceptAndRejectCountApi(phone!).then((response) {

      if(kDebugMode){
        print('Response : $response');
      }

      try{
        AcceptAndRejectCountModel acceptAndRejectCountModel = AcceptAndRejectCountModel.fromJson(response['body-json']['body']);
        setRxCountModel(acceptAndRejectCountModel);
        setRxRequestStatusCount(Status.COMPLETED);


        if(kDebugMode){
          print('Accepted And Rejected Count Set Successfully');
        }

      }catch(e){
        setRxRequestStatusCount(Status.ERROR);
        if(kDebugMode){
          print('Error While Set Accepted And Rejected Count Data : $e');
        }
      }

    }).onError((error, stackTrace) {
      setRxRequestStatusCount(Status.ERROR);
      if(kDebugMode){
        print('Error While Fetching Accepted And Rejected Count Data : $error');
      }
    });

  }

  void acceptOrRejectAppointment(String appointmentId, action)async{

    isLoading.value = true;

    String? phone = await userPreferences.getPhone();

    Map<String, dynamic> data = {
      'id': appointmentId,
      'venderPhone': phone,
      'action': action
    };

    _api.acceptOrRejectAppointmentApi(data).then((response) {

      isLoading.value = false;

      if(kDebugMode){
        print('Response : $response');
      }

      try{

        if(response['body-json']['statusCode'] == 200){

          Utils.toastMessageTop('Appointment ${action == 'reject' ? 'Rejected' : 'Accepted'} Successfully');

        }else if(response['body-json']['statusCode'] == 400 || response['body-json']['statusCode'] == 403){

        }else{
          if (kDebugMode) {
            print(response['body-json']['statusCode']);
          }
        }


        if(kDebugMode){
          print('Appointment List Data Set Successfully');
        }

      }catch(e){
        if(kDebugMode){
          print('Error While Set Appointment List Data : $e');
        }
      }

    }).onError((error, stackTrace) {
      isLoading.value = false;
      if(kDebugMode){
        print('Error While Fetching Appointment List Data : $error');
      }
    });

  }

}