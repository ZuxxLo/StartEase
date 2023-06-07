import 'package:get/get.dart';

import '../controller/defence_management_controller.dart';

class DefenceManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DefenceManagementController());
  }
}
