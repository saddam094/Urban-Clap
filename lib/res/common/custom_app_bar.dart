import 'package:flutter/material.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final bool isBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBack = false,
    this.onBack
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constant.height * .13,
      width: Constant.width * 1,
      padding: EdgeInsets.only(
        left: Constant.width * .05,
        right: Constant.width * .05,
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
        ]
      ),
      child: isBack ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onBack,
            child: Container(
              height: Constant.height * .06,
              width: Constant.width * .12,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle
              ),
              child: Center(
                child: Icon(Icons.arrow_back, size: Constant.width * .06, color: AppColors.black),
              ),
            ),
          ),
          
          Text(title, style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1),

          SizedBox(width: Constant.width * .12)
        ],
      )
      : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1),
        ],
      ),
    );
  }
}
