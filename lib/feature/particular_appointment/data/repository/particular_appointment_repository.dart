import 'package:urban_clap_vendor/core/network/network_api_services.dart';
import 'package:urban_clap_vendor/res/url/consturl.dart';

class ParticularAppointmentRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> particularAppointmentApi(String appointmentId){
    final response = _apiServices.getApi(ConstUrl.particularAppointment+appointmentId);
    return response;
  }

  Future<dynamic> sendStartServiceOtpApi(Map<String, dynamic> data){
    final response = _apiServices.postApi(data, ConstUrl.sendStartServiceOTP);
    return response;
  }

  Future<dynamic> resendStartServiceOtpApi(Map<String, dynamic> data){
    final response = _apiServices.putApi(data, ConstUrl.resendStartServiceOTP);
    return response;
  }

  Future<dynamic> verifyStartServiceOtpApi(Map<String, dynamic> data){
    final response = _apiServices.putApi(data, ConstUrl.verifyStartServiceOTP);
    return response;
  }

}