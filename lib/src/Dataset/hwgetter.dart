import 'package:flutter/material.dart';

double getWidth(BuildContext context, double times) {
  double width = MediaQuery.of(context).size.width * times;
  return width;
}

double getHeight(BuildContext context, double times) {
  double height = MediaQuery.of(context).size.height * times;
  return height;
}