import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final codePINFormKey = GlobalKey<FormState>();

  PageController pageController = PageController();
  bool securedPassword = true;

  String? newPassword;
  inputnewPassword(String inputNewPassword) {
    newPassword = inputNewPassword;
  }

  String? fgpEmail;
  inputfgbEmail(String inputEmail) {
    fgpEmail = inputEmail.trim();
  }

  String? codePIN;
  inputCodePIN(String inputCodePIN) {
    if (inputCodePIN.length < 8) {
      codePIN = inputCodePIN;
    }
  }

  sendEmail() {
    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);
  }

  verifyCode() {
    pageController.animateToPage(2,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);
  }

  changeEmail() {
    fgpEmail = "";
    newPassword = "";

    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);
  }

  backToLogIn() {
    Get.back();
  }

  invertSecuredPassword() {
    securedPassword = !securedPassword;
    update();
  }

  resetPassword() {
    Get.back();
  }
}
