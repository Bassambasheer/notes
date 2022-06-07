import 'package:flutter/material.dart';

class MyColor {
  final Color color;
  MyColor({required this.color});
}

List<MyColor> colorList = [
  MyColor(color: const Color(0Xffffffff)),
  MyColor(color: const Color(0XFFFFB0D7)),
  MyColor(color: const Color(0XFF68AFAC)),
  MyColor(color: const Color(0XFF68AF57)),
  MyColor(color: const Color(0XFF686EFF)),
  MyColor(color: const Color(0XFFFF514A)),
];
int scaffoldColor = colorList[currentIndex].color.value;
int currentIndex = 0;
