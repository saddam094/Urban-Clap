import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentMethodController extends GetxController{

  final fullNameController = TextEditingController().obs;
  final accountNumberController = TextEditingController().obs;
  final reAccountNumberController = TextEditingController().obs;
  final ifscCodeController = TextEditingController().obs;
  final bankNameController = TextEditingController().obs;


  final upiController = TextEditingController().obs;
}