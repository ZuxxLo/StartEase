import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/crud.dart';

class RoleManagemenetController extends GetxController {
  void roles() {
    Get.toNamed("/AllRoles");
  }

  void createNewRole() {
    Get.toNamed("/CreateRole");
  }

  void permissionsManagement() {
    Get.toNamed("/PermissionsManagement");
  }
}
