import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../main.dart';

class SignUpController extends GetxController {
  List steps = [
    1,
    2,
    3,
  ];
  int currentStepIndex = 0;
  bool smsEnabled = false;
  PageController pageController = PageController(keepPage: true);
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String? birthday;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;
  String? birthplace;
  String? phoneNumber;
  String? password;

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();

  bool securedPassword = true;
  void enableSMS() {}

  inputUserName(String value) {
    userName = value;
    update();
  }

  inputFirstName(String value) {
    firstName = value;
    update();
  }

  inputLastName(String value) {
    lastName = value;
    update();
  }

  inputBirthday(DateTime value) {
    birthday = dateFormat.format(value);
    update();
  }

  inputBirthplace(String value) {
    birthplace = value;
    update();
  }

  inputPhoneNumber(String value) {
    phoneNumber = value;
    update();
  }

  inputEmail(String value) {
    email = value;
  }

  String? emailValidator(String? inputEmail) {
    if (email != null) {
      inputEmail = email;
    }
    if (inputEmail!.isEmpty) {
      return "enterAnEmail".tr;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(inputEmail)) {
      return "enterValidEmail".tr;
    }

    return null;
  }

  invertSecuredPassword() {
    securedPassword = !securedPassword;
    update();
  }

  void inputPassword(String inputPassword) {
    password = inputPassword;
  }

  next() {
    currentStepIndex++;
    pageController.animateToPage(currentStepIndex,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);

    update();
  }

  void goBackPageView() {
    currentStepIndex--;

    pageController.animateToPage(currentStepIndex,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);

    update();
  }

  signUp() async {
    Get.defaultDialog(
        title: "pleaseWait".tr, content: const CircularProgressIndicator());

    if (await MainFunctions.checkInternetConnection()) {
      var response = await Crud.postRequest(usersLink, {
        "username": userName,
        "email": email,
        "password": password,
        "confirm_password": password,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "birthday": birthday,
        "birth_place": birthplace,
        "roles": []
      });

      if (response != null && response["success"] == true) {
        Get.back();
        Get.back();

        MainFunctions.successSnackBar("signUpSuccess".tr);
        // if (MainFunctions.sharredPrefs?.getString("authToken") == null) {
        //   Get.toNamed("/Login");
        // } else {}
      } else {
        Get.back();

        MainFunctions.somethingWentWrongSnackBar("${response["message"]}");
      }
    }
  }

  uploadPicture() async {
    signUp();
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

          if (response != null && response["success"] == true) {
            imageCache.clear();
            PaintingBinding.instance.imageCache.clear();

            imageCache.clearLiveImages();
          } else {
            MainFunctions.somethingWentWrongSnackBar("${response["message"]}");
          }
        } else {
          MainFunctions.somethingWentWrongSnackBar("image too big");
        }
      } catch (e) {
        MainFunctions.somethingWentWrongSnackBar("$e");
      }
    }

    update();
  }
}
