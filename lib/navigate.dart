import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap/feature/authentication/initial_page/laundry_screen.dart';
import 'package:urban_clap/feature/dashboard/presentation/view/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navigate extends StatefulWidget {
  const Navigate({super.key});

  @override
  State<Navigate> createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('TOKEN');
    if (kDebugMode) {
      print('Token is ============> $token');
    }
    if (token != null && token != '') {

      return Get.offAll(() => const DashboardScreen());


    } else {

      // return Get.offAll(() => const LoginScreen());
      return Get.offAll(() => const LaundryScreen());

    }
  }
}
