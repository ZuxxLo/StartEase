import 'package:get/get.dart';
 
import '../controller/login_controller.dart';
import '../controller/profile_page_controller.dart';


class ProfilePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProfilePageController());
  }
}
