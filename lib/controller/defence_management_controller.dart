import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:startease/controller/project_manag_admin_controller.dart';
import 'package:startease/controller/project_management_controller.dart';
import 'package:startease/model/defences_model.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:startease/model/project_model.dart';
import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../main.dart';
import '../model/delibration_model.dart';

class DefenceManagementController extends GetxController {
  List<Defences> defencesList = [];
  Defences? defenceData = Defences(project: Get.arguments);

  Defences? newDefense = Defences(
      room: Rooms(),
      jurys: Jurys(
        examiners: [],
        president: Examiners(),
        supervisor: Examiners(),
        coSupervisor: Examiners(),
        guest: "",
      ));
  List<Roomss>? newDefenseRooms = [];
  Deliberation? deliberation;
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  bool isEditingProject = false;
  int currentPageViewIndex = 0;
  PageController pageController = PageController(keepPage: true);
  PageController pageController1 = PageController(keepPage: true);
  PageController pageControllerNewDefense = PageController(keepPage: true);
  List<String> modes = ["on site", "remote"];
  List<String> nature = ["open", "closed"];
  selectMode(mode) {
    newDefense!.mode = mode;
    print(newDefense!.mode);
  }

  selectNature(nature) {
    newDefense!.nature = nature;
    print(newDefense!.nature);
  }

  loadDefences() async {
    defencesList.clear();

    var response = await Crud.getRequest(defencesLink);

    if (response != null && response["success"] == true) {
      defencesList = (DefencesModel.fromJson(response).data?.defences)!;
    }
    print(response);
  }

  loadProjectData() async {
    print(defenceData!.projectId);
    var response2 =
        await Crud.getRequest("$projectsLink/${defenceData!.projectId}");
    defenceData!.project = ProjectModel.fromJson(response2['data']['project']);

    viewProject();
  }

  loadDelibrationDefence() async {
    var response2 =
        await Crud.getRequest("$deliberationsLink/${defenceData!.id}");
    deliberation = Deliberation.fromJson(response2['data']['deliberation']);
    goToviewDelibration();
  }

  loadOneDefenceData(int index) {
    defenceData = defencesList[index];
    print("*//*/*/*/*/*//*/*F");
    print(defencesList[index].projectId);
  }

  enableEditProject() {
    isEditingProject = !isEditingProject;

    update();
  }

  void goBackPageView() {
    currentPageViewIndex--;

    pageController.animateToPage(currentPageViewIndex,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);

    update();
  }

  void goBackPageView1() {
    currentPageViewIndex--;
    pageController1.animateToPage(currentPageViewIndex,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);

    update();
  }

