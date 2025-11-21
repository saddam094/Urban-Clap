import 'package:urban_clap_vendor/core/network/network_api_services.dart';
import 'package:urban_clap_vendor/res/url/consturl.dart';

class DocumentVerificationRepository {

  final _apiServices = NetworkApiServices();

  Future<dynamic> uploadDocumentsApi(Map<String, dynamic> data){
    final response = _apiServices.putApi(data, ConstUrl.uploadDocuments);
    return response;
  }

  Future<dynamic> getPresignedApi(Map<String, dynamic> data){
    final response = _apiServices.postApi(data, ConstUrl.documentsImagePresigned);
    return response;
  }
}