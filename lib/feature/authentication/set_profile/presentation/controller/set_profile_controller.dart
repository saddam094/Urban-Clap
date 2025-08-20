import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetProfileController extends GetxController {
  final nameController = TextEditingController().obs;
  final locationController = TextEditingController().obs;
  final selectedSkills = <String>[].obs;

  List<String> allSkills = ['Plumber', 'Electrician', 'Cleaning', 'Ac Repair'];

  void toggleSkill(String skill) {
    if (selectedSkills.contains(skill)) {
      selectedSkills.remove(skill);
    } else {
      selectedSkills.add(skill);
    }
  }
}
