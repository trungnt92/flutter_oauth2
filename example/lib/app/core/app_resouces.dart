import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore_for_file: public_member_api_docs
/// App Icons
class AppIcons {
  // static const icEdit = 'assets/icons/edit.png';
}

/// Font family
const String fontFamily = 'Roboto';

class AppColors {
  static const blackBackground = Color(0xFF1E1E21);
}

/// Font bold
TextStyle boldSFTextStyle({double? size, Color? color, double? height}) =>
    TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: size ?? 14.sp,
        color: color ?? AppColors.blackBackground,
        height: height);

/// Font regular
TextStyle regularSFTextStyle({double? size, Color? color, double? height}) =>
    TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: size ?? 14.sp,
      color: color ?? Colors.black,
      height: height,
    );

/// Font medium
TextStyle mediumSFTextStyle({double? size, Color? color, double? height}) =>
    TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: size ?? 14.sp,
        color: color ?? Colors.black,
        height: height);
