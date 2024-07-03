import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/controller/defence_management_controller.dart';
import 'package:startease/main.dart';
import 'package:startease/model/remark_model.dart';
import 'package:startease/model/tasks_model.dart';
import 'package:startease/model/user_model.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../model/comments_model.dart';
import '../model/project_model.dart';

class ProjectManagementController extends GetxController {
  ProjectModel projectData = Get.arguments;
  ProjectModel projectNotEditedData = ProjectModel();
  ProjectModel projectnota = ProjectModel();
  Tasks newTask = Tasks(resources: {});
  String? newResName;
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  initializeNotEditedData() {
    projectNotEditedData.id = projectData.id;
    projectNotEditedData.coSupervisor = projectData.coSupervisor;
    projectNotEditedData.establishment = projectData.establishment;
    projectNotEditedData.files = projectData.files;
    projectNotEditedData.isAuthorizedDefence = projectData.isAuthorizedDefence;
    projectNotEditedData.members = projectData.members;
    projectNotEditedData.progress = projectData.progress;
    projectNotEditedData.projectHolder = projectData.projectHolder;
    projectNotEditedData.remakrs = projectData.remakrs;
    print(projectData.remakrs);
    projectNotEditedData.resume = projectData.resume;
    projectNotEditedData.scientificName = projectData.scientificName;
    projectNotEditedData.status = projectData.status;
    projectNotEditedData.supervisor = projectData.supervisor;
    projectNotEditedData.trademarkName = projectData.trademarkName;
    projectNotEditedData.type = projectData.type;
    update();
  }

  bool isEditingProject = false;
  int currentPageViewIndex = 0;
  String? newRemarkText;
  String? newCommentText;
  String? observationText;

  String? newReplyText;
  int? progress;
  PageController pageController = PageController(keepPage: true);
  var fileList = [];
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKeyAddTask = GlobalKey<FormState>();
  final formKeyRessTask = GlobalKey<FormState>();

  List<String> domicileEstabList = <String>[
    'Soumission',
    'Revision',
    'Skrt',
    'Zuxx'
  ];
  List<String> projectTypesList = <String>[
    'diplomaStartUp'.tr,
    'diplomaPatent'.tr
  ];

  List<String> statusList = [
    "validated".tr,
    "pending".tr,
    "refused".tr,
    "recourse".tr,
    // "recourse_validated".tr,
    // "recourse_refused".tr
  ];

  String? getInitialStatus() {
    for (var i = 0; i < statusList.length; i++) {
      if (statusList[i].toLowerCase() == projectData.status?.toLowerCase()) {
        return statusList[i];
      }
    }

    return null;
  }

  String? getStatusString() {
    if (projectData.status == "validated") {
      return "validated".tr;
    } else if (projectData.status == "pending") {
      return "pending".tr;
    } else if (projectData.status == "refused") {
      return "refused".tr;
    } else if (projectData.status == "recourse") {
      return "recourse".tr;
    }
    return null;
  }

  Color getStatusColorIn() {
    if (projectData.status == "accepted") {
      return const Color.fromARGB(255, 57, 123, 26);
    } else if (projectData.status == "pending") {
      return const Color.fromARGB(255, 181, 184, 0);
    } else if (projectData.status == "refused") {
      return const Color.fromARGB(255, 184, 0, 0);
    } else if (projectData.status == "recourse") {
      return const Color.fromARGB(255, 184, 98, 0);
    } else {
      return purpleColor;
    }
  }

  Color getStatusColorOut() {
    if (projectData.status == "accepted") {
      return const Color.fromARGB(255, 223, 255, 226);
    } else if (projectData.status == "pending") {
      return const Color.fromARGB(255, 249, 255, 211);
    } else if (projectData.status == "refused") {
      return const Color.fromARGB(255, 255, 221, 221);
    } else if (projectData.status == "recourse") {
      return const Color.fromARGB(255, 255, 230, 211);
    } else {
      return purpleColor;
    }
  }

