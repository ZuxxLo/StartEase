import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/view/widgets.dart';

import '../Themes/colors.dart';
import '../controller/defence_management_controller.dart';
import '../main.dart';

class DefencesAdmin extends StatelessWidget {
  const DefencesAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final DefenceManagementController defenceManagementController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: Text("defensesManag".tr),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              ///////////////////// goToviewDefense
              Builder(
                builder: (context) {
                  bool exists = false;
                  for (var permission in userModel.permissions!) {
                    if (permission.id == 24) {
                      exists = true;
                    }
                  }

                  return exists
                      ? Column(
                          children: [
                            ListTile(
                              onTap: () {
                                print("*//*/**/");
                                defenceManagementController.goToviewDefense();
                              },
                              dense: true,
                              leading: const Icon(Icons.filter_frames_outlined),
                              title: Text(
                                "viewDefence".tr,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : const SizedBox();
                },
              ),
              ///////////////////// goToviewDefense
              ///////////////////// viewProject
              Builder(
                builder: (context) {
                  bool exists = false;
                  for (var permission in userModel.permissions!) {
                    if (true) {
                      //permission.id == 8
                      exists = true;
                    }
                  }

                  return exists
                      ? Column(
                          children: [
                            ListTile(
                              onTap: () {
                                print("*//*/**/");
                                defenceManagementController.loadProjectData();
                              },
                              dense: true,
                              leading: const ImageIcon(
                                  Svg("assets/icons/view_project_icon.svg")),
                              title: Text(
                                "viewMyProject".tr,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : const SizedBox();
                },
              ),
              ///////////////////// viewProject
              ///////////////////// goToviewDelibration
              Builder(
                builder: (context) {
                  bool exists = false;
                  for (var permission in userModel.permissions!) {
                    if (permission.id == 8) {
                      exists = true;
                    }
                  }
                  if (defenceManagementController
                          .defenceData!.hasDeliberation ==
                      false) {
                    exists = false;
                  }

                  return exists
                      ? ListTile(
                          onTap: () {
                            print("*//*/**/");
                            defenceManagementController
                                .loadDelibrationDefence();
                          },
                          dense: true,
                          leading: const Icon(Icons.my_library_books_outlined),
                          title: Text(
                            "viewDelibration".tr,
                            style: const TextStyle(fontSize: 18),
                          ),
                        )
                      : const SizedBox();
                },
              ),
              ///////////////////// goToviewDelibration
            ],
          ),
        ),
      ),
    );
    ;
  }
}
