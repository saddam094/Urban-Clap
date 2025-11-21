import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinput/pinput.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:urban_clap_vendor/core/response/status.dart';
import 'package:urban_clap_vendor/feature/particular_appointment/presentation/controller/particular_appointment_controller.dart';
import 'package:urban_clap_vendor/feature/service_completed/presentation/view/service_completed_screen.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/common/common_button.dart';
import 'package:urban_clap_vendor/res/common/custom_app_bar.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ParticularAppointmentScreen extends StatefulWidget {
  final String appointmentId;
  const ParticularAppointmentScreen({super.key, required this.appointmentId});

  @override
  State<ParticularAppointmentScreen> createState() =>
      _ParticularAppointmentScreenState();
}

class _ParticularAppointmentScreenState
    extends State<ParticularAppointmentScreen> {
  final particularAppointmentVM = Get.put(ParticularAppointmentController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    particularAppointmentVM.getParticularAppointment(widget.appointmentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Heading Container
            CustomAppBar(
                title: '', isBack: true, onBack: () => Navigator.pop(context)),
        
            /// Main Content
            Obx(() {
              switch (particularAppointmentVM.rxRequestStatusParticularAppointment.value) {
                case Status.LOADING:
                  return SizedBox(
                    height: Constant.height * .87,
                    width: Constant.width * 1,
                    child: Center(
                      child: CircularProgressIndicator(color: AppColors.primaryColor,),
                    ),
                  );

                case Status.ERROR:
                  return SizedBox(
                    height: Constant.height * .87,
                    width: Constant.width * 1,
                    child: Center(
                      child: Text('Something Went Wrong...',
                          style: TextStyle(
                              fontSize: Constant.width * .05,
                              color: AppColors.redColor)),
                    ),
                  );

                case Status.COMPLETED:
                  var data = particularAppointmentVM.rxParticularAppointmentModel.value!.booking;
                  return SizedBox(
                    height: Constant.height * .87,
                    width: Constant.width * 1,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: Constant.width * .03,
                        right: Constant.width * .03,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Appointment Details
                          appointmentDetailsCard(
                              data.serviceName,
                              data.id,
                              data.userName,
                              data.time,
                              data.userPhone),

                          SizedBox(height: Constant.height * .01),

                          Row(
                            children: [
                              Text('Location :- ', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.black)),
                              Text(data.location, style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black)),
                            ],
                          ),

                          SizedBox(height: Constant.height * .01),

                          /// Location Details Card
                          locationCard(data.landmark.longitude, data.landmark.latitude),

                          SizedBox(height: Constant.height * .01),

                          Text('Notes',
                              style: TextStyle(
                                  fontSize: Constant.width * .04,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black)),

                          SizedBox(height: Constant.height * .01),

                          /// Task List Container
                          Container(
                            width: Constant.width * 1,
                            padding: EdgeInsets.only(
                              left: Constant.width * .03,
                              right: Constant.width * .03,
                              top: Constant.height * .015,
                              bottom: Constant.height * .015,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Constant.width * .03),
                              border: Border.all(color: AppColors.gradient2),
                            ),
                            child: Text(data.note, style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextLightColor))
                          ),

                          SizedBox(height: Constant.height * .01),

                          Text('Price Details',
                              style: TextStyle(
                                  fontSize: Constant.width * .04,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black)),

                          SizedBox(height: Constant.height * .01),

                          /// Price Details
                          priceDetailsCard(data.totalAmount.toDouble(), 0),

                          SizedBox(height: Constant.height * .01),

                          SizedBox(height: Constant.height * .02),

                          CommonButton(
                            onTap: () {
                              if (particularAppointmentVM.isServiceStarted.value) {

                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(Constant.width * .1)),
                                  ),
                                  builder: (context) {
                                    return paymentBottomSheet();
                                  },
                                );

                              } else {

                                particularAppointmentVM.sendStartServiceOTP();

                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(Constant.width * .1)),
                                  ),
                                  builder: (context) {
                                    particularAppointmentVM.startTimer();
                                    return otpBottomSheet();
                                  },
                                );
                              }
                            },
                            title: particularAppointmentVM.isServiceStarted.value
                                ? 'Continue'
                                : 'Start Service',
                            height: Constant.height * .055,
                            width: Constant.width * 1,
                            isLoading: particularAppointmentVM.isLoading.value,
                          ),

                          SizedBox(height: Constant.height * .06)
                        ],
                      ),
                    ),
                  );
              }
            }),

          ],
        ),
      ),
    );
  }

  /// Appointment Detail Card
  Widget appointmentDetailsCard(String title, workId, clientName, preferredTime, phone) {
    return Container(
      height: Constant.height * .23,
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

          SizedBox(height: Constant.height * .015),

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

          SizedBox(height: Constant.height * .01),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// PreferredTime
              titleValue('Preferred Time', preferredTime, Icons.access_time),
            ],
          ),

          SizedBox(height: Constant.height * .01),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Contact Button
              InkWell(
                onTap: () {
                  launchUrlString('tel://${particularAppointmentVM.rxParticularAppointmentModel.value!.booking.userPhone}');
                },
                child: Container(
                  height: Constant.height * .042,
                  width: Constant.width * .3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Constant.width * .05),
                      border: Border.all(color: AppColors.primaryColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call,
                          size: Constant.width * .04,
                          color: AppColors.primaryColor),
                      SizedBox(width: Constant.width * .02),
                      Text('Contact',
                          style: TextStyle(
                              fontSize: Constant.width * .04,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor)),
                    ],
                  ),
                ),
              ),

              /// Navigate Button
              InkWell(
                onTap: () {},
                child: Container(
                  height: Constant.height * .042,
                  width: Constant.width * .3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Constant.width * .05),
                      border: Border.all(color: AppColors.primaryColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Navigate ',
                          style: TextStyle(
                              fontSize: Constant.width * .04,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor)),
                      SizedBox(width: Constant.width * .02),
                      Icon(Icons.send,
                          size: Constant.width * .04,
                          color: AppColors.primaryColor)
                    ],
                  ),
                ),
              )
            ],
          )
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

  /// Location
  Widget locationCard(String longitude, String latitude) {
    final double lat = double.parse(latitude);
    final double lng = double.parse(longitude);
    final LatLng position = LatLng(lat, lng);

    return Container(
      height: Constant.height * .13,
      width: Constant.width * 1,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Constant.width * .03),
        border: Border.all(color: AppColors.gradient2),
      ),
      clipBehavior: Clip.antiAlias, // ensures map corners are rounded
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: position,
          zoom: 14.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("selectedLocation"),
            position: position,
          ),
        },
        zoomControlsEnabled: false,
        scrollGesturesEnabled: false,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        liteModeEnabled: true,
        myLocationEnabled: false,
        onMapCreated: (GoogleMapController controller) {},
      ),
    );
  }

  /// Task Card
  Widget taskCardNotStarted(int taskNumber, String title, description) {
    return SizedBox(
      height: Constant.height * .08,
      width: Constant.width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Number & Title
          Text('${taskNumber.toString()} - $title',
              style: TextStyle(
                  fontSize: Constant.width * .035,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),

          /// Description
          Text(description,
              style: TextStyle(
                  fontSize: Constant.width * .035,
                  color: AppColors.greyTextLightColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  /// Task Card Started
  Widget taskCardStarted(int taskNumber, String title, description, bool isChecked) {
    return SizedBox(
      height: Constant.height * .08,
      width: Constant.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Constant.width * .75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Number & Title
                Text('${taskNumber.toString()} - $title',
                    style: TextStyle(
                        fontSize: Constant.width * .035,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),

                /// Description
                Text(description,
                    style: TextStyle(
                        fontSize: Constant.width * .035,
                        color: AppColors.greyTextLightColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),

          /// Check Box
          Checkbox(
            activeColor: AppColors.greenTextColor,
            checkColor: AppColors.white,
            side: BorderSide(color: AppColors.greyTextDarkColor, width: 2),
            value: isChecked,
            onChanged: (value) {
              particularAppointmentVM.taskList[taskNumber - 1]['isChecked'] = value!;
              particularAppointmentVM.taskList.refresh();
            }
          )
        ],
      ),
    );
  }

  /// BottomSheet for Otp
  Widget otpBottomSheet(){
    return Container(
      height: Constant.height * .6,
      width: Constant.width * 1,
      padding: EdgeInsets.only(
        left: Constant.width * .03,
        right: Constant.width * .03,
        top: Constant.height * .015
      ),
      child: Column(
        children: [
          Divider(
            color: AppColors.greyTextDarkColor,
            thickness: Constant.height * .003,
            indent: Constant.width * .3,
            endIndent: Constant.width * .3,
          ),

          SizedBox(height: Constant.height * .02),

          /// Enter Job Code
          Text('Enter Job Code', style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: AppColors.black)),

          SizedBox(height: Constant.height * .002),

          /// Ask Customer for this code
          Text('Ask Customer For This Code', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextDarkColor)),

          SizedBox(height: Constant.height * .01),

          /// PinPut
          Center(
            child: Pinput(
              controller: particularAppointmentVM.otpController.value,
              keyboardType: TextInputType.phone,
              defaultPinTheme: PinTheme(
                width: Constant.width * .18,
                height: Constant.height * .06,
                textStyle: TextStyle(fontSize: Constant.width * .04, color: Colors.black),
                decoration: BoxDecoration(
                  color: Colors.transparent, // No background
                  border: Border.all(color: AppColors.greyTextLightColor), // No border
                  borderRadius: BorderRadius.circular(Constant.width * .08),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: Constant.width * .18,
                height: Constant.height * .06,
                textStyle: TextStyle(fontSize: Constant.width * .04, color: Colors.black),
                decoration: BoxDecoration(
                  color: Colors.transparent, // No background
                  border: Border.all(color: AppColors.primaryColor), // No border
                  borderRadius: BorderRadius.circular(Constant.width * .08),
                ),
              ),
            ),
          ),

          SizedBox(height: Constant.height * .01),

          /// Timer ---> Add here
          Obx(() {
            return InkWell(
              onTap: particularAppointmentVM.timerSeconds.value == 0
                  ? () {
                // particularAppointmentVM.resetTimer();
                particularAppointmentVM.resendStartServiceOTP();
              }
                  : null,
              child: Text(
                particularAppointmentVM.timerSeconds.value > 0
                    ? "Resend code in ${particularAppointmentVM.timerSeconds.value}s"
                    : "Resend Code",
                style: TextStyle(
                  fontSize: Constant.width * .04,
                  color: particularAppointmentVM.timerSeconds.value > 0
                      ? AppColors.greyTextDarkColor
                      : AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),


          Spacer(),

          Obx(() {
            return CommonButton(
              onTap: () {
                particularAppointmentVM.verifyStartServiceOTP();
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.pop(context);
                });


              },
              title: 'Verify OTP',
              height: Constant.height * .06,
              isLoading: particularAppointmentVM.isLoadingOTP.value,
            );
          }),

          SizedBox(height: Constant.height * .06)
        ],
      ),

    );
  }

  /// Price Details Card
  Widget priceDetailsCard(double price, int discount){
    return Container(
      height: Constant.height * .22,
      width: Constant.width * 1,
      padding: EdgeInsets.only(
        left: Constant.width * .03,
        right: Constant.width * .03,
        top: Constant.height * .015,
        bottom: Constant.height * .015
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(Constant.width * .02),
        border: Border.all(
          color: AppColors.greyTextDarkColor
        )
      ),
      child: Column(
        children: [
          /// price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextDarkColor)),
              Text('₹ ${price.round().toString()}', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black)),
            ],
          ),

          /// Divider ---> Text
          Text('..........................................................................................', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.greyTextDarkColor), maxLines: 1),

          /// Sub Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sub Total', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextDarkColor)),
              Text('₹ ${price.round().toString()}', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black)),
            ],
          ),

          /// Divider ---> Text
          Text('..........................................................................................', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.greyTextDarkColor), maxLines: 1),

          /// Discount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Discount ', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextDarkColor)),
                  Text('(${discount.toString()}% off)', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.primaryColor)),
                ],
              ),
              Text('- ₹ ${(price * discount / 100).round().toString()}', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.primaryColor)),
            ],
          ),

          /// Divider ---> Text
          Text('..........................................................................................', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.greyTextDarkColor), maxLines: 1),

          /// Total Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Amount', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
              Text('₹ ${(price - (price * discount / 100)).round().toString()}', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
            ],
          ),
        ],
      ),
    );
  }

  /// Payment Bottom Sheet
  Widget paymentBottomSheet(){
    return Container(
      height: Constant.height * .6,
      width: Constant.width * 1,
      padding: EdgeInsets.only(
          left: Constant.width * .03,
          right: Constant.width * .03,
          top: Constant.height * .015
      ),
      child: Column(
        children: [
          Divider(
            color: AppColors.greyTextDarkColor,
            thickness: Constant.height * .003,
            indent: Constant.width * .3,
            endIndent: Constant.width * .3,
          ),

          SizedBox(height: Constant.height * .02),

          /// Enter Job Code
          Text('Amount To Collect', style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: AppColors.black)),

          SizedBox(height: Constant.height * .002),

          /// Ask Customer for this code
          Text('₹ 200', style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),

          SizedBox(height: Constant.height * .01),

          /// QR
          QrImageView(
            data: '6202548771saddam@ibl',
            version: QrVersions.auto,
            size: 250,
            gapless: false
          ),

          Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonButton(
                onTap: () {
                  Get.to(() => ServiceCompletedScreen());
                },
                title: 'Cash',
                height: Constant.height * .06,
                width: Constant.width * .45,
              ),

              CommonButton(
                onTap: () {
                  Get.to(() => ServiceCompletedScreen());
                },
                title: 'Online',
                height: Constant.height * .06,
                width: Constant.width * .45,
              ),
            ],
          ),

          SizedBox(height: Constant.height * .06)
        ],
      ),

    );
  }

}