  String? getStatusIcon() {
    if (projectData.status == "accepted") {
      return "done_tick_icon";
    } else if (projectData.status == "pending") {
      return "pendingg_icon";
    } else if (projectData.status == "refused") {
      return "refused_icon";
    } else if (projectData.status == "recourse") {
      return "recourse_icon";
    }
    return null;
  }

  enableEditProject() {
    isEditingProject = !isEditingProject;

    update();
  }

  restoreNonEditedData() {
    projectData.id = projectNotEditedData.id;
    projectData.coSupervisor = projectNotEditedData.coSupervisor;
    projectData.establishment = projectNotEditedData.establishment;
    projectData.files = projectNotEditedData.files;
    projectData.isAuthorizedDefence = projectNotEditedData.isAuthorizedDefence;
    projectData.members = [];
    projectNotEditedData.members?.forEach((element) {
      projectData.members?.add(element);
    });
    projectData.progress = projectNotEditedData.progress;
    projectData.projectHolder = projectNotEditedData.projectHolder;
    projectData.remakrs = projectNotEditedData.remakrs;
    projectData.resume = projectNotEditedData.resume;
    projectData.scientificName = projectNotEditedData.scientificName;
    projectData.status = projectNotEditedData.status;
    projectData.supervisor = projectNotEditedData.supervisor;
    projectData.trademarkName = projectNotEditedData.trademarkName;
    projectData.type = projectNotEditedData.type;

    update();
  }

  goToViewMyProject() {
    currentPageViewIndex = 0;
    isEditingProject = false;
    fileList.clear();
    //load file list from api
    Get.toNamed("/ViewProject");
  }

  void goToEditMyProject() {}

  loadRemarks() async {
    bool exists = false;
    for (var permission in userModel.permissions!) {
      if (permission.id == 27) {
        exists = true;
      }
    }
    if (exists) {
      projectData.remakrs = [];
      var response =
          await Crud.getRequest("$remarksLink/project/${projectData.id}");
      print(response);
      if (response != null && response["success"] == true) {
        print("*/*/*/*/*");

        print(response["data"]["remarks"]);
        print("*/*/*/*/*");

        for (var i = 0; i < response["data"]["remarks"].length; i++) {
          projectData.remakrs!
              .add(Remark.fromJson(response["data"]["remarks"][i]));
        }
      }
      print(projectData.remakrs?.length);
      goToRemarks();
    }
  }

  goToRemarks() async {
    Get.toNamed("/ViewRemarks");
  }

  void goToProjectObserv() {
    loadProgress();

    Get.toNamed("/ViewObserv");
  }

  loadComments() async {
    projectData.comments = [];
    var response =
        await Crud.getRequest("$commentsLink/project/${projectData.id}");
    print(response);
    if (response != null && response["success"] == true) {
      print("*/*/*/*/*");

      print(response["data"]["comments"][0]["user"]["person"]);
      print("*/*/*/*/*");

      for (var i = 0; i < response["data"]["comments"].length; i++) {
        projectData.comments!
            .add(Comments.fromJson(response["data"]["comments"][i]));
      }
    }
    update();

    print(projectData.comments![0].user?.person?.firstName);
  }

  void goToComments() {
    loadComments();
    Get.toNamed("/ViewComments");
  }

  void goToTasks() {
    loadTasks();
    Get.toNamed("/ViewTasks");
  }

