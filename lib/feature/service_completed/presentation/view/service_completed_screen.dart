import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap/feature/feedback/presentation/view/feedback_screen.dart';
import 'package:urban_clap/res/color/app_color.dart';
import 'package:urban_clap/res/common/common_button.dart';
import 'package:urban_clap/res/common/custom_app_bar.dart';
import 'package:urban_clap/res/constant/constant_data.dart';

class ServiceCompletedScreen extends StatefulWidget {
  const ServiceCompletedScreen({super.key});

  @override
  State<ServiceCompletedScreen> createState() => _ServiceCompletedScreenState();
}

class _ServiceCompletedScreenState extends State<ServiceCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// Heading Container
          CustomAppBar(title: ''),

          /// Main Content
          Container(
            height: Constant.height * .87,
            width: Constant.width * 1,
            padding: EdgeInsets.only(
              left: Constant.width * .03,
              right: Constant.width * .03,
            ),
            child: Column(
              children: [

                SizedBox(height: Constant.height * .05),

                /// Check Container
                Container(
                  height: Constant.height * .15,
                  width: Constant.width * .3,
                  decoration: BoxDecoration(
                    color: AppColors.darkGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, size: Constant.width * .2, color: AppColors.white),
                ),

                SizedBox(height: Constant.height * .02),

                /// Service Completed ---> Text
                Text('Service Completed', style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.darkGreen)),

                SizedBox(height: Constant.height * .02),

                /// description
                SizedBox(
                  height: Constant.height * .1,
                  width: Constant.width * .8,
                  child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry ', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextLightColor),textAlign: TextAlign.center)
                ),

                Spacer(),
                
                appointmentDetailsCard(
                  'Electrician Services Package',
                  'DSAFDS23432',
                  'Abhishek Thakur'
                ),

                SizedBox(height: Constant.height * .02),

                CommonButton(
                  height: Constant.height * .055,
                  width: Constant.width * 1,
                  title: 'Share Feedback',
                  onTap: () {
                    Get.to(() => FeedbackScreen());
                  },
                ),

                SizedBox(height: Constant.height * .06),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Appointment Detail Card
  Widget appointmentDetailsCard(String title, workId, clientName) {
    return Container(
      height: Constant.height * .115,
      width: Constant.width * 1,
      margin: EdgeInsets.only(top: Constant.height * .015),
      padding: EdgeInsets.only(
        left: Constant.width * .04,
        right: Constant.width * .04,
        top: Constant.height * .015,
        bottom: Constant.height * .015,
      ),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(Constant.width * .02),
          border: Border.all(color: AppColors.gradient2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(title,
              style: TextStyle(
                  fontSize: Constant.width * .04,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),

          SizedBox(height: Constant.height * .01),

          /// WorkId + ClientName
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// WorkId
              titleValue('Work Id', workId, Icons.assignment),

              /// ClientName
              titleValue('Client Name', clientName, Icons.person),
            ],
          ),
        ],
      ),
    );
  }

  Widget titleValue(String title, value, IconData icon) {
    return SizedBox(
      width: Constant.width * .4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// icon + title
          Row(
            children: [
              Icon(icon, size: Constant.width * .04),
              SizedBox(width: Constant.width * .02),
              Text(title,
                  style: TextStyle(
                      fontSize: Constant.width * .035,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black))
            ],
          ),

          /// value
          Text(value,
              style: TextStyle(
                  fontSize: Constant.width * .035,
                  color: AppColors.greyTextDarkColor))
        ],
      ),
    );
  }

}
