import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
 

import '../main.dart';

class ProfilePageController extends GetxController {
  ch() {
    MainFunctions.checkInternetConnection();
    update();
  }

  bool isInternetConnected = false;

  getBoolisInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Get.closeCurrentSnackbar();
        isInternetConnected = true;
      } else {
        isInternetConnected = false;
      }
    } on SocketException catch (_) {
      Get.defaultPopGesture;
      isInternetConnected = false;
      if (!Get.isSnackbarOpen) {
        Get.rawSnackbar(
            duration: const Duration(seconds: 60),
            message: "noConnection".tr,
            showProgressIndicator: true,
            snackPosition: SnackPosition.TOP,
            icon: const Icon(
              Icons.report_problem,
              color: Colors.red,
            ));
      }
    }

    update();
  }


  @override
  void onInit() {
    getBoolisInternetConnected();
    super.onInit();
  }
}
