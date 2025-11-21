import 'package:get/get.dart';

class TestLocationDetailsController extends GetxController{


  RxString name = 'saddam'.obs;

  Map<String, RxString> detail = {
    'testCenter': 'Tech Park Building, Noida'.obs,
    'date': '10 Sep 2025'.obs,
    'time': '11 AM - 12 AM'.obs,
    'status': 'Pending'.obs,
    'message': '(We`ll notify you once it`s verified by our team)'.obs
  };

}