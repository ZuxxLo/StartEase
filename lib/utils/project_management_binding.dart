import 'package:get/get.dart';

import '../controller/project_management_controller.dart';

  
class ProjectManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProjectManagementController());
  }
}
