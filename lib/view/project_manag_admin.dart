import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/controller/project_manag_admin_controller.dart';
import 'package:startease/view/widgets.dart';

import '../main.dart';

class ProjectManagementAdmin extends StatelessWidget {
  const ProjectManagementAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectManagementAdminController projectManagementAdminController =
        Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: MenuIcon(onPressed: () {
          Scaffold.of(context).openDrawer();
        }),
        title: Text("projectsManagement".tr),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///////////////////// goToProjectsTable
              Builder(
                builder: (context) {
                  bool exists = false;
                  for (var permission in userModel.permissions!) {
                    if (permission.id == 21) {
                      exists = true;
                    }
                  }

                  return exists
                      ? Column(
                          children: [
                            InkWell(
                              onTap: () {
                                projectManagementAdminController
                                    .goToProjectsTable();
                              },
                              child: Container(
                                width: 200,
                                height: 170,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: greyColor)),
                                child: Column(children: [
                                  Expanded(
                                    child: Image.asset(
                                      "assets/images/roles.png",
                                    ),
                                  ),
                                  Text(
                                    "projectsTable".tr,
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
              ///////////////////// goToProjectsTable

              ///////////////////// createNewProject
              Builder(
                builder: (context) {
                  bool exists = false;
                  for (var permission in userModel.permissions!) {
                    if (permission.id == 46) {
                      exists = true;
                    }
                  }

                  return exists
                      ? Column(
                          children: [
                            InkWell(
                              onTap: () {
                                projectManagementAdminController
                                    .goToSubmitProject();
                              },
                              child: Container(
                                width: 200,
                                height: 170,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: greyColor)),
                                child: Column(children: [
                                  Expanded(
                                    child: Image.asset(
                                      "assets/images/roles.png",
                                    ),
                                  ),
                                  Text(
                                    "createProject".tr,
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
              ///////////////////// createNewProject
              ///////////////////// goToPeriodsManagement
              Builder(
                builder: (context) {
                  bool exists = false;
                  for (var permission in userModel.permissions!) {
                    if (permission.id == 23) {
                      exists = true;
                    }
                  }

                  return exists
                      ? InkWell(
                          onTap: () {
                            projectManagementAdminController
                                .goToPeriodsManagement();
                          },
                          child: Container(
                            width: 200,
                            height: 170,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: greyColor)),
                            child: Column(children: [
                              Expanded(
                                child: Image.asset(
                                  "assets/images/roles.png",
                                ),
                              ),
                              Text(
                                "periodsManagement".tr,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ]),
                          ),
                        )
                      : const SizedBox();
                },
              ),
              ///////////////////// goToPeriodsManagement
            ],
          ),
        ),
      ),
    );
  }
}
