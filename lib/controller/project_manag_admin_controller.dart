import 'package:get/get.dart';

class ProjectManagementAdminController extends GetxController {
  goToPeriodsManagement() {
    Get.toNamed("/PeriodsManagement");
  }

  goToProjectsTable() {
    Get.toNamed("/ProjectsTable");
  }
}
