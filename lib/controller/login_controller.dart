import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../main.dart';
import '../model/user_model.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  bool securedPassword = true;
  bool loginError = false;
  setUserPassword(inputPassword) {
    password = inputPassword;
    loginError = false;
  }

  setUserEmail(inputEmail) {
    userModel.email = inputEmail;
    loginError = false;
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

  String password = "password";
  signInAUser() async {
    Get.defaultDialog(
        title: "pleaseWait".tr, content: const CircularProgressIndicator());

    var response = await Crud.postRequest(
        loginLink, {"email": userModel.email, "password": password});
    var tempList = [];
    if (response != null &&
        response["success"] == true &&
        response["message"] == "Login succesfull") {
      for (var element in response["data"]["user"]["roles"]) {
        tempList.add(element["id"]);
      }

      if (tempList.contains(1)) {
        MainFunctions.sharredPrefs
            ?.setString("authToken", response["data"]["token"]);
        userModel = UserModel.fromJson(response);
        MainFunctions.sharredPrefs?.setString("email", userModel.email!);
        MainFunctions.sharredPrefs?.setString("password", password);
        Get.back();
        Get.offAndToNamed("/HomeScreen");
      } else {
        Get.back();

        MainFunctions.somethingWentWrongSnackBar("onlyAdmin".tr);
      }
    } else if (response != null &&
        response["success"] == false &&
        response["message"] ==
            "Your account is disabled. Please contact the admin") {
      Get.back();

      MainFunctions.somethingWentWrongSnackBar(response["message"]);
    } else if (response != null && response["success"] == false) {
      Get.back();
      loginError = true;
      update();
    } else {
      if (!Get.isSnackbarOpen) {
        MainFunctions.somethingWentWrongSnackBar();
      }
    }
  }
}
