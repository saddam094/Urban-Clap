import 'package:get/get.dart';
import 'package:urban_clap/res/preferences/user_preferences.dart';

class DashboardController extends GetxController{

  final userPreferences = UserPreference();
  final name = 'John Deo'.obs;

  final selectedPage = 'Home'.obs;

  void getEmail()async{
    String? e = await userPreferences.getEmail();
    name.value = e!;

    // String? token = await userPreferences.getToken();
    //
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // name.value = decodedToken['name'];
    // print(decodedToken);

  }

  List<Map<String, dynamic>> appointmentList = [
    {
      'title': 'Electrician Services Package',
      'workId': 'DSAFDS23432',
      'clientName': 'Abhishek Thakur',
      'location': 'Korah Hazaribagh, Jh',
      'preferredTime': '6:30 PM - 10 PM',
      'repair': 'Short circuit In main board'
    },
    {
      'title': 'Electrician Services Package',
      'workId': 'DSAFDS23432',
      'clientName': 'Abhishek Thakur',
      'location': 'Korah Hazaribagh, Jh',
      'preferredTime': '6:30 PM - 10 PM',
      'repair': 'Short circuit In main board'
    },
    {
      'title': 'Electrician Services Package',
      'workId': 'DSAFDS23432',
      'clientName': 'Abhishek Thakur',
      'location': 'Korah Hazaribagh, Jh',
      'preferredTime': '6:30 PM - 10 PM',
      'repair': 'Short circuit In main board'
    }
  ].obs;

}