import 'package:get/get.dart';

import '../controller/all_roles_controller.dart';
import '../controller/project_deposit_controller.dart';
 
class ProjectDepositBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProjectDepositController());
  }
}
