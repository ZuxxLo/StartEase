import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startease/main.dart';
import 'package:startease/model/permissions_model.dart';

import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../model/roles_model.dart';

class AllRolesController extends GetxController {
  List<Roles>? rolesListNotAffich = [];
  List<Roles>? rolesListToAffich = [];
  List<Permissions> allPermissionsListNotAffich = [];
  List<Permissions> allPermissionsListToAffich = [];
  Roles roleDetail = Roles();

  loadAllRoles() async {
    rolesListNotAffich?.clear();
    rolesListToAffich?.clear();
    var response = await Crud.getRequest(roleLink);
    print(response);
    if (response != null && response["success"] == true) {
      rolesListNotAffich = RolesModel.fromJson(response).data?.roles;
      if (rolesListNotAffich == []) {
        rolesListNotAffich?.add(Roles(id: -77, name: "error77empty"));
      }
    }

    rolesListToAffich = List.from(rolesListNotAffich!);
    print(rolesListToAffich!.length);

    update();
  }

  loadAllPermissions() async {
    allPermissionsListNotAffich.clear();
    allPermissionsListToAffich.clear();

    var response = await Crud.getRequest(permissionsLink);
    if (response != null && response["success"] == true) {
      allPermissionsListNotAffich =
          (PermissionsModel.fromJson(response).data?.permissions)!;
    }
    allPermissionsListToAffich = List.from(allPermissionsListNotAffich);

    update();
  }

  Future<void> editRole(index) async {
    if (await MainFunctions.checkInternetConnection()) {
      roleDetail = rolesListNotAffich![index];

      allPermissionsListNotAffich.clear();
      allPermissionsListToAffich.clear();

      var response = await Crud.getRequest(permissionsLink);
      if (response != null && response["success"] == true) {
        allPermissionsListNotAffich =
            (PermissionsModel.fromJson(response).data?.permissions)!;
      }

      roleDetail.permissions?.forEach((element) {
        element.value = true;
        for (var elementt in allPermissionsListNotAffich) {
          if (elementt.id == element.id) {
            elementt.value = true;
          }
        }
      });
      allPermissionsListToAffich = List.from(allPermissionsListNotAffich);

      Get.toNamed(
        "/EditRole",
      );
    }
    update();
  }

  void deleteRole(id) async {
    if (await MainFunctions.checkInternetConnection()) {
      rolesListToAffich?.forEach((element) async {
        if (element.id == id && element.usersCount == 0) {
          var response = await Crud.deleteRequest("$roleLink/$id");
          if (response != null && response["success"] == true) {
            MainFunctions.successSnackBar("roleDeleted".tr);

            rolesListNotAffich?.removeWhere((element) {
              return element.id == id;
            });
            rolesListToAffich?.removeWhere((element) {
              return element.id == id;
            });
            update();
          } else {
            MainFunctions.somethingWentWrongSnackBar();
          }
        } else if (element.id == id && element.usersCount! > 0) {
          MainFunctions.somethingWentWrongSnackBar("roleUsed".tr);
        }
      });
    }

    update();
  }

  changePermissionValue(int index, bool value) {
    if (index < roleDetail.permissions!.length) {
      roleDetail.permissions![index].value = value;
    }
    allPermissionsListNotAffich[index].value = value;
    allPermissionsListToAffich[index].value = value;
    update();
  }

  updateRolePermissions() async {
    if (await MainFunctions.checkInternetConnection()) {
      var response = await Crud.putRequest(roleLink,
          roleDetail.toJsonUpdate(roleDetail.id!, allPermissionsListNotAffich));
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
            return null;
          },
          onChanged: (value) {
            newPermissionName = value;
          },
        )));
  }

//Search ///////////////////////////////////
  String searchText = "";
  String searchTextPermission = "";

  searchTextInput(inputSearch) {
    searchText = inputSearch;
  }

  searchTextInputPermission(inputSearch) {
    searchTextPermission = inputSearch;
  }

  searchRole(String inputSearch) {
    rolesListToAffich = List.from(rolesListNotAffich!);

    rolesListToAffich?.removeWhere((element) {
      return (!(element.name)!.contains(inputSearch));
    });

    if (rolesListToAffich!.isEmpty) {
      rolesListToAffich = List.from(rolesListNotAffich!);

      rolesListToAffich?.removeWhere((element) {
        return (!(element.name)!.startsWith(inputSearch));
      });
    }

    if (rolesListToAffich!.isEmpty) {
      rolesListToAffich = List.from(rolesListNotAffich!);

      rolesListToAffich?.removeWhere((element) {
        return (!(element.name)!.endsWith(inputSearch));
      });
    }

    update();
  }

  searchPermission(String inputSearch) {
    allPermissionsListToAffich = List.from(allPermissionsListNotAffich);

    allPermissionsListToAffich.removeWhere((element) {
      return (!(element.name)!.contains(inputSearch));
    });

    if (allPermissionsListToAffich.isEmpty) {
      allPermissionsListToAffich = List.from(allPermissionsListNotAffich);

      allPermissionsListToAffich.removeWhere((element) {
        return (!(element.name)!.startsWith(inputSearch));
      });
    }

    if (allPermissionsListToAffich.isEmpty) {
      allPermissionsListToAffich = List.from(allPermissionsListNotAffich);

      allPermissionsListToAffich.removeWhere((element) {
        return (!(element.name)!.endsWith(inputSearch));
      });
    }

    update();
  }

  //Search ///////////////////////////////////

  @override
  void onInit() {
    loadAllRoles();
    super.onInit();
  }
}
