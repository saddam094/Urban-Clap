import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/feature/dashboard/presentation/view/dashboard_screen.dart';
import 'package:urban_clap_vendor/feature/feedback/presentation/controller/feedback_controller.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/common/common_button.dart';
import 'package:urban_clap_vendor/res/common/custom_app_bar.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  final feedbackVM = Get.put(FeedbackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// Heading Container
          CustomAppBar(title: 'Feedback'),

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
                /// Appointment Detail card
                appointmentDetailsCard(
                    'Electrician Services Package',
                    'DSAFDS23432',
                    'Abhishek Thakur'
                ),

                SizedBox(height: Constant.height * .01),

                Row(
                  children: [
                    Text('Rate Your Experience', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.black)),
                  ],
                ),

                SizedBox(height: Constant.height * .01),

              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: Constant.width * .02),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: AppColors.yellowColor,
                ),
                onRatingUpdate: (rating) {
                  feedbackVM.rating.value = rating;
                },
              ),

                SizedBox(height: Constant.height * .015),

                Row(
                  children: [
                    Text('Leave a Review', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.black)),
                  ],
                ),

                TextField(
                  controller: feedbackVM.reviewComment.value,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Enter here..",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColors.gradient2
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: AppColors.gradient2
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: AppColors.gradient2
                        )
                    )
                  ),
                ),

                SizedBox(height: Constant.height * .01),


                Spacer(),



                SizedBox(height: Constant.height * .02),

                CommonButton(
                  height: Constant.height * .055,
                  width: Constant.width * 1,
                  title: 'Submit',
                  onTap: () {
                    Get.offAll(() => DashboardScreen());
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
