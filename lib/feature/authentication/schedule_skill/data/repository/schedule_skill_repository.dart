import 'package:urban_clap_vendor/core/network/network_api_services.dart';
import 'package:urban_clap_vendor/res/url/consturl.dart';

class ScheduleSkillRepository {

  final _apiServices = NetworkApiServices();

  Future<dynamic> scheduleTestApi(Map<String, dynamic> data){
    final response = _apiServices.postApi(data, ConstUrl.scheduleSkillTestAppointment);
    return response;
  }

  Future<dynamic> reScheduleSkillTestApi(Map<String, dynamic> data){
    final response = _apiServices.putApi(data, ConstUrl.reScheduleSkillTestAppointment);
    return response;
  }

}