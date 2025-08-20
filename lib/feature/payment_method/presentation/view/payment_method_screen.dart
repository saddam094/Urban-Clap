import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap/feature/payment_method/presentation/controller/payment_method_controller.dart';
import 'package:urban_clap/res/color/app_color.dart';
import 'package:urban_clap/res/common/common_button.dart';
import 'package:urban_clap/res/common/common_text_field.dart';
import 'package:urban_clap/res/common/custom_app_bar.dart';
import 'package:urban_clap/res/constant/constant_data.dart';

class PaymentMethodScreen extends StatefulWidget {
  final bool isBank;
  const PaymentMethodScreen({super.key, required this.isBank});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {

  final paymentMethodVM = Get.put(PaymentMethodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// Heading Container
          CustomAppBar(title: 'Payment Method', isBack: true, onBack: () => Navigator.pop(context)),

          /// Main Content
          SingleChildScrollView(
            padding:  EdgeInsets.only(
              left: Constant.width * .03,
              right: Constant.width * .03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Text
                Text(widget.isBank ? 'Your earning will be transferred to the account details you provide belows' : 'The amount will be transferred to the UPI-Linked bank account', style: TextStyle(fontSize: Constant.width * .035, color: AppColors.greyTextLightColor)),

                SizedBox(height: Constant.height * .01),

                /// TextFields
                widget.isBank ? SizedBox(
                  height: Constant.height * .7,
                  width: Constant.width * 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text('Full Name', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black)),

                      /// Full Name
                      CommonTextField(
                        obSecure: false,
                        controller: paymentMethodVM.fullNameController.value,
                        hintText: 'Full Name',
                        hintStyle: TextStyle(color: AppColors.greyTextLightColor),
                        icon: Icon(Icons.person, color: AppColors.greyTextLightColor,),
                      ),

                      SizedBox(height: Constant.height * .005),

                      Text('Bank Name', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black)),

                      /// Bank Name
                      CommonTextField(
                        obSecure: false,
                        controller: paymentMethodVM.fullNameController.value,
                        hintText: 'Bank Name',
                        hintStyle: TextStyle(color: AppColors.greyTextLightColor),
                        icon: Icon(Icons.account_balance, color: AppColors.greyTextLightColor,),
                      ),

                      SizedBox(height: Constant.height * .005),

                      Text('Account Number', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black)),

                      /// Bank Name
                      CommonTextField(
                        obSecure: false,
                        controller: paymentMethodVM.fullNameController.value,
                        hintText: 'Account Number',
                        hintStyle: TextStyle(color: AppColors.greyTextLightColor),
                        icon: Icon(Icons.account_balance, color: AppColors.greyTextLightColor,),
                      ),

                      SizedBox(height: Constant.height * .005),

                      Text('Re-Enter Account Number', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black)),

                      /// Bank Name
                      CommonTextField(
                        obSecure: false,
                        controller: paymentMethodVM.fullNameController.value,
                        hintText: 'Re-Enter Account Number',
                        hintStyle: TextStyle(color: AppColors.greyTextLightColor),
                        icon: Icon(Icons.account_balance, color: AppColors.greyTextLightColor,),
                      ),

                      SizedBox(height: Constant.height * .005),

                      Text('IFSC Code', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black)),

                      /// Bank Name
                      CommonTextField(
                        obSecure: false,
                        controller: paymentMethodVM.fullNameController.value,
                        hintText: 'IFSC Code',
                        hintStyle: TextStyle(color: AppColors.greyTextLightColor),
                        icon: Icon(Icons.account_balance, color: AppColors.greyTextLightColor,),
                      ),
                    ],
                  ),
                ) : SizedBox(
                  height: Constant.height * .7,
                  width: Constant.width * 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: Constant.height * .01),

                      Text('Enter Your UPI Id', style: TextStyle(fontSize: Constant.width * .035, color: AppColors.black)),

                      /// UPI Id
                      CommonTextField(
                        obSecure: false,
                        controller: paymentMethodVM.fullNameController.value,
                        hintText: 'UPI ID : **********@upi',
                        hintStyle: TextStyle(color: AppColors.greyTextLightColor),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Constant.height * .02),

                CommonButton(
                  onTap: () {

                  },
                  title: 'Confirm',
                  height: Constant.height * .055,
                  width: Constant.width * 1,
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
