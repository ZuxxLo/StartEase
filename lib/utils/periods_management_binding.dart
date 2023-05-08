import 'package:get/get.dart';

 import '../controller/periods_management_controller.dart';
 
class PeriodsManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PeriodsManagementController());
  }
}
