import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startease/controller/role_management_controller.dart';
import 'package:startease/controller/users_management_controller.dart';
import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../Themes/themes.dart';
import '../main.dart';

class HomeScreenController extends GetxController {
  int _currentBottomBarIndex = 0;

  int currentBottomBarIndex() {
    return _currentBottomBarIndex;
  }

  switchBetweenScreens(index) async {
    if (index == 0) {
      _currentBottomBarIndex = index;
    }
    if (index == 1) {
      _currentBottomBarIndex = index;
      Get.put(UsersManagementController());
    }

    if (index != 1) {}
    if (index != 2) {}

    update();
  }

  @override
  void onInit() {
    Get.put(RoleManagemenetController());
    super.onInit();
  }

  void signOut() async {
    Get.defaultDialog(
        title: "pleaseWait".tr, content: const CircularProgressIndicator());

    var response = await Crud.postRequest(signoutLink, {});

    if (response != null) {
      MainFunctions.sharredPrefs?.clear();

      Get.offAllNamed("/Login");

      Get.back();
    } else {
      if (!Get.isSnackbarOpen) {

        MainFunctions.somethingWentWrongSnackBar(); //voxeee  //Password#0
      }
    }
  }

  void aboutUs() {}

  void goToProfil() {
    Get.toNamed("/ProfilePage");
  }

  String localeValue = MainFunctions.sharredPrefs!.getString("codeLang") ??
      Get.deviceLocale!.languageCode;
  setLanguage() {
    Get.defaultDialog(
        title: "language".tr,
        content: Column(
          children: [
            TextButton(
                onPressed: () {
                  localeValue = "fr";
                  Get.updateLocale(const Locale("fr"));
                  MainFunctions.sharredPrefs!
                      .setString("codeLang", localeValue);
                  Get.back();
                },
                child: Text("francais".tr)),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  localeValue = "en";
                  Get.updateLocale(const Locale("en"));
                  MainFunctions.sharredPrefs!
                      .setString("codeLang", localeValue);
                  Get.back();
                },
                child: Text("english".tr)),
          ],
        ));

    update();
  }

  void setDarkTheme() {
 
    Get.defaultDialog(
        title: "theme".tr,
        content: Column(
          children: [
            TextButton(
                onPressed: () {
                  Get.changeTheme(Themes.customLightTheme);
                  MainFunctions.sharredPrefs!.setBool("isDarkTheme", false);
                  Get.back();
                },
                child: Text("lightTheme".tr)),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Get.changeTheme(Themes.customDarkTheme);
                  MainFunctions.sharredPrefs!.setBool("isDarkTheme", true);
                  Get.back();
                },
                child: Text("darkTheme".tr)),
          ],
        ));

    update();
  }
}
