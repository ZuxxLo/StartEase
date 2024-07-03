import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../main.dart';
import '../model/permissions_model.dart';

class PermissionsManagementController extends GetxController {
  List<Permissions> allPermissionsListNotAffich = [];
  List<Permissions> allPermissionsListToAffich = [];

  Permissions newPermission = Permissions();
  Future loadAllPermissions() async {
    allPermissionsListNotAffich.clear();
    allPermissionsListToAffich.clear();

    var response = await Crud.getRequest(permissionsLink);
    if (response != null && response["success"] == true) {
      allPermissionsListNotAffich =
          (PermissionsModel.fromJson(response).data?.permissions)!;
    }
    allPermissionsListToAffich = List.from(allPermissionsListNotAffich);
    for (var element in allPermissionsListNotAffich) {
      print(element.type);
    }

    update();
    return response;
  }

  void deletePermissionRequest(id) async {
    if (await MainFunctions.checkInternetConnection()) {
      allPermissionsListToAffich.forEach((element) async {
        if (element.id == id && element.rolesCount! == 0) {
          var response = await Crud.deleteRequest("$permissionsLink/$id");

          if (response != null && response["success"] == true) {
            MainFunctions.successSnackBar("permissionDeleted".tr);

            allPermissionsListNotAffich.removeWhere((element) {
              return element.id == id;
            });
            allPermissionsListToAffich.removeWhere((element) {
              return element.id == id;
            });

            update();
          } else {
            MainFunctions.somethingWentWrongSnackBar();
          }
        } else if (element.id == id && element.rolesCount! > 0) {
          MainFunctions.somethingWentWrongSnackBar("permissionUsed".tr);
        }
      });
    }

    update();
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
      allPermissionsListNotAffich.add(newPermission);
      allPermissionsListToAffich.add(newPermission);
      loadAllPermissions();
    } else if (response != null &&
        !response["success"] &&
        response["message"] == "The name has already been taken.") {
      MainFunctions.somethingWentWrongSnackBar("permissionNameTaken".tr);
    } else {
      MainFunctions.somethingWentWrongSnackBar();
    }
    update();
  }

  void addNewPermission() {
    Permissions newPermission =
        Permissions(rolesCount: 0, type: PermissionsType.customType);
    String newPermissionName = "";
    Get.defaultDialog(
        title: "newPermission1".tr,
        confirm: Column(
          children: [
            TextButton(
              onPressed: () {
                newPermission.name = newPermissionName;

                addPermissionsReq(newPermission);
                navigator!.pop();
              },
              child: Text("confirm".tr),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                navigator!.pop();
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
            return null;
          },
          onChanged: (value) {
            newPermissionName = value;
          },
        )));
  }

//Search ///////////////////////////////////
  String searchText = "";

  searchTextInput(inputSearch) {
    searchText = inputSearch;
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
}
