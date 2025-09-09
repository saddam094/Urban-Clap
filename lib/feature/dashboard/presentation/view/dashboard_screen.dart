import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:urban_clap/feature/edit_profile/presentation/view/edit_profile_screen.dart';
import 'package:urban_clap/feature/money_transfer/presentation/view/money_transfer_screen.dart';
import 'package:urban_clap/feature/particular_appointment/presentation/view/particular_appointment_screen.dart';
import 'package:urban_clap/feature/profile/presentation/view/profile_screen.dart';
import 'package:urban_clap/res/color/app_color.dart';
import 'package:urban_clap/res/common/common_button.dart';
import 'package:urban_clap/res/constant/constant_data.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final dashboardVM = Get.put(DashboardController());

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dashboardVM.getEmail();
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
              colors: [
                AppColors.drawerGradiant,
                AppColors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
          child: Column(
            children: [
              SizedBox(height: Constant.height * .05),
              /// Profile Box
              Obx(() {
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
                              image: AssetImage('assets/images/profile/person male.png'),
                              fit: BoxFit.cover
                            ),
                            border: Border.all(
                              color: AppColors.white
                            )
                          ),
                        ),

                        SizedBox(width: Constant.width * .02),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('User', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextLightColor)),
                            Text(dashboardVM.name.value, style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1,),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },),

              SizedBox(height: Constant.height * .05),

              /// Earning
              drawerCard('Earning', Icons.dashboard_outlined, () {

              },),

              SizedBox(height: Constant.height * .01),

              /// Edit Profile
              drawerCard('Edit Profile', Icons.edit_outlined, () {
                Get.to(() => const EditProfileScreen());
              },),

              SizedBox(height: Constant.height * .01),

              /// Raise An Issue
              drawerCard('Raise An Issue', Icons.question_answer_outlined, () {

              },),

              SizedBox(height: Constant.height * .01),

              /// Help Center
              drawerCard('Help Center', Icons.help_center_outlined, () {

              },),


              SizedBox(height: Constant.height * .01),

              /// Contact Admin
              drawerCard('Contact Admin', Icons.support_agent_outlined, () {

              },),

              Spacer(),

              CommonButton(
                onTap: () {

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
      body: Column(
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
                    AppColors.gradient2,
                    AppColors.gradient1
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gradient1,
                    spreadRadius: Constant.width * .05,
                    blurRadius: Constant.width * .05,
                  )
                ]
            ),
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
                          color: AppColors.white,
                          shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Icon(Icons.menu, size: Constant.width * .07, color: AppColors.black),
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
                          Text('Hey, Krishna', style: TextStyle(fontSize: Constant.width * .035,fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1, overflow: TextOverflow.ellipsis),

                          /// Place
                          Row(
                            children: [
                              Icon(Icons.place, size: Constant.width * .04, color: AppColors.greyTextDarkColor),

                              Text('Markham College', style: TextStyle(fontSize: Constant.width * .032, color: AppColors.black), maxLines: 1, overflow: TextOverflow.ellipsis),
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
                      borderRadius: BorderRadius.circular(Constant.width * .06)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Icon
                        Icon(Icons.payments_outlined, size: Constant.width * .05, color: AppColors.blueColor),

                        SizedBox(width: Constant.width * .02),
                        /// Text
                        Text('₹200', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold),maxLines: 1, overflow: TextOverflow.ellipsis)
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
                  Container(
                    height: Constant.height * .12,
                    width: Constant.width * 1,
                    padding: EdgeInsets.only(
                      left: Constant.width * .05,
                      right: Constant.width * .05,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(Constant.width * .03),
                      border: Border.all(
                        color: AppColors.gradient1
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Accepted Orders
                        SizedBox(
                          width: Constant.width * .33,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Accepted Orders', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextDarkColor)),
              
                              SizedBox(height: Constant.height * .005),
              
                              Text('20', style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black)),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Rejected Orders', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextDarkColor)),
              
                              SizedBox(height: Constant.height * .005),
              
                              Text('20', style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              
                  SizedBox(height: Constant.height * .01),
              
                  /// Today`s Appointment
                  Text('Today`s Appointments', style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: AppColors.black)),
              
                  /// Today`s Appointment List
                  SizedBox(
                    height: Constant.height * .335 * dashboardVM.appointmentList.length + Constant.height * .02,
                    width: Constant.width * 1,
                    child: ListView.builder(
                      itemCount: dashboardVM.appointmentList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        var data = dashboardVM.appointmentList[index];
                        return appointmentCard(data['title'], data['workId'], data['clientName'], data['location'], data['preferredTime'], data['repair']);
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  /// Appointment Card
  Widget appointmentCard(String title, workId, clientName, location, preferredTime, repair){
    return Container(
      height: Constant.height * .32,
      width: Constant.width * 1,
      margin: EdgeInsets.only(
        top: Constant.height * .015
      ),
      padding: EdgeInsets.only(
        left: Constant.width * .04,
        right: Constant.width * .04,
        top: Constant.height * .015,
        bottom: Constant.height * .015,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Constant.width * .02),
        border: Border.all(
          color: AppColors.gradient2
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(title, style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1, overflow: TextOverflow.ellipsis),

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

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// Reject Button
              InkWell(
                onTap: () {

                },
                child: Container(
                  height: Constant.height * .045,
                  width: Constant.width * .25,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(Constant.width * .03),
                    border: Border.all(
                      color: Colors.red,
                      width: Constant.width * .005
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Reject ', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: Colors.red)),
                      Icon(Icons.close, size: Constant.width * .05, color: Colors.red)
                    ],
                  ),
                ),
              ),

              SizedBox(width: Constant.width * .03),

              /// Accept Button
              InkWell(
                onTap: () {
                  Get.to(() => ParticularAppointmentScreen());
                },
                child: Container(
                  height: Constant.height * .045,
                  width: Constant.width * .25,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(Constant.width * .03),
                      border: Border.all(
                          color: AppColors.primaryColor,
                          width: Constant.width * .005
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Accept ', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.white)),
                      Icon(Icons.check, size: Constant.width * .05, color: AppColors.white)
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

  Widget titleValue(String title, value, IconData icon){
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
              Text(title, style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.black))
            ],
          ),

          /// value
          Text(value, style: TextStyle(fontSize: Constant.width * .035, color: AppColors.greyTextDarkColor))
        ],
      ),
    );
  }

  /// Drawer Card
  Widget drawerCard(String title, IconData icon, VoidCallback method){
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
          gradient: LinearGradient(
            colors: [
              AppColors.dashboardGradiant1,
              AppColors.dashboardGradiant2
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
          ),
          borderRadius: BorderRadius.circular(Constant.width * .02)
        ),
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
                border: Border.all(
                  color: AppColors.white
                )
              ),
              child: Center(
                child: Icon(icon, size: Constant.width * .06, color: AppColors.greyTextDarkColor),
              ),
            ),

            /// title
            SizedBox(
              width: Constant.width * .37,
              child: Text(title, style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.black)),
            ),

            /// Right Navigate Icon
            SizedBox(
              width: Constant.width * .1,
              child: Center(
                child: Icon(Icons.keyboard_arrow_right, size: Constant.width * .1, color: AppColors.greyTextLightColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
