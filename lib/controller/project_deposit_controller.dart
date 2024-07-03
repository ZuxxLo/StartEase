import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:startease/main.dart';
import 'package:startease/model/project_model.dart';

import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../model/user_model.dart';

class ProjectDepositController extends GetxController {
  ProjectModel projectData = ProjectModel(members: []);
  int currentPageViewIndex = 0;
  PageController pageController = PageController(keepPage: true);
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  var fileList = [];
  List<String> projectTypesList = <String>[
    'diplomaStartUp'.tr,
    'diplomaPatent'.tr
  ];

  void goBackPageView() {
    currentPageViewIndex--;

    pageController.animateToPage(currentPageViewIndex,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);

    update();
  }

  next() {
    if (currentPageViewIndex < 2) {
      currentPageViewIndex++;
      pageController.animateToPage(currentPageViewIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    }

    update();
  }

  void inputProjectType(String? type) {
    projectData.type = type;
  }

  void inputDomicileEstab(String? establishment) {
    projectData.establishment?.name = establishment;
  }

  void inputTrademarkName(String? trademarkName) {
    projectData.trademarkName = trademarkName;
  }

  void inputScientificName(String? scientificName) {
    projectData.scientificName = scientificName;
  }

  void inputSummary(String? resume) {
    projectData.resume = resume;
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

        for (var element in files.files) {
          fileList.add(element);
          print(element.name);
          print(element.size);
          print(element.path);
          print(File(element.path!));

          // projectData.files?.addAll({"file ": "element"});
        }
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

  ///////////////////////functions to use for register later
  List<Establishment> establishmentsList = [];
  loadEstablishments() async {
    var response = await Crud.getRequest(establishmentsLink);
    if (response != null && response["success"] == true) {
      print(response);
      if (response["data"]['establishments'] != null) {
        response["data"]['establishments'].forEach((v) {
          establishmentsList.add(Establishment.fromJson(v));
        });
      }
    }
    print(establishmentsList.length);
  }

  List<Establishment> filieresList = [];
  loadFilieres() async {
    var response = await Crud.getRequest(filieresLink);
    if (response != null && response["success"] == true) {
      print(response);
      if (response["data"]['filieres'] != null) {
        response["data"]['filieres'].forEach((v) {
          filieresList.add(Establishment.fromJson(v));
        });
      }
    }
    print(filieresList.length);
  }

  List<Establishment> gradesList = [];
  loadGrades() async {
    var response = await Crud.getRequest(gradesLink);
    if (response != null && response["success"] == true) {
      print(response);
      if (response["data"]['grades'] != null) {
        response["data"]['grades'].forEach((v) {
          gradesList.add(Establishment.fromJson(v));
        });
      }
    }
    print(gradesList.length);
  }

  List<Establishment> specialitiesList = [];
  loadSpecialities() async {
    var response = await Crud.getRequest(specialitiesLink);
    if (response != null && response["success"] == true) {
      print(response);
      if (response["data"]['specialities'] != null) {
        response["data"]['specialities'].forEach((v) {
          specialitiesList.add(Establishment.fromJson(v));
        });
      }
    }
    print(specialitiesList.length);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  String? searchText = "";

  void searchTextInput(String inputSearch) {
    searchText = inputSearch;
  }

  void addAProjectMember(String searchText) {
    if (projectData.members!.length < 6) {
      bool canAdd = true;
      for (UserModel element in projectData.members!) {
        if (element.email == searchText) {
          canAdd = false;
        }
      }
      if (canAdd) {
        projectData.members?.add(UserModel(
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

  void deleteAProjectMember(UserModel userModel) {
    projectData.members?.removeWhere((element) {
      return element.email == userModel.email;
    });

    update();
  }

  void addAProjectSupervisor(String searchText) {
    if (projectData.coSupervisor?.email != searchText) {
      projectData.supervisor = UserModel(
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
    projectData.supervisor = null;

    update();
  }

  void addAProjectCoSupervisor(String searchText) {
    if (projectData.supervisor?.email != searchText) {
      projectData.coSupervisor = UserModel(
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
    projectData.coSupervisor = null;

    update();
  }

  void submit() async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "pleaseWait".tr,
        content: const CircularProgressIndicator());
    print(projectData.toJson());
    var response = await Crud.postRequest(projectsLink, projectData.toJson());
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
