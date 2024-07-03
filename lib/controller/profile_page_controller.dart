import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../main.dart';

class ProfilePageController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final passwordFormKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final formKeyUpdatePhone = GlobalKey<FormState>();

  bool someError = false;

  bool securedPassword = true;
  String? newUsername = userModel.username;
  String? newPassword;
  String? oldPassword;
  String? newPhoneNumber; //= "+46731298920"
  String? codeSMS;
  bool smsEnabled = false;

  invertSecuredPassword() {
    securedPassword = !securedPassword;
    update();
  }

  inputoldPassword(String inputNewPassword) {
    oldPassword = inputNewPassword;
  }

  inputnewPassword(String inputNewPassword) {
    newPassword = inputNewPassword;
  }

  inputnewUsername(String inputnewUsername) {
    newUsername = inputnewUsername;
  }

//project_holder@gmail.com password

  void goToInformationsPage() {
    Get.toNamed("/ViewProfileInformations");
  }

  void goToChangePassword() {
    Get.toNamed("/ChangePassword");
  }

  void goToUpdatePhoneNumber() {
    Get.toNamed("/UpdatePhoneNumber");
  }

  sendSMSVerification() async {
    newPhoneNumber = "+31616193885";
    if (newPhoneNumber == userModel.phoneNumber) {
      MainFunctions.somethingWentWrongSnackBar("ownUsername".tr);
    } else {
      Get.defaultDialog(
          barrierDismissible: false,
          title: "pleaseWait".tr,
          content: const CircularProgressIndicator());
      var response = await Crud.postRequestAuth(updatePhoneNumberlink, {
        "phone_number": newPhoneNumber,
      });
      if (response != null && response["success"] == true) {
        print(response);
        smsEnabled = true;

        // userModel.phoneNumber = newPhoneNumber!;
        Get.back();
        MainFunctions.successSnackBar("enterSMS".tr);
      } else if (response != null && response["success"] == false) {
        someError = true;
        Get.back();
        MainFunctions.somethingWentWrongSnackBar();
      } else {
        Get.back();

        MainFunctions.somethingWentWrongSnackBar();
      }
    }
    update();
  }

  updatePhoneNumber() async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "pleaseWait".tr,
        content: const CircularProgressIndicator());
    var response = await Crud.postRequestAuth(updatePhoneNumberlink, {
      "phone_number": newPhoneNumber,
      "verif_code": codeSMS,
    });
    if (response != null && response["success"] == true) {
      userModel.phoneNumber = newPhoneNumber!;
      Get.back();
      MainFunctions.successSnackBar("phoneNumberUpdated".tr);
    } else if (response != null && response["success"] == false) {
      someError = true;
      Get.back();
      MainFunctions.somethingWentWrongSnackBar(response["message"]);
    } else {
      Get.back();

      MainFunctions.somethingWentWrongSnackBar();
    }
    update();
  }

  uploadPicture() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      status = await Permission.storage.request();
    } else if (status.isPermanentlyDenied) {
      Get.defaultDialog(
        title: "pleaseAllowPermissions".tr,
        content: TextButton(
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                    const Size(double.maxFinite, 45))),
            onPressed: () {
              openAppSettings();
            },
            child: Text("openAppSettings".tr)),
      );
    } else if (status.isGranted) {
      try {
        final image = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 85);
        if (image == null) return;
        MainFunctions.pickedImage = File(image.path);

        var size = MainFunctions.pickedImage?.readAsBytesSync().lengthInBytes;
        if (size! <= 2097152) {
          var response = await Crud.postRequestWithFile(
              "$usersLink/update/photo", {}, MainFunctions.pickedImage!);

          print(response);
          if (response != null && response["success"] == true) {
            // imageCache.clear();
            // PaintingBinding.instance.imageCache.clear();
            // imageCache.clearLiveImages();
            userModel.photoUrl = response["data"]["user"]["photo_url"];
            update();

            Get.forceAppUpdate();
          } else {
            MainFunctions.somethingWentWrongSnackBar("${response["message"]}");
          }
        } else {
          MainFunctions.somethingWentWrongSnackBar("imageTooBig".tr);
        }
      } catch (e) {
        MainFunctions.somethingWentWrongSnackBar("$e");
      }
    }
    Get.forceAppUpdate();

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

  confirm() async {
    if (newUsername == userModel.username) {
      MainFunctions.somethingWentWrongSnackBar("ownUsername".tr);
    } else {
      if (!Get.isSnackbarOpen) {
        Get.defaultDialog(
            barrierDismissible: false,
            title: "pleaseWait".tr,
            content: const CircularProgressIndicator());
        var response = await Crud.putRequest(updateUsernameLink, {
          "username": newUsername,
        });

        if (response != null && response["success"] == true) {
          userModel.username = newUsername!;
          Get.back();
          MainFunctions.successSnackBar("usernameUpdated".tr);
        } else if (response != null &&
            response["success"] == false &&
            response["message"] == "The username has already been taken.") {
          someError = true;
          Get.back();
          MainFunctions.somethingWentWrongSnackBar("usernameTaken".tr);
        } else {
          Get.back();

          if (!Get.isSnackbarOpen) {
            MainFunctions.somethingWentWrongSnackBar();
          }
        }
      }
    }
    update();
  }

  upadatePassword() async {
    if (!Get.isSnackbarOpen) {
      Get.defaultDialog(
          barrierDismissible: false,
          title: "pleaseWait".tr,
          content: const CircularProgressIndicator());
      var response = await Crud.putRequest(updatePasswordLink, {
        "current_password": oldPassword,
        "new_password": newPassword,
        "confirm_new_password": newPassword,
      });
      if (response != null && response["success"] == true) {
        Get.back();
        MainFunctions.successSnackBar("successResetPassword".tr);
      } else if (response != null &&
          response["success"] == false &&
          response["message"] == "Wrong password") {
        someError = true;
        Get.back();
        MainFunctions.somethingWentWrongSnackBar("wrongPassword".tr);

        update();
      } else {
        Get.back();

        if (!Get.isSnackbarOpen) {
          MainFunctions.somethingWentWrongSnackBar();
        }
      }
    }
    update();
  }

  @override
  void onInit() {
    print(userModel.roles);

    getBoolisInternetConnected();
    super.onInit();
  }
}
