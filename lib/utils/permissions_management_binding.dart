import 'package:get/get.dart';
import 'package:startease/controller/permissions_management_controller.dart';
 

class PermissionsManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PermissionsManagementController());
  }
}
