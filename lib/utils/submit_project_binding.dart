import 'package:get/get.dart';

import '../controller/submit_project._controller.dart';

class SubmitProjectBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SubmitProjectController());
  }
}
