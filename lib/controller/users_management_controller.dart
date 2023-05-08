import 'package:get/get.dart';
import 'package:startease/backend/link_api.dart';
import 'package:startease/model/roles_model.dart';
import 'package:startease/model/user_model.dart';

import '../backend/crud.dart';
import '../main.dart';

class UsersManagementController extends GetxController {
  List<UserModel> allUsersListNotAffich = [];
  List<UserModel> allUsersListToAffich = [];
  String searchText = "";

  UserModel? userDetails;
  List<Roles>? rolesListNotAffich = [];
  List<Roles>? rolesListToAffich = [];
  void goToAllUsers() {
    Get.toNamed("/AllUsers");
    searchText = "";
    loadAllUsers();
    loadAllRoles();
  }

  void goToCreateNewUser() {
    Get.toNamed("/SignUp");
  }

  loadAllUsers() async {
    allUsersListNotAffich.clear();
    allUsersListToAffich.clear();

    var response = await Crud.getRequest(usersLink);

    print(response);

    if (response != null && response["success"] == true) {
      for (var i = 0; i < response["data"]["users"].length; i++) {
        allUsersListNotAffich
            .add(UserModel.fromJsonS(response["data"]["users"][i]));
      }

      allUsersListNotAffich.removeWhere((element) =>
          element.id ==
          userModel
              .id); // do not display the current account for security purpose
    } else {
      loadAllUsers();
      print("load users error*/*/*/*/*/*/*/*/*/*/*/**//*/*/*/*/*");
    }

    allUsersListToAffich = List.from(allUsersListNotAffich);
    update();
  }

  void goToUserDetails(index) {
    searchTextRole = "";
    rolesListNotAffich?.forEach((element) {
      element.value = false;
    });
    Get.toNamed("/UserDetails");
    userDetails = allUsersListNotAffich[index];
    print(userDetails!.photoUrl);

    userDetails?.roles?.forEach((element) {
      element.value = true;
      for (var elementt in rolesListNotAffich!) {
        if (elementt.id == element.id) {
          elementt.value = true;
        }
      }
    });

    rolesListToAffich = List.from(rolesListNotAffich!);
  }

  Future<void> enableDisable() async {
    if (userDetails?.isEnabled == 0) {
      if (await MainFunctions.checkInternetConnection()) {
        var response =
            await Crud.putRequest("$usersLink/enable/${userDetails?.id}", {});
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
    rolesListNotAffich?.clear();
    var response = await Crud.getRequest(roleLink);
    if (response != null && response["success"] == true) {
      rolesListNotAffich = RolesModel.fromJson(response).data?.roles;
      if (rolesListNotAffich == []) {
        rolesListNotAffich?.add(Roles(id: -77, name: "error77empty"));
      }
    }
    rolesListToAffich = List.from(rolesListNotAffich!);
    update();
  }

  Future<void> confirm() async {
    List<int> tempList = [];
    rolesListNotAffich?.forEach((element) {
      if (element.value!) {
        tempList.add(element.id!);
      }
    });
    if (await MainFunctions.checkInternetConnection()) {
      var response = await Crud.putRequest("$usersLink/update/roles",
          {"user": userDetails?.id, "roles": tempList});

      if (response != null && response["success"] == true) {
        loadAllUsers();
        MainFunctions.successSnackBar("updatedSuccess".tr);
      } else {
        MainFunctions.somethingWentWrongSnackBar();
      }
    }
  }

  void changeRoleValue(int index, bool value) {
    rolesListNotAffich?[index].value = value;
    rolesListToAffich?[index].value = value;

    update();
  }

  searchTextInput(inputSearch) {
    searchText = inputSearch;
  }

  String searchTextRole = "";

  searchTextInputRole(inputSearch) {
    searchTextRole = inputSearch;
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

  searchUser(String inputSearch) {
    allUsersListToAffich = List.from(allUsersListNotAffich);

    allUsersListToAffich.removeWhere((element) {
      return (!("${element.username}").contains(inputSearch));
    });

    if (allUsersListToAffich.isEmpty) {
      allUsersListToAffich = List.from(allUsersListNotAffich);

      allUsersListToAffich.removeWhere((element) {
        return (!("${element.username}}").startsWith(inputSearch));
      });
    }

    if (allUsersListToAffich.isEmpty) {
      allUsersListToAffich = List.from(allUsersListNotAffich);

      allUsersListToAffich.removeWhere((element) {
        return (!("${element.username}").endsWith(inputSearch));
      });
    }

    update();
  }
}
