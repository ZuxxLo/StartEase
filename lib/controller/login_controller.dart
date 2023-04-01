import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../main.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  bool securedPassword = true;
  bool loginError = false;
  setUserPassword(password) {
    userModel.setUserPassword = password;
  }

  setUserEmail(email) {
    userModel.setUserEmail = email;
  }

  createOne() {
    Get.toNamed("/SignUp");
  }

  invertSecuredPassword() {
    securedPassword = !securedPassword;
    update();
  }

  String? passwordValidator(String? inputPassword) {
    if (inputPassword!.isEmpty) {
      return "enterPassword".tr;
    }
    return null;
  }

  String? emailValidator(String? inputPassword) {
    if (inputPassword!.isEmpty) {
      return "enterAnEmail".tr;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(inputPassword)) {
      return "enterValidEmail".tr;
    }

    return null;
  }

  getToForgetPasswrodPage() async {
    Get.toNamed(
      "/ForgotPassword",
    );

    // var response = await Crud.postRequest(signUpLink, {
    //   "username": userModel.getuserUserName,
    //   "password": userModel.getUserPassword
    // });

    // if (response != null && response["status"] == "success") {
    //   print("-------------------------");

    //   Get.offAndToNamed("/ProfilePage");
    // } else if (response != null && response["status"] == "fail") {
    //   loginError = true;
    //   update();
    // } else {if (!Get.isSnackbarOpen)
    //   MainFunctions.somethingWentWrongSnackBar();
    // }
  }

  signInAUser() async {
    var response = await Crud.postRequest(loginLink, {
      "username": userModel.getuserUserName,
      "password": userModel.getUserPassword
    });

    if (response != null && response["status"] == "success") {
      userModel.setUserID = response["data"]['id'].toString();
      Get.offAndToNamed("/ProfilePage");
    } else if (response != null && response["status"] == "fail") {
      loginError = true;
      update();
    } else {
      if (!Get.isSnackbarOpen) {
        MainFunctions.somethingWentWrongSnackBar();
      }
    }
  }
}
