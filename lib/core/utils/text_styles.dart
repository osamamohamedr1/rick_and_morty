import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/utils/colors_manager.dart';

class Textstyles {
  static TextStyle font20GreyBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: ColorsManager.grey,
  );

  static TextStyle font20GreyNormal = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.normal,
    color: ColorsManager.grey,
  );
  static TextStyle font14GreyNormal = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: ColorsManager.grey,
  );

  static TextStyle font16WhiteBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle font14GreyBold = TextStyle(
    fontSize: 14.sp,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font14WhiteNormal = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
}
