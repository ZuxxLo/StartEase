import 'package:get/get.dart';
import 'package:startease/controller/project_manag_admin_controller.dart';

class ProjectManagementAdminControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProjectManagementAdminController());
  }
}
