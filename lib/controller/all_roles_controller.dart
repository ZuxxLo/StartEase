import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startease/main.dart';
import 'package:startease/model/permissions_model.dart';

import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../model/roles_model.dart';

class AllRolesController extends GetxController {
  List<Roles>? rolesList = [];
  Roles roleDetail = Roles();
  List<Permissions> allPermissionsList = [];

  loadAllRoles() async {
    rolesList?.clear();
    var response = await Crud.getRequest(roleLink);
    if (response != null && response["success"] == true) {
      rolesList = RolesModel.fromJson(response).data?.roles;
      if (rolesList == []) {
        rolesList?.add(Roles(id: -77, name: "error77empty"));
      }
    }
    update();
  }

  loadAllPermissions() async {
    allPermissionsList.clear();
    var response = await Crud.getRequest(permissionsLink);
    if (response != null && response["success"] == true) {
      allPermissionsList =
          (PermissionsModel.fromJson(response).data?.permissions)!;
    }

    update();
  }

  Future<void> editRole(index) async {
    if (await MainFunctions.checkInternetConnection()) {
      roleDetail = rolesList![index];

      allPermissionsList.clear();
      var response = await Crud.getRequest(permissionsLink);
      if (response != null && response["success"] == true) {
        allPermissionsList =
            (PermissionsModel.fromJson(response).data?.permissions)!;
      }

      roleDetail.permissions?.forEach((element) {
        element.value = true;
        for (var elementt in allPermissionsList) {
          if (elementt.id == element.id) {
            elementt.value = true;
          }
        }
      });

       Get.toNamed(
        "/EditRole",
      );
    }
    update();
  }

  void deleteRole(id) async {
    if (await MainFunctions.checkInternetConnection()) {
      var response = await Crud.deleteRequest("$roleLink/$id");
      if (response != null && response["success"] == true) {
        MainFunctions.successSnackBar("roleDeleted".tr);

        rolesList?.removeWhere((element) {
          return element.id == id;
        });
      } else {
        MainFunctions.somethingWentWrongSnackBar();
      }
    }

    update();
  }

  changePermissionValue(int index, bool value) {
    if (index < roleDetail.permissions!.length) {
      roleDetail.permissions![index].value = value;
    }
    allPermissionsList[index].value = value;
    update();
  }

  updateRolePermissions() async {
    if (await MainFunctions.checkInternetConnection()) {
      var response = await Crud.putRequest(roleLink,
          roleDetail.toJsonUpdate(roleDetail.id!, allPermissionsList));
      if (response != null && response["success"] == true) {
        Get.back();
        MainFunctions.successSnackBar("roleUpdated".tr);
        loadAllRoles();
      } else {
        MainFunctions.somethingWentWrongSnackBar();
      }
    }
  }

  void qosdqsdqds() {
    Permissions newPermission = Permissions();
    String newPermissionName = "";
    Get.defaultDialog(
        title: "newPermission1".tr,
        confirm: Column(
          children: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("cancel".tr),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                newPermission.name = newPermissionName;
                newPermission.value = true;
              },
              child: Text("confirm".tr),
            ),
          ],
        ),
        content: Form(
            child: TextFormField(
          decoration: InputDecoration(hintText: "newPermission2".tr),
          validator: (value) {
            if (value!.isEmpty) {
              return "newPermission1".tr;
            }
          },
          onChanged: (value) {
            newPermissionName = value;
          },
        )));
  }

  @override
  void onInit() {
    loadAllRoles();
    super.onInit();
  }
}
