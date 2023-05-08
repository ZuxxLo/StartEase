import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/controller/project_manag_admin_controller.dart';
import 'package:startease/view/widgets.dart';

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
              InkWell(
                onTap: () {
                  projectManagementAdminController.goToProjectsTable();
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
              InkWell(
                onTap: () {
                  projectManagementAdminController.goToPeriodsManagement();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
