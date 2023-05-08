import 'package:get/get.dart';
import '../controller/projects_table_controller.dart';

  

class ProjectsTableBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProjectsTableController());
  }
}
