import 'package:get/get.dart';
import 'package:startease/controller/create_role_controller.dart';

class CreateRoleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CreateRoleController());
  }
}
