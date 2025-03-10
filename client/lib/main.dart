import 'package:client/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: AppPages.routes,
    debugShowCheckedModeBanner: false,
  ));
}
