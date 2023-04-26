import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../main.dart';
import '../model/permissions_model.dart';

class PermissionsManagementController extends GetxController {
  List<Permissions> allPermissionsList = [];
  Permissions newPermission = Permissions();
  Future loadAllPermissions() async {
    allPermissionsList.clear();
    var response = await Crud.getRequest(permissionsLink);
    if (response != null && response["success"] == true) {
      allPermissionsList =
          (PermissionsModel.fromJson(response).data?.permissions)!;
    }

    update();
    return response;
  }

  void deletePermissionRequest(id) async {
    if (await MainFunctions.checkInternetConnection()) {
      var response = await Crud.deleteRequest("$permissionsLink/$id");
      if (response != null && response["success"] == true) {
        MainFunctions.successSnackBar("permissionDeleted".tr);

        allPermissionsList.removeWhere((element) {
          return element.id == id;
        });
      } else {
        MainFunctions.somethingWentWrongSnackBar();
      }
    }

    update();
  }

  void deletePermission(id) {
    if (!Get.isDialogOpen!) {
      Get.defaultDialog(
          title: "areUSure".tr,
          content: Column(
            children: [
              TextButton(
                  onPressed: () {
                    deletePermissionRequest(id);
                    Get.back();
                  },
                  child: Text("confirm".tr)),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("cancel".tr)),
            ],
          ));
    }
  }

  @override
  void onInit() {
    loadAllPermissions();

    super.onInit();
  }

  addPermissionsReq(Permissions newPermission) async {
    var response = await Crud.postRequest(
        permissionsLink,
        newPermission.toJson(
          newPermission,
        ));
    if (response != null && response["success"]) {
      MainFunctions.successSnackBar("permissionCreated".tr);
      allPermissionsList.add(newPermission);
    } else if (response != null &&
        !response["success"] &&
        response["message"] == "The name has already been taken.") {
      MainFunctions.somethingWentWrongSnackBar("permissionNameTaken".tr);
    } else {
      print(response);
      MainFunctions.somethingWentWrongSnackBar();
    }
    update();
  }

  void addNewPermission() {
    Permissions newPermission = Permissions();
    String newPermissionName = "";
    Get.defaultDialog(
        title: "newPermission1".tr,
        confirm: Column(
          children: [
            TextButton(
              onPressed: () {
                newPermission.name = newPermissionName;
                addPermissionsReq(newPermission);
                Get.back();
              },
              child: Text("confirm".tr),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("cancel".tr),
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
}