  Future<void> updateProgressBar() async {
    if (await MainFunctions.checkInternetConnection()) {
      var response = await Crud.putRequest(
          "$projectsLink/${projectData.id}/progress",
          {"progress": progress, "observation": observationText});
      if (response != null && response["success"] == true) {
        projectData.progress?["$progress"] = observationText;
        navigator!.pop();
      } else {
        MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
      progress = int.parse(projectData.progress!.keys.toList().last) + 1;
    }
    update();
  }

  void inputProjectType(String? newValue) {}

  void inputTrademarkName(String? value) {
    projectData.trademarkName = value;
  }

  void inputScientificName(String? value) {
    projectData.scientificName = value;
  }

  void inputSummary(String? value) {
    projectData.resume = value;
  }

  next() {
    if (currentPageViewIndex < 2) {
      currentPageViewIndex++;
      pageController.animateToPage(currentPageViewIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    }

    update();
  }

  submitEditProject() async {
    if (await MainFunctions.checkInternetConnection()) {
      print(projectData.id);
      var response = await Crud.putRequest(
          "$projectsLink/${projectData.id}", projectData.putProjectToJson());
      print(response);

      if (response != null && response["success"] == true) {
        navigator!.pop();
      } else {
        //  MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
    }
    update();
  }

  void goBackPageView() {
    currentPageViewIndex--;

    pageController.animateToPage(currentPageViewIndex,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);

    update();
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
        var tempMap = <String, dynamic>{};

        for (var element in files.files) {
          fileList.add(element);
          // print(element.name);
          // print(element.size);
          // print(element.path);
          // print(File(element.path!));
        }
        for (var i = 0; i < fileList.length; i++) {
          tempMap.addAll({"$i": fileList[i]});
        }
        projectData.files?.addEntries(tempMap.entries);
      } catch (e) {
        MainFunctions.somethingWentWrongSnackBar(e.toString());
      }
    }

    update();
  }

  deleteFile(int index) {
    fileList.removeAt(index); // only from UI
    projectData.files?.remove(index.toString()); // only from UI

    update();
  }

  void inputNewRemark(String? inputText) {
    newRemarkText = inputText;
  }

  void inputNewComment(String? inputText) {
    newCommentText = inputText;
  }

  void inputNewReply(String? inputText) {
    newReplyText = inputText;
  }
  // this function depends on the date on the user phone
  // String affichageDaysAgo(DateTime dateTime) {
  //   if (DateTime.now().day - dateTime.day < 8 &&
  //       DateTime.now().month - dateTime.month == 0) {
  //     int dateDifference = DateTime.now().day - dateTime.day;
  //     return "daysAgo".trParams({"daysAgo": dateDifference.toString()});
  //   } else {
  //     return dateFormat.format(dateTime);
  //   }
  // }

  Future<void> addANewRemark() async {
    Remark newRemark = Remark(
        content: newRemarkText,
        user: userModel,
        createdAt: "justNow".tr,
        updatedAt: null);

    Get.defaultDialog(
        barrierDismissible: false,
        title: "pleaseWait".tr,
        content: const CircularProgressIndicator());
    var response = await Crud.postRequest(
        remarksLink, newRemark.postRemarkToJson("${projectData.id}"));
    if (response != null && response["success"] == true) {
      projectData.remakrs?.add(Remark.fromJson(response["data"]["remark"]));

      navigator!.pop();
      navigator!.pop();
    } else {
      navigator!.pop();
      MainFunctions.somethingWentWrongSnackBar(response["message"]);
    }
    update();
  }

  Future<void> addANewComment() async {
    Comments newComment = Comments(
        content: newCommentText,
        user: userModel,
        createdAt: "justNow".tr,
        updatedAt: null);

    Get.defaultDialog(
        barrierDismissible: false,
        title: "pleaseWait".tr,
        content: const CircularProgressIndicator());
    var response = await Crud.postRequest(
        commentsLink, newComment.postCommentToJson("${projectData.id}"));
    if (response != null && response["success"] == true) {
      projectData.comments?.add(Comments.fromJson(response["data"]["comment"]));

      navigator!.pop();
      navigator!.pop();
    } else {
      navigator!.pop();
      MainFunctions.somethingWentWrongSnackBar(response["message"]);
    }
    update();
  }

  Future<void> addANewReply(int? index) async {
    Replies newReply = Replies(
        content: newReplyText,
        user: userModel,
        createdAt: "justNow".tr,
        updatedAt: null);

    Get.defaultDialog(
        barrierDismissible: false,
        title: "pleaseWait".tr,
        content: const CircularProgressIndicator());
    var response = await Crud.postRequest(
        "$commentsLink/reply", newReply.postReplyToJson("${projectData.id}"));
    if (response != null && response["success"] == true) {
      projectData.comments![index!].replies
          ?.add(Replies.fromJson(response["data"]["comment"]));
      update();

      navigator!.pop();
      navigator!.pop();
    } else {
      navigator!.pop();
      MainFunctions.somethingWentWrongSnackBar(response["message"]);
    }
    update();
  }

  void editRemarkOnChanged(String remarkEdited) {
    newRemarkText = remarkEdited;
  }

  Future<void> editRemark(int index) async {
    Remark editedRemark = Remark(updatedAt: "justNow".tr, user: userModel);

    editedRemark.id = projectData.remakrs![index].id;
    editedRemark.content = newRemarkText;

    if (await MainFunctions.checkInternetConnection()) {
      var response =
          await Crud.putRequest(remarksLink, editedRemark.putRemarkToJson());
      if (response != null && response["success"] == true) {
        projectData.remakrs?[index] =
            Remark.fromJson(response["data"]["remark"]);

        navigator!.pop();
      } else {
        MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
    }
    update();
  }

  Future<void> deleteRemark(int index) async {
    if (await MainFunctions.checkInternetConnection()) {
      int? id = projectData.remakrs![index].id;

      var response = await Crud.deleteRequest("$remarksLink/$id");

      if (response != null && response["success"] == true) {
        projectData.remakrs!.removeAt(index);
        MainFunctions.successSnackBar("remarkDeleted".tr);
        navigator!.pop();
      } else {
        MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
    }

    update();
  }

  Future<void> editComment(int index) async {
    Comments editedComments =
        Comments(updatedAt: "justNow".tr, user: userModel);

    editedComments.id = projectData.comments![index].id;
    editedComments.content = newCommentText;
    if (await MainFunctions.checkInternetConnection()) {
      var response = await Crud.putRequest("$commentsLink/${editedComments.id}",
          editedComments.putCommentToJson());
      print(response);
      if (response != null && response["success"] == true) {
        projectData.comments?[index] =
            Comments.fromJson(response["data"]["comment"]);

        navigator!.pop();
      } else {
        MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
    }
    update();
  }

  void editCommentOnChanged(String commentEdited) {
    newCommentText = commentEdited;
  }

  Future<void> deleteComment(int index) async {
    if (await MainFunctions.checkInternetConnection()) {
      int? id = projectData.comments![index].id;

      var response = await Crud.deleteRequest("$commentsLink/$id");

      if (response != null && response["success"] == true) {
        projectData.comments!.removeAt(index);
        MainFunctions.successSnackBar("commentDeleted".tr);
        navigator!.pop();
      } else {
        MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
    }

    update();
  }

  String getExactStatus(String status) {
    if (status == "validated".tr) {
      return "validated";
    } else if (status == "pending".tr) {
      return "pending";
    } else if (status == "refused".tr) {
      return "refused";
    } else if (status == "recourse".tr) {
      return "recourse";
    } else if (status == "recourse_validated".tr) {
      return "recourse_validated";
    } else if (status == "recourse_refused".tr) {
      return "recourse_refused";
    } else {
      return "error";
    }
  }

  updateStatus(String? newStatus) async {
    if (projectData.status != "accepted" && projectData.status != "refused") {
      var response = await Crud.putRequest(
          "$projectsLink/status", projectData.updateStatustoJson(newStatus));

      print(newStatus);
      if (response != null && response["success"] == true) {
        projectData.status = newStatus?.toLowerCase();

        MainFunctions.successSnackBar("statusUpdatedSuccess".tr);
      } else {
      MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
    } else {
      MainFunctions.somethingWentWrongSnackBar("cantChangeStatus".tr);
    }
    update();
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

  withdrawProject() async {
    if (await MainFunctions.checkInternetConnection()) {
      var response =
          await Crud.deleteRequest("$projectsLink/${projectData.id}");
      print(response);
      if (response != null && response["success"] == true) {
        MainFunctions.successSnackBar("projectDeleted".tr);
        navigator!.pop();
        navigator!.pop();
        navigator!.pop();
      } else {
        MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
    }

    update();
  }

  loadProgress() async {
    projectData.progress = {};
    var response =
        await Crud.getRequest("$projectsLink/${projectData.id}/progress");
    print(response["data"]["progress"]);
    if (response != null && response["success"] == true) {
      if (response["data"]["progress"].isEmpty) {
        print("****************");
        projectData.progress = {};
        progress = 0;
      } else {
        print("*/*/*/*/*");

        projectData.progress = response["data"]["progress"];
        progress = int.parse(projectData.progress!.keys.toList().last) + 1;
      }
    }

    update();
  }

  addProgress() {
    if (progress! < 100) {
      progress = progress! + 1;
    }

    update();
  }

  minusProgress() {
    if (progress! > int.parse(projectData.progress!.keys.last) + 1) {
      progress = progress! - 1;
    }
    update();
  }

  void observationOnChanged(String inputText) {
    observationText = inputText;
  }

  loadTasks() async {
    bool exists = false;
    for (var permission in userModel.permissions!) {
      if (permission.id == 42) {
        exists = true;
      }
    }
    if (exists) projectData.tasks = [];
    var response =
        await Crud.getRequest("$tasksLink/project/${projectData.id}");
    if (response != null && response["success"] == true) {
      print(response["data"]);
      print("*/*/*/*/*");

      for (var i = 0; i < response["data"]["tasks"].length; i++) {
        projectData.tasks!.add(Tasks.fromJson(response["data"]["tasks"][i]));
      }
    }
    update();
  }

  @override
  void onInit() {
    initializeNotEditedData();

    super.onInit();
  }

  Future<void> downloadfile(MapEntry x) async {
    // final url = Uri.parse(x.value);
    // if (await canLaunchUrl(url)) {
    //   launchUrl(url);
    // }

    //  _downloadFile(x.value, x.key);

    if (x.value != null) {
      print(x.value);
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

  void goToAddTask() {
    Get.toNamed("/AddTask");
  }

  void inputDeadlineDate(DateTime value) {
    newTask.deadline = dateFormat.format(value);

    update();
  }

  void ipnutEditTaskDeadlineDate(value, index) {
    projectData.tasks![index].deadline = dateFormat.format(value);

    print(projectData.tasks![index].deadline);
    update();
  }

  void inputResName(String input) {
    newResName = input;
    update();
  }

  void addARess() {
    newTask.resources?.addAll({newResName!: null});
    update();
  }

  void editAddARess(index) {
    projectData.tasks![index].resources?.addAll({newResName!: null});
    update();
  }

  void deleteResAddTask(var key) {
    newTask.resources?.remove(key);
    update();
  }

  void deleteditResTask(key, index) {
    print("sq");
    projectData.tasks![index].resources!.remove(key);
    update();
  }

  Future<void> addATask() async {
    if (newTask.resources!.isNotEmpty) {
      Get.defaultDialog(
          barrierDismissible: false,
          title: "pleaseWait".tr,
          content: const CircularProgressIndicator());
      var response = await Crud.postRequest(
          "$tasksLink/${projectData.id}", newTask.postTaskToJson());
      if (response != null && response["success"] == true) {
        loadTasks();

        MainFunctions.successSnackBar("taskAdded".tr);
        navigator!.pop();
      } else {
        navigator!.pop();
        MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
    } else {
      MainFunctions.somethingWentWrongSnackBar("requiredAttachs".tr);
    }

    update();
  }

  void ipnutNewTaskTitle(value) {
    newTask.title = value;
  }

  void ipnutEditTaskTitle(value, index) {
    projectData.tasks![index].title = value;
  }

  void ipnutNewTaskDesc(value) {
    newTask.description = value;
  }

  void ipnutEditTaskDesc(value, index) {
    projectData.tasks![index].description = value;
  }

  Future<void> deleteTask(int index) async {
    int? id = projectData.tasks![index].id;

    var response = await Crud.deleteRequest("$tasksLink/$id");

    if (response != null && response["success"] == true) {
      projectData.tasks!.removeAt(index);
      MainFunctions.successSnackBar("taskDeleted".tr);
      navigator!.pop();
    } else {
      MainFunctions.somethingWentWrongSnackBar(response["message"]);
    }
    update();
  }

  Future<void> validateTask(int index, bool bool,
      [String? refusalDescription]) async {
    int? id = projectData.tasks![index].id;
    if (bool) {
      var response =
          await Crud.putRequest("$tasksLink/$id/validate", {"validated": bool});
      if (response != null && response["success"] == true) {
        MainFunctions.successSnackBar("taskValidated".tr);
        loadTasks();
        navigator!.pop();
      } else {
        MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
    } else {
      var response = await Crud.putRequest("$tasksLink/$id/validate",
          {"validated": bool, "refusal_motif": refusalDescription});
      if (response != null && response["success"] == true) {
        MainFunctions.successSnackBar("taskValidated".tr);
        loadTasks();
        navigator!.pop();
      } else {
        MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
    }
    update();
  }

  Future<void> editTask(Tasks task) async {
    if (await MainFunctions.checkInternetConnection()) {
      var response =
          await Crud.putRequest("$tasksLink/${task.id}", task.putTaskToJson());
      print(response);
      if (response != null && response["success"] == true) {
        MainFunctions.successSnackBar("taskEdited".tr);

        navigator!.pop();
      } else {
        MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
    }
    update();
  }

  Future<void> authorizeProject() async {
    if (await MainFunctions.checkInternetConnection()) {
      if (authorizeFile != null) {
        var response = await Crud.postRequestWithFileWithData(
            "$projectsLink/${projectData.id}/authorize",
            {"_method": "put"},
            authorizeFile!);
        print(response);
        if (response != null && response["success"] == true) {
          MainFunctions.successSnackBar("authorizeSucc".tr);

          print(response);
          navigator!.pop();
        } else {
          MainFunctions.somethingWentWrongSnackBar(response["message"]);
        }
      } else {
        var response = await Crud.postRequest(
            "$projectsLink/${projectData.id}/authorize", {"_method": "put"});
        print(response);

        if (response != null && response["success"] == true) {
          MainFunctions.successSnackBar("authorizeSucc".tr);

          print(response);
          navigator!.pop();
        } else {
          MainFunctions.somethingWentWrongSnackBar(response["message"]);
        }
      }
    }
    update();
  }

  File? authorizeFile;

  Future<void> importAuthorizeProject() async {
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
        final file = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: ["pdf"]);
        if (file == null) return;
        authorizeFile = File(file.files[0].path!);
        print(authorizeFile);
      } catch (e) {
        MainFunctions.somethingWentWrongSnackBar(e.toString());
      }
    }
    update();
  }

  List<File>? taskFiles;
  Future<void> importTaskFile() async {
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
            allowedExtensions: ["pdf"]);
        if (files == null) return;
        taskFiles = [];
        for (var i = 0; i < files.files.length; i++) {
          taskFiles?.add(File(files.files[i].path!));
        }
      } catch (e) {
        MainFunctions.somethingWentWrongSnackBar(e.toString());
        e.printError();
      }
    }

    update();
  }

  Future<void> submitTask(Tasks task) async {
    // print(taskFiles);
    // Get.defaultDialog(
    //     barrierDismissible: false,
    //     title: "pleaseWait".tr,
    //     content: const CircularProgressIndicator());
    // var response = await Crud.postRequestWithFileWithData(
    //     "$tasksLink/${task.id}/submit",
    //     {"submission_description": task.description!, "resources": taskFiles},
    //     file);
    // print(response);
    // if (response != null && response["success"] == true) {
    //   loadTasks();
    //   navigator!.pop();
    //   navigator!.pop();
    // } else {
    //   navigator!.pop();
    //   MainFunctions.somethingWentWrongSnackBar(response["message"]);
    // }
    // update();
  }

  Future<File> _downloadFile(String url, String filename) async {
    var httpClient = HttpClient();
    HttpOverrides.global = MyHttpOverrides();

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      final dir =
          await getApplicationDocumentsDirectory(); //(await getApplicationDocumentsDirectory()).path;
      File file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes);
      return file;
    } catch (error) {
      print('pdf downloading error = $error');
      return File('');
    }
  }

  Future<void> goToCreateNewDefense() async {
    Get.put(DefenceManagementController());
    DefenceManagementController defenceManagementController = Get.find();
    await defenceManagementController.loadRooms();
    Get.toNamed("/CreateNewDefense", arguments: projectData);
  }
}
