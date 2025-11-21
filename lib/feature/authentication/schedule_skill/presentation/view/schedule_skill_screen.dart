import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/feature/authentication/schedule_skill/presentation/controller/schedule_skill_controller.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/common/common_button.dart';
import 'package:urban_clap_vendor/res/common/custom_app_bar.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';
import 'package:urban_clap_vendor/res/utils/utils.dart';

class ScheduleSkillScreen extends StatefulWidget {
  final bool isReSchedule;
  const ScheduleSkillScreen({super.key, this.isReSchedule = false});

  @override
  State<ScheduleSkillScreen> createState() => _ScheduleSkillScreenState();
}

class _ScheduleSkillScreenState extends State<ScheduleSkillScreen> {

  final skillTestVM = Get.put(ScheduleSkillController());

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      skillTestVM.selectedDate.value =
      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      skillTestVM.isReadyToSelectDate.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// Heading
          CustomAppBar(title: '', isBack: widget.isReSchedule, onBack: () => Navigator.pop(context)),

          /// Main Container
          Obx(() {
            return Container(
              height: Constant.height * .87,
              width: Constant.width * 1,
              padding: EdgeInsets.only(
                left: Constant.width * .03,
                right: Constant.width * .03,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title Text
                  Text(widget.isReSchedule ? 'Re-Schedule Skill Test' : 'Schedule Skill Test', style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black)),

                  SizedBox(height: Constant.height * .01),

                  InkWell(
                    onTap: _pickDate,
                    child: Container(
                      height: Constant.height * .055,
                      width: Constant.width * 1,
                      padding: EdgeInsets.symmetric(
                        horizontal: Constant.width * .03,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Constant.width * .04),
                        border:
                        Border.all(color: AppColors.greyTextLightColor),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.date_range,
                              size: Constant.width * .06,
                              color: AppColors.primaryColor),
                          SizedBox(width: Constant.width * .02),
                          Obx(() {
                            return Text(
                              skillTestVM.selectedDate.value.isEmpty
                                  ? 'Select Date'
                                  : 'Date: ${skillTestVM.selectedDate.value}',
                              style: TextStyle(
                                fontSize: Constant.width * .035,
                                color: skillTestVM.selectedDate.value.isEmpty
                                    ? AppColors.greyTextLightColor
                                    : AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: Constant.height * .01),

                  Obx(() {
                    return skillTestVM.isReadyToSelectDate.value ? SizedBox(
                      height: Constant.height * .22,
                      width: Constant.width * 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text('Choose Time', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.black)),

                          SizedBox(height: Constant.height * .003),

                          /// Choose Time
                          Container(
                            height: Constant.height * .06,
                            padding: EdgeInsets.only(
                              left: Constant.width * .015,
                              right: Constant.width * .015,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightColor1,
                              borderRadius: BorderRadius.circular(Constant.width * .08),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                tabButton("Morning", 0),
                                tabButton("Afternoon", 1),
                                tabButton("Evening", 2),
                              ],
                            ),
                          ),

                          SizedBox(height: Constant.width * .03),

                          Container(
                            height: Constant.height * .11,
                            width: Constant.width * 1,
                            padding: EdgeInsets.only(
                              left: Constant.width * .03,
                              right: Constant.width * .03,
                              top: Constant.height * .01,
                              bottom: Constant.height * .01,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightColor1,
                              borderRadius: BorderRadius.circular(Constant.width * .02),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Heading
                                Obx(() {
                                  String title = skillTestVM.selectedTab.value == 0
                                      ? "Morning Schedule"
                                      : skillTestVM.selectedTab.value == 1
                                      ? "Afternoon Schedule"
                                      : "Evening Schedule";
                                  return Text(
                                    title,
                                    style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold),
                                  );
                                }),

                                SizedBox(height: Constant.width * .02),

                                // Slots
                                Obx(() {
                                  var slotList =
                                      skillTestVM.slots[skillTestVM.selectedTab.value] ?? [];
                                  return Wrap(
                                    spacing: Constant.width * .02,
                                    runSpacing: Constant.width * .01,
                                    children: slotList.map((slot) {
                                      bool isSelected = skillTestVM.selectedSlot.value == slot;
                                      return GestureDetector(
                                        onTap: () {
                                          skillTestVM.selectedSlot.value = slot;
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: Constant.width * .02, vertical: Constant.height * .01),
                                          decoration: BoxDecoration(
                                            color: isSelected ? AppColors.primaryColor : AppColors.white,
                                            borderRadius: BorderRadius.circular(Constant.width * .02),
                                          ),
                                          child: Text(
                                            slot,
                                            style: TextStyle(
                                              color: isSelected ? Colors.white : Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ) : SizedBox();
                  },),

                  Spacer(),

                  /// Submit Final Review ---> Button
                  CommonButton(
                    onTap: () {
                      if(skillTestVM.selectedSlot.value.isNotEmpty){
                        if(widget.isReSchedule){
                          skillTestVM.reScheduleSkillTest();
                        } else {
                          skillTestVM.scheduleSkillTest();
                        }
                      } else {
                        Utils.toastMessageTop('Select a Time Slot');
                      }
                    },
                    title: 'Submit',
                    height: Constant.height * .055,
                    width: Constant.width * 1,
                    isLoading: skillTestVM.isLoading.value,
                  ),

                  SizedBox(height: Constant.height * .08),
                ],
              ),
            );
          },)
        ],
      ),
    );
  }

  Widget tabButton(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => skillTestVM.selectedTab.value = index,
        child: Obx(() {
          bool isActive = skillTestVM.selectedTab.value == index;
          return Container(
            height: Constant.height * .05,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isActive ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }),
      ),
    );
  }

}
