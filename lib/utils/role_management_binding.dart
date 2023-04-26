import 'package:get/get.dart';
import 'package:startease/controller/role_management_controller.dart';
 


class RoleManagemenetBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RoleManagemenetController());
  }
}
