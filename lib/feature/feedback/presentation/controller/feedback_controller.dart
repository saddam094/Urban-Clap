import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController{

  final reviewComment = TextEditingController().obs;

  RxDouble rating = 0.0.obs;
}