import 'dart:ui';

import 'package:get/get.dart';

import '../Themes/colors.dart';
import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../model/project_model.dart';

class ProjectsTableController extends GetxController {
  List<ProjectModel> projectsListNotAffich = [];
  List<ProjectModel> projectsListToAffich = [];

  var statusList = [
    "validated".tr,
    "pending".tr,
    "refused".tr,
    "recourse".tr,
  ];

  Color getStatusColorIn(String status) {
    if (status == "accepted") {
      return const Color.fromARGB(255, 57, 123, 26);
    } else if (status == "pending") {
      return const Color.fromARGB(255, 181, 184, 0);
    } else if (status == "refused") {
      return const Color.fromARGB(255, 184, 0, 0);
    } else if (status == "recourse") {
      return const Color.fromARGB(255, 184, 98, 0);
    } else {
      return purpleColor;
    }
  }

  Color getStatusColorOut(String status) {
    if (status == "accepted") {
      return const Color.fromARGB(255, 223, 255, 226);
    } else if (status == "pending") {
      return const Color.fromARGB(255, 249, 255, 211);
    } else if (status == "refused") {
      return const Color.fromARGB(255, 255, 221, 221);
    } else if (status == "recourse") {
      return const Color.fromARGB(255, 255, 230, 211);
    } else {
      return purpleColor;
    }
  }

  String? getStatusIcon(String status) {
    if (status == "accepted") {
      return "done_tick_icon";
    } else if (status == "pending") {
      return "pendingg_icon";
    } else if (status == "refused") {
      return "refused_icon";
    } else if (status == "recourse") {
      return "recourse_icon";
    }
    return null;
  }

  Future loadProjects() async {
    projectsListNotAffich.clear();
    projectsListToAffich.clear();

    var response = await Crud.getRequest("$projectsLink/my");
    print(response);
    if (response != null && response["success"] == true) {
      projectsListNotAffich =
          (ProjectsModel.fromJson(response).data?.projects)!;
    }
    projectsListToAffich = List.from(projectsListNotAffich);

    if (searchTextProject != "") {
      return projectsListToAffich.removeWhere((element) {
        return (!(element.trademarkName)!.contains(searchTextProject));
      });
    } else {
      return projectsListToAffich;
    }
  }

  getProjectProgress(int projectId ) async {
      var response = await Crud.getRequest("$projectsLink/$projectId/progress");
     if (response != null && response["success"] == true) {
      // projectsListNotAffich[projectId].progress =
      //     (ProjectsModel.fromJson(response).data?.projects)!;
    }
    projectsListToAffich = List.from(projectsListNotAffich);

    if (searchTextProject != "") {
      return projectsListToAffich.removeWhere((element) {
        return (!(element.trademarkName)!.contains(searchTextProject));
      });
    } else {
      return projectsListToAffich;
    }
}

  String searchTextProject = "";

  searchProjectByTradeMark(String inputSearch) {
    projectsListToAffich = List.from(projectsListNotAffich);

    projectsListToAffich.removeWhere((element) {
      return (!(element.trademarkName)!.contains(inputSearch));
    });

    if (projectsListToAffich.isEmpty) {
      projectsListToAffich = List.from(projectsListNotAffich);

      projectsListToAffich.removeWhere((element) {
        return (!(element.trademarkName)!.startsWith(inputSearch));
      });
    }

    if (projectsListToAffich.isEmpty) {
      projectsListToAffich = List.from(projectsListNotAffich);

      projectsListToAffich.removeWhere((element) {
        return (!(element.trademarkName)!.endsWith(inputSearch));
      });
    }
    print("*/*/*/*/*/");
    print(projectsListToAffich.length);

    update();
  }

  @override
  void onInit() {
    loadProjects();
    // TODO: implement onInit
    super.onInit();
  }

  void searchTextInputProject(String inputSearch) {
    searchTextProject = inputSearch;
  }
}
