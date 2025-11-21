import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final Size? size;
  final Function()? onTap;
  final bool isLoading;
  final bool apiSucceed;
  final double width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool isEnabled;
  const CommonButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height,
    required this.onTap,
    this.size,
    this.isLoading = false,
    this.apiSucceed = false,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return isEnabled
        ? isLoading
            ? Container(
                height: height ?? 0.08.sh,
                width: width,
                padding: padding,
                margin: margin,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.white,
                )),
              )
            : InkWell(
                onTap: onTap,
                child: Container(
                  height: height ?? 0.08.sh,
                  width: width,
                  padding: padding,
                  margin: margin,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    // ),
                  ),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
        : Container(
            height: height ?? 0.08.sh,
            width: width,
            padding: padding,
            margin: margin,
            decoration: ShapeDecoration(
              color: AppColors.greyTextLightColor,
              shape: RoundedRectangleBorder(
                side:
                    const BorderSide(width: 1, color: AppColors.greyTextLightColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          );
  }
}
