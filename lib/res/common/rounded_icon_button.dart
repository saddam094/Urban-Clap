import 'package:flutter/material.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';

class RoundedIconButton extends StatelessWidget {
  RoundedIconButton(
      {required this.icon, required this.onPress, required this.iconSize});

  final IconData icon;
  final VoidCallback onPress;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(width: iconSize, height: iconSize),
      elevation: 6.0,
      onPressed: onPress,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(iconSize * 0.2)),
      fillColor: AppColors.primaryColor,
      child: Icon(
        icon,
        color: AppColors.white,
        size: iconSize * 1,
      ),
    );
  }
}