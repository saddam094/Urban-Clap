import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap_vendor/core/response/status.dart';
import 'package:urban_clap_vendor/feature/authentication/initial_page/laundry_screen.dart';
import 'package:urban_clap_vendor/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:urban_clap_vendor/feature/edit_profile/presentation/view/edit_profile_screen.dart';
import 'package:urban_clap_vendor/feature/money_transfer/presentation/view/money_transfer_screen.dart';
import 'package:urban_clap_vendor/feature/my_services/presentation/view/my_services_screen.dart';
import 'package:urban_clap_vendor/feature/particular_appointment/presentation/view/particular_appointment_screen.dart';
import 'package:urban_clap_vendor/feature/profile/presentation/view/profile_screen.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/common/common_button.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';
import 'package:urban_clap_vendor/res/preferences/user_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dashboardVM = Get.put(DashboardController());

  final userPreferences = UserPreference();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashboardVM.getAppointmentList();
    dashboardVM.getAcceptedAndRejectedCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        key: _globalKey,
        drawer: Drawer(
          width: Constant.width * .75,
          child: Container(
            height: Constant.height * 1,
            width: Constant.width * .75,
            padding: EdgeInsets.only(
              left: Constant.width * .04,
              right: Constant.width * .04,
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.dashboardGradiant2, AppColors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Column(
              children: [
                SizedBox(height: Constant.height * .05),

                /// Profile Box
                Obx(
                  () {
                    return InkWell(
                      onTap: () {
                        Get.to(() => const ProfileScreen());
                      },
                      child: SizedBox(
                        height: Constant.height * .07,
                        width: Constant.width * .75,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: Constant.height * .06,
                              width: Constant.width * .12,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.cardBg1,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/profile/person male.png'),
                                      fit: BoxFit.cover),
                                  border: Border.all(color: AppColors.white)),
                            ),
                            SizedBox(width: Constant.width * .02),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('User',
                                    style: TextStyle(
                                        fontSize: Constant.width * .04,
                                        color: AppColors.greyTextLightColor)),
                                Text(
                                  dashboardVM.name.value,
                                  style: TextStyle(
                                      fontSize: Constant.width * .04,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: Constant.height * .05),

                /// Earning
                drawerCard('Earning', Icons.dashboard_outlined, () {}),

                SizedBox(height: Constant.height * .01),

                /// Profile
                drawerCard('Profile', Icons.person_2_outlined, () {
                  Get.to(() => const ProfileScreen());
                }),

                SizedBox(height: Constant.height * .01),

                /// Edit Profile
                drawerCard('Edit Profile', Icons.edit_outlined, () {
                  Get.to(() => const EditProfileScreen());
                }),

                SizedBox(height: Constant.height * .01),

                /// My Services
                drawerCard('My Services', Icons.miscellaneous_services_outlined,
                    () {
                  Get.to(() => const MyServicesScreen());
                }),

                SizedBox(height: Constant.height * .01),

                /// Raise An Issue
                drawerCard(
                    'Raise An Issue', Icons.question_answer_outlined, () {}),

                SizedBox(height: Constant.height * .01),

                /// Help Center
                drawerCard('Help Center', Icons.help_center_outlined, () {}),

                SizedBox(height: Constant.height * .01),

                /// Contact Admin
                drawerCard(
                    'Contact Admin', Icons.support_agent_outlined, () {}),

                Spacer(),

                CommonButton(
                  onTap: () {
                    userPreferences.setToken('');
                    Get.offAll(() => const LaundryScreen());
                  },
                  title: 'Logout',
                  height: Constant.height * .055,
                  width: Constant.width * 1,
                ),

                SizedBox(height: Constant.height * .07)
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// Heading
              Container(
                height: Constant.height * .15,
                width: Constant.width * 1,
                padding: EdgeInsets.only(
                  left: Constant.width * .03,
                  right: Constant.width * .03,
                  // bottom: Constant.height * .02,
                  top: Constant.height * .04,
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.dashboardGradiant1,
                        AppColors.dashboardGradiant2
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.dashboardGradiant2,
                        spreadRadius: Constant.width * .05,
                        blurRadius: Constant.width * .05,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Drawer Button
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _globalKey.currentState?.openDrawer();
                          },
                          child: Container(
                            height: Constant.height * .07,
                            width: Constant.width * .14,
                            decoration: BoxDecoration(
                                color: AppColors.white, shape: BoxShape.circle),
                            child: Center(
                              child: Icon(Icons.menu,
                                  size: Constant.width * .07,
                                  color: AppColors.black),
                            ),
                          ),
                        ),

                        SizedBox(width: Constant.width * .03),

                        /// Name And Place
                        SizedBox(
                          height: Constant.height * .07,
                          width: Constant.width * .5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Name
                              Text('Hey, Krishna',
                                  style: TextStyle(
                                      fontSize: Constant.width * .035,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),

                              /// Place
                              Row(
                                children: [
                                  Icon(Icons.place,
                                      size: Constant.width * .04,
                                      color: AppColors.greyTextDarkColor),
                                  Text('Markham College',
                                      style: TextStyle(
                                          fontSize: Constant.width * .032,
                                          color: AppColors.black),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    /// Amount
                    InkWell(
                      onTap: () {
                        Get.to(() => const MoneyTransferScreen());
                      },
                      child: Container(
                        height: Constant.height * .05,
                        width: Constant.width * .25,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius:
                                BorderRadius.circular(Constant.width * .06)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// Icon
                            Icon(Icons.payments_outlined,
                                size: Constant.width * .05,
                                color: AppColors.blueColor),

                            SizedBox(width: Constant.width * .02),

                            /// Text
                            Text('₹200',
                                style: TextStyle(
                                    fontSize: Constant.width * .04,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              /// Main Container
              Container(
                height: Constant.height * .85,
                width: Constant.width * 1,
                padding: EdgeInsets.only(
                  left: Constant.width * .03,
                  right: Constant.width * .03,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Order Count
                      Obx(() {
                        switch (dashboardVM.rxRequestStatusCount.value) {
                          case Status.LOADING:
                            return Container(
                              height: Constant.height * .12,
                              width: Constant.width * 1,
                              padding: EdgeInsets.only(
                                left: Constant.width * .05,
                                right: Constant.width * .05,
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                      Constant.width * .03),
                                  border: Border.all(
                                      color: AppColors.dashboardGradiant1)),
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.primaryColor),
                              ),
                            );

                          case Status.ERROR:
                            return Container(
                              height: Constant.height * .12,
                              width: Constant.width * 1,
                              padding: EdgeInsets.only(
                                left: Constant.width * .05,
                                right: Constant.width * .05,
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                      Constant.width * .03),
                                  border: Border.all(
                                      color: AppColors.dashboardGradiant1)),
                              child: Center(
                                child: Text('Unable To Fetch Accepted & Rejected Counts',
                                    style: TextStyle(
                                        fontSize: Constant.width * .05,
                                        color: AppColors.redColor)),
                              ),
                            );

                          case Status.COMPLETED:
                            var data = dashboardVM.rxCountModel.value!;
                            return Container(
                              height: Constant.height * .12,
                              width: Constant.width * 1,
                              padding: EdgeInsets.only(
                                left: Constant.width * .05,
                                right: Constant.width * .05,
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                      Constant.width * .03),
                                  border: Border.all(
                                      color: AppColors.dashboardGradiant1)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /// Accepted Orders
                                  SizedBox(
                                    width: Constant.width * .33,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Accepted Orders',
                                            style: TextStyle(
                                                fontSize: Constant.width * .04,
                                                color: AppColors
                                                    .greyTextDarkColor)),
                                        SizedBox(
                                            height: Constant.height * .005),
                                        Text(data.approvedCount.toString(),
                                            style: TextStyle(
                                                fontSize: Constant.width * .05,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black)),
                                      ],
                                    ),
                                  ),

                                  /// Dividers
                                  Container(
                                    height: Constant.height * .08,
                                    width: Constant.width * .003,
                                    color: AppColors.greyTextDarkColor,
                                  ),

                                  /// Rejected Orders
                                  SizedBox(
                                    width: Constant.width * .33,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Rejected Orders',
                                            style: TextStyle(
                                                fontSize: Constant.width * .04,
                                                color: AppColors
                                                    .greyTextDarkColor)),
                                        SizedBox(
                                            height: Constant.height * .005),
                                        Text(data.rejectedCount.toString(),
                                            style: TextStyle(
                                                fontSize: Constant.width * .05,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                        }
                      }),

                      SizedBox(height: Constant.height * .01),

                      /// Today`s Appointment
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Appointments',
                              style: TextStyle(
                                  fontSize: Constant.width * .045,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black)),

                          /// Refresh ---> TextButton
                          InkWell(
                              onTap: () {
                                dashboardVM.setRxRequestStatusAppointmentList(
                                    Status.LOADING);
                                dashboardVM.getAppointmentList();
                              },
                              child: Text('Refresh',
                                  style: TextStyle(
                                      fontSize: Constant.width * .04,
                                      color: AppColors.black,
                                      decoration: TextDecoration.underline))),
                        ],
                      ),

                      /// Today`s Appointment List
                      Obx(() {
                        switch (
                            dashboardVM.rxRequestStatusAppointmentList.value) {
                          case Status.LOADING:
                            return SizedBox(
                              height: Constant.height * .65,
                              width: Constant.width * 1,
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.primaryColor),
                              ),
                            );

                          case Status.ERROR:
                            return SizedBox(
                              height: Constant.height * .65,
                              width: Constant.width * 1,
                              child: Center(
                                child: Text('Something Went Wrong...',
                                    style: TextStyle(
                                        fontSize: Constant.width * .05,
                                        color: AppColors.redColor)),
                              ),
                            );

                          case Status.COMPLETED:
                            if (dashboardVM.rxAppointmentListModel.value!
                                .bookings.isEmpty) {
                              return SizedBox(
                                height: Constant.height * .65,
                                width: Constant.width * 1,
                                child: Center(
                                  child: Text('No Appointments Available',
                                      style: TextStyle(
                                          fontSize: Constant.width * .05,
                                          color: AppColors.primaryColor)),
                                ),
                              );
                            }
                            return Stack(
                              children: [
                                SizedBox(
                                  height: Constant.height *
                                          .315 *
                                          dashboardVM.rxAppointmentListModel
                                              .value!.bookings.length +
                                      Constant.height * .02,
                                  width: Constant.width * 1,
                                  child: ListView.builder(
                                    itemCount: dashboardVM
                                        .rxAppointmentListModel
                                        .value!
                                        .bookings
                                        .length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      var data = dashboardVM
                                          .rxAppointmentListModel
                                          .value!
                                          .bookings[index];
                                      return appointmentCard(
                                          data.serviceName,
                                          data.id,
                                          data.userName,
                                          data.location,
                                          data.time,
                                          data.note,
                                          data.bookingStatus);
                                    },
                                  ),
                                ),

                                /// Loader
                                Obx(
                                  () {
                                    return dashboardVM.isLoading.value
                                        ? Container(
                                            height: Constant.height * .65,
                                            width: Constant.width * 1,
                                            color: Colors.white30,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: AppColors
                                                            .primaryColor)),
                                          )
                                        : const SizedBox();
                                  },
                                )
                              ],
                            );
                        }
                      }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  /// Appointment Card
  Widget appointmentCard(String title, workId, clientName, location,
      preferredTime, repair, appointmentStatus) {
    return InkWell(
      onTap: () {
        if (appointmentStatus != 'pending') {
          Get.to(() => ParticularAppointmentScreen(appointmentId: workId));
        }
      },
      child: Container(
        height: Constant.height * .3,
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
            border: Border.all(color: AppColors.dashboardGradiant2)),
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
                /// Location
                titleValue('Location', location, Icons.place),

                /// PreferredTime
                titleValue('Preferred Time', preferredTime, Icons.access_time),
              ],
            ),

            SizedBox(height: Constant.height * .01),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Repair
                titleValue('Repair', repair, Icons.build),
              ],
            ),

            SizedBox(height: Constant.height * .01),

            appointmentStatus == 'pending'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// Reject Button
                      InkWell(
                        onTap: () {
                          dashboardVM.acceptOrRejectAppointment(
                              workId, 'reject');
                        },
                        child: Container(
                          height: Constant.height * .045,
                          width: Constant.width * .25,
                          decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius:
                                  BorderRadius.circular(Constant.width * .03),
                              border: Border.all(
                                  color: Colors.red,
                                  width: Constant.width * .005)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Reject ',
                                  style: TextStyle(
                                      fontSize: Constant.width * .04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                              Icon(Icons.close,
                                  size: Constant.width * .05, color: Colors.red)
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: Constant.width * .03),

                      /// Accept Button
                      InkWell(
                        onTap: () {
                          dashboardVM.acceptOrRejectAppointment(
                              workId, 'accept');
                        },
                        child: Container(
                          height: Constant.height * .045,
                          width: Constant.width * .25,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  BorderRadius.circular(Constant.width * .03),
                              border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: Constant.width * .005)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Accept ',
                                  style: TextStyle(
                                      fontSize: Constant.width * .04,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white)),
                              Icon(Icons.check,
                                  size: Constant.width * .05,
                                  color: AppColors.white)
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Status : ',
                        style: TextStyle(
                            fontSize: Constant.width * .04,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
                      ),
                      Text(appointmentStatus,
                          style: TextStyle(
                              fontSize: Constant.width * .04,
                              fontWeight: FontWeight.bold,
                              color: appointmentStatus == 'completed'
                                  ? AppColors.greenTextColor
                                  : AppColors.redColor)),
                    ],
                  )
          ],
        ),
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

  /// Drawer Card
  Widget drawerCard(String title, IconData icon, VoidCallback method) {
    return InkWell(
      onTap: method,
      child: Container(
        height: Constant.height * .07,
        width: Constant.width * 1,
        padding: EdgeInsets.only(
          left: Constant.width * .03,
          // right: Constant.width * .03,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColors.dashboardGradiant1,
              AppColors.dashboardGradiant2
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            borderRadius: BorderRadius.circular(Constant.width * .02)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Icon
            Container(
              height: Constant.height * .06,
              width: Constant.width * .12,
              decoration: BoxDecoration(
                  color: AppColors.drawerGradiant,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white)),
              child: Center(
                child: Icon(icon,
                    size: Constant.width * .06,
                    color: AppColors.greyTextDarkColor),
              ),
            ),

            /// title
            SizedBox(
              width: Constant.width * .37,
              child: Text(title,
                  style: TextStyle(
                      fontSize: Constant.width * .04, color: AppColors.black)),
            ),

            /// Right Navigate Icon
            SizedBox(
              width: Constant.width * .1,
              child: Center(
                child: Icon(Icons.keyboard_arrow_right,
                    size: Constant.width * .1,
                    color: AppColors.greyTextLightColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
