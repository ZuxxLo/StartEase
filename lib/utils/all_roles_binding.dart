import 'package:get/get.dart';

import '../controller/all_roles_controller.dart';
 
class AllRolesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AllRolesController());
  }
}
