import 'package:urban_clap/core/network/network_api_services.dart';
import 'package:urban_clap/res/url/consturl.dart';

class LoginRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(Map<String, dynamic> data){

    final response = _apiServices.postApi(data, ConstUrl.login);
    return response;

  }

  Future<dynamic> otpVerificationApi(Map<String, dynamic> data){

    final response = _apiServices.putApi(data, ConstUrl.otpVerification);
    return response;

  }


}