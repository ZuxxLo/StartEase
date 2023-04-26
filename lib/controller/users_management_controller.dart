import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startease/backend/link_api.dart';
import 'package:startease/model/roles_model.dart';
import 'package:startease/model/user_model.dart';
import 'package:startease/view/user_details.dart';

import '../backend/crud.dart';
import '../main.dart';

class UsersManagementController extends GetxController {
  List<UserModel> allUsersList = [];
  UserModel? userDetails;
  List<Roles>? allRolesList = [];
  void goToAllUsers() {
    Get.toNamed("/AllUsers");

    loadAllUsers();
    loadAllRoles();
  }

  void goToCreateNewUser() {}

  Future loadAllUsers() async {
    allUsersList.clear();

    var response = await Crud.getRequest(usersLink);
    if (response != null && response["success"] == true) {
      for (var i = 0; i < response["data"]["users"].length; i++) {
        allUsersList.add(UserModel.fromJsonS(response["data"]["users"][i]));
      }
    }

    update();
  }

  void goToUserDetails(index) {
    allRolesList?.forEach((element) {
      element.value = false;
    });
    Get.toNamed("/UserDetails");
    userDetails = allUsersList[index];

    userDetails?.roles?.forEach((element) {
      element.value = true;
      print(element.name);
      for (var elementt in allRolesList!) {
        if (elementt.id == element.id) {
          elementt.value = true;
        }
      }
    });
  }

  Future<void> enableDisable() async {
    print(userDetails?.isEnabled);
    if (userDetails?.isEnabled == 0) {
      if (await MainFunctions.checkInternetConnection()) {
        var response =
            await Crud.putRequest("$usersLink/enable/${userDetails?.id}", {});
        print(response);
        if (response != null && response["success"] == true) {
          userDetails?.isEnabled = 1;
          MainFunctions.successSnackBar("accountEnabled".tr);
        } else {
          MainFunctions.somethingWentWrongSnackBar();
        }
      }
    } else if (userDetails?.isEnabled == 1) {
      if (await MainFunctions.checkInternetConnection()) {
        var response =
            await Crud.putRequest("$usersLink/disable/${userDetails?.id}", {});
        print(response);
        if (response != null && response["success"] == true) {
          MainFunctions.successSnackBar("accountDisabled".tr);
          userDetails?.isEnabled = 0;
        } else {
          MainFunctions.somethingWentWrongSnackBar();
        }
      }
    }
    update();
  }

  loadAllRoles() async {
    allRolesList?.clear();
    var response = await Crud.getRequest(roleLink);
    if (response != null && response["success"] == true) {
      allRolesList = RolesModel.fromJson(response).data?.roles;
      if (allRolesList == []) {
        allRolesList?.add(Roles(id: -77, name: "error77empty"));
      }
    }

    update();
  }

  Future<void> confirm() async {
    List<int> tempList = [];
    allRolesList?.forEach((element) {
      if (element.value!) {
        tempList.add(element.id!);
      }
    });
    if (await MainFunctions.checkInternetConnection()) {
      var response = await Crud.putRequest("$usersLink/update/roles",
          {"user": userDetails?.id, "roles": tempList});

      print(response);
      if (response != null && response["success"] == true) {
        loadAllUsers();
         MainFunctions.successSnackBar("updatedSuccess".tr);
       } else {
        MainFunctions.somethingWentWrongSnackBar();
      }
    }
  }

  void changeRoleValue(int index, bool value) {
    allRolesList?[index].value = value;

    update();
  }
}
