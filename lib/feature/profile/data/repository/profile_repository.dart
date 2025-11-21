import 'package:urban_clap_vendor/core/network/network_api_services.dart';
import 'package:urban_clap_vendor/res/url/consturl.dart';

class ProfileRepository{

  final _apiServices = NetworkApiServices();

  Future<dynamic> vendorProfileApi(String phone){

    final response = _apiServices.getApi(ConstUrl.profile+phone);
    return response;

  }

  Future<dynamic> vendorDocumentApi(String phone){

    final response = _apiServices.getApi(ConstUrl.document+phone);
    return response;

  }

  Future<dynamic> editProfileApi(Map<String, dynamic> data){

    final response = _apiServices.putApi(data, ConstUrl.editProfile);
    return response;

  }

  Future<dynamic> getPresignedApi(Map<String, dynamic> data){

    final response = _apiServices.postApi(data, ConstUrl.profileImagePresigned);
    return response;

  }

  Future<dynamic> cancelSkillTestApi(Map<String, dynamic> data){

    final response = _apiServices.putApi(data, ConstUrl.cancelSkillTestAppointment);
    return response;

  }
}