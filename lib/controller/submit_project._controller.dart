import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startease/model/project_model.dart';

import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../main.dart';
import '../model/user_model.dart';

class SubmitProjectController extends GetxController {
  PageController pageController = PageController(keepPage: true);
  ProjectModel newProject = ProjectModel(members: []);
  int currentPageViewIndex = 0;

  List<String> projectTypesList = <String>[
    "Un diplôme-Une startup",
    "Un diplôme-Un Brevet"
  ];

  next() {
    if (currentPageViewIndex < 2) {
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

  String? searchText = "";
  void searchTextInput(String inputSearch) {
    searchText = inputSearch;
  }

  void addAProjectMember(String searchText) {
    if (newProject.members!.length < 5) {
      bool canAdd = true;
      for (UserModel element in newProject.members!) {
        if (element.email == searchText) {
          canAdd = false;
        }
      }
      if (canAdd) {
        newProject.members?.add(UserModel(
            id: 77,
            username: searchText,
            email: searchText,
            phoneNumber: "",
            photoUrl: "http://localhost:8000/images/users/default.png",
            personType: "",
            isEnabled: 1,
            roles: [],
            permissions: [],
            person: null,
            token: null));
        navigator!.pop();
      } else {
        MainFunctions.somethingWentWrongSnackBar("alreadyHaveThismember".tr);
      }
    }

    update();
  }

  deleteAProjectMember(UserModel userModel) {
    newProject.members?.removeWhere((element) {
      return element.email == userModel.email;
    });

    update();
  }

  void addAProjectSupervisor(String searchText) {
    if (newProject.coSupervisor?.email != searchText) {
      newProject.supervisor = UserModel(
          id: 77,
          username: searchText,
          email: searchText,
          phoneNumber: "",
          photoUrl: "http://localhost:8000/images/users/default.png",
          personType: "",
          isEnabled: 1,
          roles: [],
          permissions: [],
          person: null,
          token: null);
      navigator!.pop();
    } else {
      MainFunctions.somethingWentWrongSnackBar("visorIsntCovisor".tr);
    }

    update();
  }

  void deleteAProjectSupervisor() {
    newProject.supervisor = null;

    update();
  }

  void addAProjectCoSupervisor(String searchText) {
    if (newProject.supervisor?.email != searchText) {
      newProject.coSupervisor = UserModel(
          id: 77,
          username: searchText,
          email: searchText,
          phoneNumber: "",
          photoUrl: "http://localhost:8000/images/users/default.png",
          personType: "",
          isEnabled: 1,
          roles: [],
          permissions: [],
          person: null,
          token: null);
      navigator!.pop();
    } else {
      MainFunctions.somethingWentWrongSnackBar("visorIsntCovisor".tr);
    }
    update();
  }

  void deleteAProjectCoSupervisor() {
    newProject.coSupervisor = null;

    update();
  }

  Future<void> submitProject() async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "pleaseWait".tr,
        content: const CircularProgressIndicator());
    print(newProject.toJson());
    var response = await Crud.postRequest(projectsLink, newProject.toJson());
    if (response != null && response["success"] == true) {
      navigator!.pop();
      Get.back();
      MainFunctions.successSnackBar("projctAdded".tr);
    } else if (response != null && response["success"] == false) {
      Get.back();
      MainFunctions.somethingWentWrongSnackBar(response["message"]);
    } else {
      Get.back();
      MainFunctions.somethingWentWrongSnackBar();
    }
    update();
  }
}
