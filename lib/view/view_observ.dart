import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/view/widgets.dart';

import '../controller/project_management_controller.dart';
import '../main.dart';

class ViewObserv extends StatelessWidget {
  const ViewObserv({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectManagementController projectManagementController = Get.find();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: Text("viewObservs".tr),
        actions: [
          Builder(
            builder: (context) {
              bool exists = false;
              for (var permission in userModel.permissions!) {
                if (permission.id == 3) {
                  exists = true;
                }
              }
              if (projectManagementController.projectData.supervisor!.id !=
                  userModel.id) {
                exists = false;
              }
              return exists
                  ? TextButton(
                      style: ButtonStyle(
                          alignment: Alignment.center,
                          fixedSize:
                              MaterialStateProperty.all(const Size(100, 40)),
                          backgroundColor:
                              MaterialStateProperty.all(transparentColor),
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => bluePurpleColor.withOpacity(0.2)),
                          foregroundColor:
                              MaterialStateProperty.all(bluePurpleColor)),
                      onPressed: () {
                        Get.defaultDialog(
                            title: "update".tr,
                            content: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      iconSize: 30,
                                      onPressed: () {
                                        projectManagementController
                                            .minusProgress();
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle,
                                      ),
                                    ),
                                    GetBuilder<ProjectManagementController>(
                                        builder: (context) {
                                      return Text(
                                        "${projectManagementController.progress}%",
                                        style: const TextStyle(fontSize: 25),
                                      );
                                    }),
                                    const SizedBox(height: 10),
                                    IconButton(
                                      iconSize: 30,
                                      onPressed: () {
                                        projectManagementController
                                            .addProgress();
                                      },
                                      icon: const Icon(
                                        Icons.add_circle,
                                      ),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  onChanged: (inputText) {
                                    projectManagementController
                                        .observationOnChanged(inputText);
                                  },
                                  decoration: InputDecoration(
                                      hintText: "enterAobservation".tr),
                                ),
                                const SizedBox(height: 10),
                                TextButton(
                                    onPressed: () {
                                      projectManagementController
                                          .updateProgressBar();
                                    },
                                    child: Text("confirm".tr)),
                                const SizedBox(height: 10),
                                TextButton(
                                    onPressed: () {
                                      navigator!.pop();
                                    },
                                    child: Text("cancel".tr))
                              ],
                            ));
                      },
                      child: Text("update".tr))
                  : const SizedBox();
            },
          )
        ],
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Get.defaultDialog(
        //             title: "editYourProject".tr,
        //             content: Column(
        //               children: [
        //                 TextButton(
        //                     onPressed: () {
        //                       Get.back();
        //                     },
        //                     child: Text("confirm".tr)),
        //                 const SizedBox(
        //                   height: 10,
        //                 ),
        //                 TextButton(
        //                     onPressed: () {
        //                       Get.back();
        //                     },
        //                     child: Text("cancel".tr))
        //               ],
        //             ));
        //       },
        //       icon: const ImageIcon(Svg("assets/icons/edit_project_icon.svg"))),
        //   const SizedBox(
        //     width: 10,
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: [
            GetBuilder<ProjectManagementController>(builder: (context) {
              return projectManagementController.projectData.progress!.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Center(child: Text("noResults".tr)))
                  : ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: projectManagementController
                          .projectData.progress!.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(10, 7, 15, 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(context).listTileTheme.tileColor),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   "projectAdvanc".tr,
                                //   style: const TextStyle(fontSize: 18),
                                // ),
                                const SizedBox(height: 5),
                                Container(
                                  alignment: Alignment.center,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: LinearProgressIndicator(
                                          minHeight: 25,
                                          value: double.parse(
                                                  projectManagementController
                                                      .projectData
                                                      .progress!
                                                      .keys
                                                      .toList()[index]) /
                                              100,
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(bluePurpleColor),
                                          backgroundColor:
                                              const Color(0xffD6D6D6),
                                        ),
                                      ),
                                      Text(
                                        "${projectManagementController.projectData.progress!.keys.toList()[index]}%",
                                        style: const TextStyle(
                                            color: whiteColor, fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                                projectManagementController
                                            .projectData.progress!.values
                                            .toList()[index] !=
                                        ""
                                    ? Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          Text(
                                              projectManagementController
                                                  .projectData.progress!.values
                                                  .toList()[index],
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .fontSize)),
                                        ],
                                      )
                                    : const SizedBox(height: 0),
                              ],
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    );
            })
          ],
        ),
      ),
    );
  }
}
