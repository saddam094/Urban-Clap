import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_clap/feature/money_transfer/presentation/controller/money_transfer_controller.dart';
import 'package:urban_clap/feature/payment_method/presentation/view/payment_method_screen.dart';
import 'package:urban_clap/res/color/app_color.dart';
import 'package:urban_clap/res/common/common_button.dart';
import 'package:urban_clap/res/common/custom_app_bar.dart';
import 'package:urban_clap/res/constant/constant_data.dart';

class MoneyTransferScreen extends StatefulWidget {
  const MoneyTransferScreen({super.key});

  @override
  State<MoneyTransferScreen> createState() => _MoneyTransferScreenState();
}

class _MoneyTransferScreenState extends State<MoneyTransferScreen> {

  final moneyTransferVM = Get.put(MoneyTransferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// Heading Container
          CustomAppBar(title: 'Money Transfer', isBack: true, onBack: () => Navigator.pop(context)),

          /// Main Content
          SingleChildScrollView(
            padding:  EdgeInsets.only(
              left: Constant.width * .03,
              right: Constant.width * .03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Total Amount To Be Transferred
                Container(
                  height: Constant.height * .12,
                  width: Constant.width * 1,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(Constant.width * .02),
                    border: Border.all(
                      color: AppColors.gradient2
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Price Text
                      Text('₹ 200', style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.greenTextColor)),

                      SizedBox(height: Constant.height * .005),

                      /// Total Amount To Be Transferred ---> Text
                      Text('Total amount to be transferred', style: TextStyle(fontSize: Constant.width * .04)),
                    ],
                  ),
                ),

                SizedBox(height: Constant.height * .01),

                Text('Deposit to', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.black)),

                SizedBox(
                  height: Constant.height * .53,
                  width: Constant.width * 1,
                  child: ListView.builder(
                    itemCount: 3,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return bankCard('State Bank Of India', 'John Deo', '123456789987654', index);
                    },
                  ),
                ),

                // Spacer(),

                SizedBox(height: Constant.height * .01),

                /// Bank Account & UPI Account
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Bank Account
                    InkWell(
                      onTap: () {
                        Get.to(() => PaymentMethodScreen(isBank: true));
                      },
                      child: Container(
                        height: Constant.height * .05,
                        width: Constant.width * .45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Constant.width * .02),
                          border: Border.all(
                            color: AppColors.gradient2
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// Icon 
                            Icon(Icons.account_balance_outlined, size: Constant.width * .05, color: AppColors.greyTextDarkColor),
                      
                            SizedBox(width: Constant.width * .03),
                      
                            Text('Bank Account', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black))
                          ],
                        ),
                      ),
                    ),

                    /// UPI Account
                    InkWell(
                      onTap: () {
                        Get.to(() => PaymentMethodScreen(isBank: false));
                      },
                      child: Container(
                        height: Constant.height * .05,
                        width: Constant.width * .45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Constant.width * .02),
                            border: Border.all(
                                color: AppColors.gradient2
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// Icon
                            Icon(Icons.account_balance_wallet_outlined, size: Constant.width * .05, color: AppColors.greyTextDarkColor),
                      
                            SizedBox(width: Constant.width * .03),
                      
                            /// Title ---> Text
                            Text('UPI Account', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Constant.height * .02),

                CommonButton(
                  onTap: () {

                  },
                  title: 'Transfer',
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

  /// Bank Card
  Widget bankCard(String bankName, userName, accountNumber, int index){
    return Container(
      height: Constant.height * .1,
      width: Constant.width * 1,
      margin: EdgeInsets.only(
        top: Constant.height * .005,
        bottom: Constant.height * .005
      ),
      padding: EdgeInsets.only(
        left: Constant.width * .01,
        right: Constant.width * .01
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Constant.width * .02),
        border: Border.all(
          color: AppColors.gradient2
        )
      ),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Radio Button
            SizedBox(
              width: Constant.width * .1,
              child: Center(
                child: InkWell(
                    onTap: () {
                      if(moneyTransferVM.selectedAccountIndex.value == index){
                        moneyTransferVM.selectedAccountIndex.value = 10000;
                      }else{
                        moneyTransferVM.selectedAccountIndex.value = index;
                      }
                    },
                    child: Icon(Icons.radio_button_checked, size: Constant.width * .05, color: index == moneyTransferVM.selectedAccountIndex.value ? AppColors.primaryColor : AppColors.greyTextLightColor)
                ),
              ),
            ),

            /// content
            SizedBox(
              width: Constant.width * .6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Bank Name
                  Text(bankName, style: TextStyle(fontSize: Constant.width * .035, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1, overflow: TextOverflow.ellipsis),

                  SizedBox(height: Constant.height * .002),

                  Text(userName, style: TextStyle(fontSize: Constant.width * .035, color: AppColors.greyTextLightColor), maxLines: 1, overflow: TextOverflow.ellipsis),

                  SizedBox(height: Constant.height * .002),

                  Text(accountNumber, style: TextStyle(fontSize: Constant.width * .035, color: AppColors.greyTextDarkColor), maxLines: 1, overflow: TextOverflow.ellipsis),

                ],
              ),
            ),


            /// View Button
            SizedBox(
              width: Constant.width * .2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_red_eye_outlined, size: Constant.width * .05, color: AppColors.primaryColor),

                  SizedBox(width: Constant.width * .01),

                  Text('View', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.primaryColor))
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}
