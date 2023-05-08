import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/main.dart';
import 'package:startease/model/user_model.dart';

class ProjectManagementController extends GetxController {
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  bool isEditingProject = false;
  int currentPageViewIndex = 0;
  String? newRemarkText;
  PageController pageController = PageController(keepPage: true);
  List<UserModel> projectTeamList = [userModel, userModel, userModel];
  var fileList = [];
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  List<String> domicileEstabList = <String>[
    'Soumission',
    'Revision',
    'Skrt',
    'Zuxx'
  ];
  List<String> projectTypeList = <String>[
    'Soumission',
    'Revision',
    'Skrt',
    'Zuxx'
  ];

  var statusList = [
    "approved".tr,
    "pending".tr,
    "refused".tr,
    "recourse".tr,
  ];

  Color getStatusColor(String status) {
    if (status == "approved".tr) {
      return greenColor;
    } else if (status == "pending".tr) {
      return yellowColor;
    } else if (status == "refused".tr) {
      return redColor.withOpacity(0.8);
    } else if (status == "recourse".tr) {
      return orangeColor;
    } else {
      return lightBlueColor;
    }
  }

  enableEditProject() {
    isEditingProject = !isEditingProject;
    update();
  }

  goToViewMyProject() {
    currentPageViewIndex = 0;
    isEditingProject = false;
    fileList.clear();
    //load file list from api
    Get.toNamed("/ViewProject");
  }

  void goToEditMyProject() {}

  goToRemarks() {
    Get.toNamed("/ViewRemarks");
  }

  void inputDomicileEstab(String? newValue) {}

  void inputTrademarkName(String? value) {}

  void inputSummary(String? value) {}

  next() {
    if (currentPageViewIndex < 3) {
      currentPageViewIndex++;
      pageController.animateToPage(currentPageViewIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    }

    update();
  }

  void goBackPageView() {
    currentPageViewIndex--;

    pageController.animateToPage(currentPageViewIndex,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);

    update();
  }

  importFiles() async {
    // only from UI
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
              Get.back();
              openAppSettings();
            },
            child: Text("openAppSettings".tr)),
      );
    } else if (status.isGranted) {
      try {
        final files = await FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ["pdf", "docx"]);
        if (files == null) return;

        files.files.forEach((element) {
          fileList.add(element);
          print(element.name);
          print(element.size);
          print(element.path);
          print(File(element.path!));
        });
      } catch (e) {
        print(e);
      }
    }

    update();
  }

  deleteFile(int index) {
    fileList.removeAt(index); // only from UI

    update();
  }

  void inputNewRemark(String? inputText) {
    newRemarkText = inputText;
  }

  // this function depends on the date on the user phone
  String affichageDaysAgo(DateTime dateTime) {
    if (DateTime.now().day - dateTime.day < 8 &&
        DateTime.now().month - dateTime.month == 0) {
      int dateDifference = DateTime.now().day - dateTime.day;
      return "daysAgo".trParams({"daysAgo": dateDifference.toString()});
    } else {
      return dateFormat.format(dateTime);
    }
  }

  void addANewRemark() {
    navigator!.pop();

    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  void goToProjectObserv() {}

  void goToComments() {}

  void goToTasks() {}

  void updateProgressBar() {}
}
