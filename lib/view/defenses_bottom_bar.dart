import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/controller/defence_management_controller.dart';
import 'package:startease/controller/project_manag_admin_controller.dart';
import 'package:startease/view/widgets.dart';

import '../main.dart';

class DefensesBottomBar extends StatelessWidget {
  const DefensesBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final DefenceManagementController defenceManagementController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: MenuIcon(onPressed: () {
          Scaffold.of(context).openDrawer();
        }),
        title: Text("defensesManag".tr),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///////////////////// goTodefensesTable
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
                            InkWell(
                              onTap: () {
                                Get.toNamed("/DefenceManagement");
                              },
                              child: Container(
                                width: 200,
                                height: 170,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: greyColor)),
                                child: Column(children: [
                                  const Expanded(
                                    child: Icon(
                                      Icons.filter_frames_outlined,
                                      size: 80,
                                    ),
                                  ),
                                  Text(
                                    "defensesTable".tr,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ]),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : const SizedBox();
                },
              ),
              ///////////////////// goTodefensesTable

              ///////////////////// createNewDefense
              // Builder(
              //   builder: (context) {
              //     bool exists = false;
              //     for (var permission in userModel.permissions!) {
              //       if (permission.id == 46) {
              //         exists = true;
              //       }
              //     }
              //     if (userModel.isProjectMember!) {
              //       exists = false;
              //     }

              //     return exists
              //         ? Column(
              //             children: [
              //               InkWell(
              //                 onTap: () {
              //                   defenceManagementController.loadRooms();
              //                 },
              //                 child: Container(
              //                   width: 200,
              //                   height: 170,
              //                   decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(10),
              //                       border: Border.all(color: greyColor)),
              //                   child: Column(children: [
              //                     const Expanded(
              //                       child: Icon(
              //                         Icons.filter_frames_outlined,
              //                         size: 80,
              //                       ),
              //                     ),
              //                     Text(
              //                       "createNewDefense".tr,
              //                       textAlign: TextAlign.center,
              //                     ),
              //                     const SizedBox(
              //                       height: 10,
              //                     )
              //                   ]),
              //                 ),
              //               ),
              //               const SizedBox(
              //                 height: 20,
              //               ),
              //             ],
              //           )
              //         : const SizedBox();
              //   },
              // ),
              ///////////////////// createNewDefense
            ],
          ),
        ),
      ),
    );
  }
}
