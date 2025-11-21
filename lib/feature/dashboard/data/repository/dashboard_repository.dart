import 'package:urban_clap_vendor/core/network/network_api_services.dart';
import 'package:urban_clap_vendor/res/url/consturl.dart';

class DashboardRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> acceptAndRejectCountApi(String phone){
    final response = _apiServices.getApi(ConstUrl.acceptOrRejectCount+phone);
    return response;
  }

  Future<dynamic> getAllAppointmentsApi(String phone){
    final response = _apiServices.getApi(ConstUrl.getAppointmentList+phone);
    return response;
  }


  Future<dynamic> acceptOrRejectAppointmentApi(Map<String, dynamic> data){
    final response = _apiServices.putApi(data, ConstUrl.acceptOrRejectAppointment);
    return response;
  }

}