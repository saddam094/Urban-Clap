import 'package:urban_clap_vendor/core/network/network_api_services.dart';
import 'package:urban_clap_vendor/res/url/consturl.dart';

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

  Future<dynamic> fetchCategoryApi(){
    final response = _apiServices.getApi(ConstUrl.allCategory);
    return response;
  }

  Future<dynamic> fetchSkillApi(String category){
    final response = _apiServices.getApi('${ConstUrl.getParticularCategorySkill}?category=$category');
    return response;
  }

}