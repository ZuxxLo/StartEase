import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../main.dart';

class ForgotPasswordController extends GetxController {
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final codePINFormKey = GlobalKey<FormState>();
  bool someError = false;

  PageController pageController = PageController(keepPage: true);
  bool securedPassword = true;

  String? newPassword;
  inputnewPassword(String inputNewPassword) {
    newPassword = inputNewPassword;
  }

  String? fgpEmail;
  inputfgbEmail(String inputEmail) {
    fgpEmail = inputEmail.trim();
    someError = false;
    update();
  }

  String? codePIN;
  inputCodePIN(String inputCodePIN) {
    if (inputCodePIN.length < 7) {
      codePIN = inputCodePIN;
    }
  }

  sendEmail() async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "pleaseWait".tr,
        content: const CircularProgressIndicator());
    var response =
        await Crud.postRequest(resetPasswordSendEmailLink, {"email": fgpEmail});
    if (response != null && response["success"] == true) {
      Get.back();

      pageController.animateToPage(1,
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    } else if (response != null &&
        response["success"] == false &&
        response["message"] == "No user found with specified email") {
      someError = true;
      Get.back();

      update();
    } else {
      Get.back();

      if (!Get.isSnackbarOpen) {
        MainFunctions.somethingWentWrongSnackBar();
      }
    }
  }

  verifyCode() async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "pleaseWait".tr,
        content: const CircularProgressIndicator());
    var response = await Crud.postRequest(
        resetPasswordVerifyEmailLink, {"email": fgpEmail, "code": codePIN});
    if (response != null &&
        response["success"] == true &&
        response["message"] == "The code you provided is valid") {
      Get.back();

      pageController.animateToPage(2,
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    } else if (response != null &&
        response["success"] == false &&
        response["message"] == "The code you provided is valid") {
      someError = true;
      Get.back();

      update();
    } else {
      Get.back();

      if (!Get.isSnackbarOpen) {
        MainFunctions.somethingWentWrongSnackBar();
      }
    }
  }

  changeEmail() {
    fgpEmail = "";
    newPassword = "";

    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);
  }

  invertSecuredPassword() {
    securedPassword = !securedPassword;
    update();
  }

  resetPassword() async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "pleaseWait".tr,
        content: const CircularProgressIndicator());

    var response = await Crud.postRequest(resetPasswordResetEmailLink, {
      "email": fgpEmail,
      "code": codePIN,
      "password": newPassword,
      "confirm_password": newPassword
    });
    if (response != null && response["success"] == true) {
      Get.back();
      Get.defaultDialog(
        barrierDismissible: false,
        title: "successResetPassword".tr,
        content: const Text(""),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Get.back(closeOverlays: true);

        update();
      });
    } else if (response != null && response["success"] == false) {
      Get.back();
      MainFunctions.somethingWentWrongSnackBar(response["message"]);
      Future.delayed(const Duration(seconds: 3), () {
        Get.back(closeOverlays: true);

        update();
      });
    } else {
      if (!Get.isSnackbarOpen) {
        MainFunctions.somethingWentWrongSnackBar();
        Future.delayed(const Duration(seconds: 3), () {
          Get.back(closeOverlays: true);

          update();
        });
      }
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
