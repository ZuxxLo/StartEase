import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startease/backend/link_api.dart';
import 'package:startease/main.dart';
import 'package:startease/model/permissions_model.dart';
import 'package:startease/model/roles_model.dart';

import '../backend/crud.dart';

class CreateRoleController extends GetxController {
  int currentStepIndex = 0;
  List steps = [1, 2, 3];
  Roles role = Roles();
  String roleName = "";
  final roleNameFormKey = GlobalKey<FormState>();

  PageController pageController = PageController(
    keepPage: true,
  );
  List<Permissions> permissionsList = [];

  changePermissionValue(int index, bool value) {
    permissionsList[index].value = value;
    update();
  }

  changeStepCurrentIndex(int value) {
    currentStepIndex = value;
    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void start() {
    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);
  }

  void loadPermissions() {
    pageController.animateToPage(2,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);
  }

  next() async {
    var response = await Crud.getRequest(permissionsLink);
    if (response != null && response["success"] == true) {
      permissionsList =
          (PermissionsModel.fromJson(response).data?.permissions)!;
    }
    pageController.animateToPage(2,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);

    update();
  }

  Future<void> submit() async {
    if (permissionsList
        .where((element) {
          return element.value == true;
        })
        .toList()
        .isNotEmpty) {
      var response = await Crud.postRequest(
          roleLink,
          role.toJson(
              roleName,
              permissionsList.where((element) {
                return element.value == true;
              }).toList()));
      if (response != null && response["success"]) {
        MainFunctions.successSnackBar("roleCreated".tr);
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 250), curve: Curves.ease);
      } else if (response != null &&
          !response["success"] &&
          response["message"] == "The name has already been taken.") {
        MainFunctions.somethingWentWrongSnackBar("roleNameTaken".tr);
        roleName = "";
        role.name = "";
        pageController.animateToPage(1,
            duration: const Duration(milliseconds: 250), curve: Curves.ease);
      } else {
        MainFunctions.somethingWentWrongSnackBar();
      }
    } else {
      MainFunctions.somethingWentWrongSnackBar("addPermissions".tr);
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onReady();
  }

  void roleNameInput(String value) {
    roleName = value;
    role.name = roleName;
  }
}
