import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/view/widgets.dart';

import '../controller/project_management_controller.dart';

class ProjectManagement extends StatelessWidget {
  const ProjectManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectManagementController projectManagementController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: Text("projectManagement".tr),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 25),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("status".tr),
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            dense: true,
            leading: const ImageIcon(Svg("assets/icons/pending_icon.svg")),
            title: Text(
              projectManagementController.statusList[2],
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).primaryColorLight),
            ),
            iconColor: Theme.of(context).primaryColorLight,
            tileColor: projectManagementController
                .getStatusColor(projectManagementController.statusList[2]),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "projectAdvanc".tr,
              ),
              TextButton(
                  style: ButtonStyle(
                      alignment: Alignment.center,
                      fixedSize: MaterialStateProperty.all(const Size(100, 40)),
                      backgroundColor:
                          MaterialStateProperty.all(transparentColor),
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => bluePurpleColor.withOpacity(0.2)),
                      foregroundColor:
                          MaterialStateProperty.all(bluePurpleColor)),
                  onPressed: () {
                    projectManagementController.updateProgressBar();
                  },
                  child: Text("update".tr)),
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(  
                    
                    minHeight: 25,
                    value: 0.7,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(bluePurpleColor),
                    backgroundColor: const Color(0xffD6D6D6),
                  ),
                ),
                Text(
                  "70%",
                  style: const TextStyle(color: whiteColor, fontSize: 15),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "informations".tr,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () {
              print("*//*/**/");
              projectManagementController.goToViewMyProject();
            },
            dense: true,
            leading: const ImageIcon(Svg("assets/icons/view_project_icon.svg")),
            title: Text(
              "viewMyProject".tr,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () {
              projectManagementController.goToTasks();
            },
            dense: true,
            leading: const ImageIcon(Svg("assets/icons/tasks_icon.svg")),
            title: Text(
              "tasks".tr,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () {
              projectManagementController.goToComments();
            },
            dense: true,
            leading: const ImageIcon(Svg("assets/icons/comments_icon.svg")),
            title: Text(
              "comments".tr,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () {
              projectManagementController.goToRemarks();
            },
            dense: true,
            visualDensity: const VisualDensity(vertical: -4),
            leading: const ImageIcon(Svg("assets/icons/remarques_icon.svg")),
            title: Text(
              "remarks".tr,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () {
              projectManagementController.goToProjectObserv();
            },
            dense: true,
            visualDensity: const VisualDensity(vertical: -4),
            leading: const ImageIcon(Svg("assets/icons/view_project_icon.svg")),
            title: Text(
              "projectObserv".tr,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(transparentColor),
              foregroundColor: MaterialStateProperty.all(redColor),
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => redColor.withOpacity(0.2)),
            ),
            child: Text(
              "withdraw".tr,
            ),
          )
        ],
      ),
    );
  }
}
