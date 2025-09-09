import 'package:urban_clap/core/network/network_api_services.dart';
import 'package:urban_clap/res/url/consturl.dart';

class ProfileSetupRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> profileSetupApi(Map<String, dynamic> data){
    final response = _apiServices.putApi(data, ConstUrl.profileSetup);
    return response;
  }

  Future<dynamic> getPresignedApi(Map<String, dynamic> data){
    final response = _apiServices.postApi(data, ConstUrl.profileImagePresigned);
    return response;
  }


}