  void goBackPageViewNewDefense() {
    currentPageViewIndex--;
    pageControllerNewDefense.animateToPage(currentPageViewIndex,
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

  next1() {
    if (currentPageViewIndex < 1) {
      currentPageViewIndex++;
      pageController1.animateToPage(currentPageViewIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    }

    update();
  }

  nextNewDefense() {
    if (currentPageViewIndex < 1) {
      currentPageViewIndex++;
      pageControllerNewDefense.animateToPage(currentPageViewIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    }

    update();
  }

  @override
  void onInit() {
    // loadDefences();
    super.onInit();
  }

  void goToviewDefense() {
    currentPageViewIndex = 0;

    Get.toNamed("/ViewDefense");
  }

  void goToviewDelibration() {
    currentPageViewIndex = 0;
    Get.toNamed("/ViewDelibration");
  }

  void viewProject() {
    Get.toNamed("/ProjectManagement", arguments: defenceData!.project);
  }

  Future<void> downloadfile(MapEntry x) async {
    // final url = Uri.parse(x.value);
    // if (await canLaunchUrl(url)) {
    //   launchUrl(url);
    // }

    //  _downloadFile(x.value, x.key);

    if (x.value != null) {
      FileDownloader.downloadFile(
        url: x.value,
        name: x.key,
        onDownloadError: (String error) {
          MainFunctions.somethingWentWrongSnackBar(error);
        },
        onDownloadCompleted: (String path) async {
          MainFunctions.successSnackBar("fileDownloadedTO".tr + path);
        },
      );
    } else {
      MainFunctions.somethingWentWrongSnackBar("nothingToDownload".tr);
    }
  }

  selectRoom(Roomss? room) {
    newDefense!.room!.id = room!.id;
    update();
  }

  loadRooms() async {
    var response = await Crud.getRequest(roomsLink);
    if (response != null && response["success"] == true) {
      print(response);
      newDefenseRooms = RoomsNewDefense.fromJson(response).data!.rooms;
    }
    print(newDefenseRooms!.length);

    Get.toNamed("/CreateNewDefense");
    currentPageViewIndex = 0;
  }

  inputDate(DateTime value) {
    newDefense!.date = dateFormat.format(value);
    print(newDefense!.date);
    update();
  }

  int concatenate2Numbers(int a, int b) {
    return int.parse(a.toString() + b.toString());
  }

  inputTime(TimeOfDay? value) {
    String hour = value!.hour.toString();
    String minute = value.minute.toString();
    if (value.hour < 10) {
      hour = "0${value.hour}";
    }
    if (value.minute < 10) {
      minute = "0${value.minute}";
    }
    print("$hour:$minute");

    newDefense!.time = "$hour:$minute";
    update();
  }

  String? presidentEmail;
  String? supervisorEmail;
  String? cosupervisorEmail;
  String? examinerEmail;
  String? guest;

  void inputGuest(String? inputSearch) {
    guest = inputSearch;
    update();
  }

  void inputPresident(String? inputSearch) {
    presidentEmail = inputSearch;
    update();
  }

  void inputSupervisor(String? inputSearch) {
    supervisorEmail = inputSearch;
    update();
  }

  void inputCoSupervisor(String? inputSearch) {
    cosupervisorEmail = inputSearch;
    update();
  }

  void inputExaminer(String? inputSearch) {
    examinerEmail = inputSearch;
    update();
  }

  addGuest() {
    newDefense!.jurys!.guest = guest;
    update();
  }

  addPresidentToDefense() {
    bool canAdd = true;

    if (presidentEmail == newDefense!.jurys!.supervisor!.email) {
      canAdd = false;
    }
    if (presidentEmail == newDefense!.jurys!.coSupervisor!.email) {
      canAdd = false;
    }
    for (var examiner in newDefense!.jurys!.examiners!) {
      if (presidentEmail == examiner.email) {
        canAdd = false;
      }
    }
    if (canAdd) {
      newDefense!.jurys!.president!.email = presidentEmail;
    } else {
      MainFunctions.somethingWentWrongSnackBar("alreadyHaveThismember".tr);
    }
    update();
  }

  addSupervisorToDefense() {
    bool canAdd = true;
    if (supervisorEmail == newDefense!.jurys!.president!.email) {
      canAdd = false;
    }
    if (supervisorEmail == newDefense!.jurys!.coSupervisor!.email) {
      canAdd = false;
    }
    for (var examiner in newDefense!.jurys!.examiners!) {
      if (supervisorEmail == examiner.email) {
        canAdd = false;
      }
    }
    if (canAdd) {
      newDefense!.jurys!.supervisor!.email = supervisorEmail;
    } else {
      MainFunctions.somethingWentWrongSnackBar("alreadyHaveThismember".tr);
    }
    update();
  }

  addCoSupervisorToDefense() {
    bool canAdd = true;
    if (cosupervisorEmail == newDefense!.jurys!.president!.email) {
      canAdd = false;
    }
    if (cosupervisorEmail == newDefense!.jurys!.supervisor!.email) {
      canAdd = false;
    }
    for (var examiner in newDefense!.jurys!.examiners!) {
      if (cosupervisorEmail == examiner.email) {
        canAdd = false;
      }
    }
    if (canAdd) {
      newDefense!.jurys!.coSupervisor!.email = cosupervisorEmail;
    } else {
      MainFunctions.somethingWentWrongSnackBar("alreadyHaveThismember".tr);
    }

    update();
  }

  addExaminerToDefense() {
    bool canAdd = true;
    if (examinerEmail == newDefense!.jurys!.president!.email) {
      canAdd = false;
    }
    if (examinerEmail == newDefense!.jurys!.supervisor!.email) {
      canAdd = false;
    }
    if (examinerEmail == newDefense!.jurys!.coSupervisor!.email) {
      canAdd = false;
    }
    for (var examiner in newDefense!.jurys!.examiners!) {
      if (examinerEmail == examiner.email) {
        canAdd = false;
      }
    }
    if (canAdd) {
      newDefense!.jurys!.examiners!.add(Examiners(email: examinerEmail));
    } else {
      MainFunctions.somethingWentWrongSnackBar("alreadyHaveThismember".tr);
    }
    update();
  }

  editExaminerToDefense(index) {
    bool canAdd = true;
    if (examinerEmail == newDefense!.jurys!.president!.email) {
      canAdd = false;
    }
    if (examinerEmail == newDefense!.jurys!.supervisor!.email) {
      canAdd = false;
    }
    if (examinerEmail == newDefense!.jurys!.coSupervisor!.email) {
      canAdd = false;
    }
    for (var examiner in newDefense!.jurys!.examiners!) {
      if (examinerEmail == examiner.email) {
        canAdd = false;
      }
    }
    if (canAdd) {
      newDefense!.jurys!.examiners![index] = (Examiners(email: examinerEmail));
    } else {
      MainFunctions.somethingWentWrongSnackBar("alreadyHaveThismember".tr);
    }
    update();
  }

  void selectRoomId(Roomss? room) {
    newDefense!.room!.id == room!.id;
  }

  createNewDefense() async {
    ProjectManagementController projectManagementController =
        ProjectManagementController();
    print(projectManagementController.projectData.defenceId);
    if (newDefense!.jurys!.examiners!.length < 3) {
      MainFunctions.somethingWentWrongSnackBar("examinersLength".tr);
    } else {
      var response = await Crud.postRequest(
          "$defencesLink/${projectManagementController.projectData.id}",
          newDefense!.toJson());
      print(response);
      if (response != null && response["success"]) {
        MainFunctions.successSnackBar("createNewDefenseSucc".tr);
        navigator!.pop();
      } else {
        MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
      update();
    }
  }

  void inputOtherPlace(value) {
    newDefense!.otherPlace = value;
    update();
  }
}
