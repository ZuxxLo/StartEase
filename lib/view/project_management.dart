import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:startease/Themes/colors.dart';
import 'package:startease/controller/download.dart';
import 'package:startease/main.dart';
import 'package:startease/view/widgets.dart';

import '../controller/project_management_controller.dart';
import '../model/roles_model.dart';

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
        actions: [
          Builder(
            builder: (context) {
              bool canAuthorize = false;
              bool canDownloadFile = false;
              for (var permission in userModel.permissions!) {
                if (permission.id == 4) {
                  canAuthorize = true;
                }
              }
              if (projectManagementController
                  .projectData.isAuthorizedDefence!) {
                canDownloadFile = true;
                canAuthorize = false;
              }
              if (projectManagementController.projectData.files!.isEmpty) {
                canDownloadFile = false;
              }
              if (projectManagementController.projectData.supervisor!.id!=userModel.id) {
                canAuthorize = false;
              }
              if (projectManagementController.projectData.status !=
                  "accepted") {
                canAuthorize = false;
              }
              if (canAuthorize) {
                return IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                        title: "areUSure".tr,
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  projectManagementController
                                      .importAuthorizeProject();
                                },
                                icon: const ImageIcon(
                                  size: 30,
                                  color: bluePurpleColor,
                                  Svg("assets/icons/import_file_icon.svg"),
                                )),
                            TextButton(
                                onPressed: () {
                                  projectManagementController
                                      .authorizeProject();
                                },
                                child: Text("authorize".tr)),
                            const SizedBox(height: 5),
                            TextButton(
                                onPressed: () {
                                  navigator!.pop();
                                },
                                child: Text("cancel".tr)),
                          ],
                        ));
                  },
                  icon: const ImageIcon(
                    Svg("assets/icons/shield_tick_icon.svg"),
                    size: 30,
                  ),
                );
              } else if (canDownloadFile) {
                return IconButton(
                    onPressed: () async {
                      //var path = "/storage/emulated/0/Download/";
                      print(projectManagementController
                          .projectData.files!.length);
                      MapEntry temp = MapEntry(
                          projectManagementController.projectData
                                  .files!["thesis defence authorization file"]
                              ["name"],
                          projectManagementController.projectData
                                  .files!["thesis defence authorization file"]
                              ["link"]);
                      print(temp);
                      if (projectManagementController.projectData
                                  .files!["thesis defence authorization file"]
                              ["link"] ==
                          {}) {
                      } else {
                        // Downloader.download(temp.value, path);
                        projectManagementController.downloadfile(temp);
                      }
                    },
                    icon: const Icon(
                      Icons.download,
                      size: 30,
                      color: bluePurpleColor,
                    ));
              } else {
                return const SizedBox();
              }
            },
          ),
          // projectManagementController.projectData.isAuthorizedDefence!
          //     ? const ImageIcon(
          //         Svg("assets/icons/done_tick_icon.svg"),
          //         size: 30,
          //       )
          //     : const SizedBox(),
          // projectManagementController.projectData.status == "accepted"
          //     ? projectManagementController.projectData.isAuthorizedDefence ==
          //             false
          //         ? IconButton(
          //             onPressed: () {
          //               Get.defaultDialog(
          //                   title: "areUSure".tr,
          //                   content: Column(
          //                     mainAxisAlignment: MainAxisAlignment.end,
          //                     crossAxisAlignment: CrossAxisAlignment.end,
          //                     children: [
          //                       IconButton(
          //                           onPressed: () {
          //                             projectManagementController
          //                                 .importAuthorizeProject();
          //                           },
          //                           icon: const ImageIcon(
          //                             size: 30,
          //                             color: bluePurpleColor,
          //                             Svg("assets/icons/import_file_icon.svg"),
          //                           )),
          //                       TextButton(
          //                           onPressed: () {
          //                             projectManagementController
          //                                 .authorizeProject();
          //                           },
          //                           child: Text("authorize".tr)),
          //                       const SizedBox(height: 5),
          //                       TextButton(
          //                           onPressed: () {
          //                             navigator!.pop();
          //                           },
          //                           child: Text("cancel".tr)),
          //                     ],
          //                   ));
          //             },
          //             icon: const ImageIcon(
          //               Svg("assets/icons/shield_tick_icon.svg"),
          //               size: 30,
          //             ),
          //           )
          //         : projectManagementController.projectData.files!.isNotEmpty
          //             ? IconButton(
          //                 onPressed: () async {
          //                   //var path = "/storage/emulated/0/Download/";
          //                   print(projectManagementController
          //                       .projectData.files!.length);
          //                   // MapEntry temp = MapEntry(
          //                   //     projectManagementController.projectData
          //                   //             .files!["thesis defence authorization file"]
          //                   //         ["name"],
          //                   //     projectManagementController.projectData
          //                   //             .files!["thesis defence authorization file"]
          //                   //         ["link"]);
          //                   // print(temp);
          //                   // if (projectManagementController.projectData
          //                   //             .files!["thesis defence authorization file"]
          //                   //         ["link"] ==
          //                   //     {}) {
          //                   // } else {
          //                   //   // Downloader.download(temp.value, path);
          //                   //   projectManagementController.downloadfile(temp);
          //                   // }
          //                 },
          //                 icon: const Icon(
          //                   Icons.download,
          //                   size: 30,
          //                   color: bluePurpleColor,
          //                 ))
          //             : const SizedBox()
          //     : const SizedBox()
        ],
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

          ///////////////////// DropdownButtonFormField
          GetBuilder<ProjectManagementController>(
            builder: (context) {
              bool exists = false;
              for (var permission in userModel.permissions!) {
                if (permission.id == 1) {
                  exists = true;
                }
              }
              if (projectManagementController.projectData.status ==
                  "accepted") {
                exists = false;
              }
              if (projectManagementController.projectData.status == "refused") {
                exists = false;
              }

              return DropdownButtonFormField(
                isExpanded: true,
                isDense: false,
                menuMaxHeight: 300,
                iconSize: 0.0,
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: ImageIcon(
                        Svg("assets/icons/${projectManagementController.getStatusIcon()}.svg"),
                        size: 30,
                      ),
                    ),
                    prefixIconColor:
                        projectManagementController.getStatusColorIn(),
                    suffixIconColor:
                        projectManagementController.getStatusColorIn(),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.expand_more, size: 25),
                    ),
                    focusColor: projectManagementController.getStatusColorOut(),
                    filled: true,
                    fillColor: projectManagementController.getStatusColorOut(),
                    hintStyle: TextStyle(
                      fontSize: 17,
                      color: projectManagementController.getStatusColorIn(),
                    )),
                validator: (value) {
                  if (value == null) {
                    return "selectDomicileEstab".tr;
                  }
                  if (value.isEmpty) {
                    return "selectDomicileEstab".tr;
                  }
                  return null;
                },
                value: projectManagementController.getInitialStatus(),
                dropdownColor: lightBlueColor,
                onChanged: exists == false
                    ? null
                    : (String? newStatus) {
                        Get.defaultDialog(
                            barrierDismissible: false,
                            onWillPop: () {
                              return Future.value(false);
                            },
                            title: "updateStatus".tr,
                            content: Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      projectManagementController
                                          .updateStatus(newStatus);
                                      navigator?.pop();
                                    },
                                    child: Text("confirm".tr)),
                                const SizedBox(height: 10),
                                TextButton(
                                    onPressed: () {
                                      navigator?.pop();
                                    },
                                    child: Text("cancel".tr))
                              ],
                            ));
                      },
                items: projectManagementController.statusList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          color:
                              projectManagementController.getStatusColorIn()),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          ///////////////////// DropdownButtonFormField

          // ListTile(
          //   dense: true,
          //   onTap: () {
          //     Get.defaultDialog(
          //         title: " ",
          //         content: Column(
          //           children: [
          //             TextButton(onPressed: () {}, child: Text("validated".tr)),
          //             TextButton(onPressed: () {}, child: Text("pending".tr)),
          //             TextButton(onPressed: () {}, child: Text("refused".tr)),
          //             TextButton(onPressed: () {}, child: Text("recourse".tr)),
          //           ],
          //         ));
          //   },
          //   trailing: const Icon(Icons.expand_more, size: 25),
          //   leading: ImageIcon(
          //     Svg("assets/icons/${projectManagementController.getStatusIcon()}.svg"),
          //     size: 30,
          //   ),
          //   title: Text(
          //     projectManagementController.getStatusString()!,
          //     style: TextStyle(
          //         fontSize: 20,
          //         color: projectManagementController.getStatusColorIn()),
          //   ),
          //   iconColor: projectManagementController.getStatusColorIn(),
          //   tileColor: projectManagementController.getStatusColorOut(),
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "projectAdvanc".tr,
          //     ),
          //     TextButton(
          //         style: ButtonStyle(
          //             alignment: Alignment.center,
          //             fixedSize: MaterialStateProperty.all(const Size(100, 40)),
          //             backgroundColor:
          //                 MaterialStateProperty.all(transparentColor),
          //             overlayColor: MaterialStateColor.resolveWith(
          //                 (states) => bluePurpleColor.withOpacity(0.2)),
          //             foregroundColor:
          //                 MaterialStateProperty.all(bluePurpleColor)),
          //         onPressed: () {
          //           projectManagementController.updateProgressBar();
          //         },
          //         child: Text("update".tr)),
          //   ],
          // ),
          // GetBuilder<ProjectManagementController >(
          //   builder: (context) {
          //     return Container(
          //       alignment: Alignment.center,
          //       child: Stack(
          //         alignment: Alignment.center,
          //         children: [
          //           ClipRRect(
          //             borderRadius: BorderRadius.circular(10),
          //             child: LinearProgressIndicator(
          //               minHeight: 25,
          //               value: double.parse(projectManagementController
          //                   .projectData.progress!.keys.last)/100,
          //               valueColor:
          //                   const AlwaysStoppedAnimation<Color>(bluePurpleColor),
          //               backgroundColor: const Color(0xffD6D6D6),
          //             ),
          //           ),
          //           Text(
          //             "${projectManagementController.projectData.progress!.keys.last}%",
          //             style: const TextStyle(color: whiteColor, fontSize: 15),
          //           )
          //         ],
          //       ),
          //     );
          //   }
          // ),
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
          ///////////////////// goToViewMyProject
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
                        ListTile(
                          onTap: () {
                            print("*//*/**/");
                            projectManagementController.goToViewMyProject();
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
                          height: 5,
                        ),
                      ],
                    )
                  : const SizedBox();
            },
          ),
          ///////////////////// goToViewMyProject
          ///////////////////// goToTasks
          Builder(
            builder: (context) {
              bool exists = false;
              for (var permission in userModel.permissions!) {
                if (permission.id == 42) {
                  exists = true;
                }
              }
              if (projectManagementController.projectData.status !=
                  "accepted") {
                exists = false;
              }

              return exists
                  ? Column(
                      children: [
                        ListTile(
                          onTap: () {
                            projectManagementController.goToTasks();
                          },
                          dense: true,
                          leading: const ImageIcon(
                              Svg("assets/icons/tasks_icon.svg")),
                          title: Text(
                            "tasks".tr,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : const SizedBox();
            },
          ),
          ///////////////////// goToTasks

          ///////////////////// goToComments
          Builder(
            builder: (context) {
              bool exists = false;
              for (var permission in userModel.permissions!) {
                if (permission.id == 40) {
                  exists = true;
                }
              }
              if (projectManagementController.projectData.status !=
                  "accepted") {
                exists = false;
              }

              return exists
                  ? Column(
                      children: [
                        ListTile(
                          onTap: () {
                            projectManagementController.goToComments();
                          },
                          dense: true,
                          leading: const ImageIcon(
                              Svg("assets/icons/comments_icon.svg")),
                          title: Text(
                            "comments".tr,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : const SizedBox();
            },
          ),
          ///////////////////// goToComments

          ///////////////////// goToRemarks
          Builder(
            builder: (context) {
              bool exists = false;
              for (var permission in userModel.permissions!) {
                if (permission.id == 27) {
                  exists = true;
                }
              }

              return exists
                  ? Column(
                      children: [
                        ListTile(
                          onTap: () {
                            projectManagementController.loadRemarks();
                          },
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          leading: const ImageIcon(
                              Svg("assets/icons/remarques_icon.svg")),
                          title: Text(
                            "remarks".tr,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : const SizedBox();
            },
          ),
          ///////////////////// goToRemarks

          ///////////////////// goToProjectObserv
          Builder(
            builder: (context) {
              bool exists = false;
              for (var permission in userModel.permissions!) {
                if (permission.id == 2) {
                  exists = true;
                }
              }
              if (projectManagementController.projectData.status !=
                  "accepted") {
                exists = false;
              }

              return exists
                  ? Column(
                      children: [
                        projectManagementController.projectData.status ==
                                "accepted"
                            ? ListTile(
                                onTap: () {
                                  projectManagementController
                                      .goToProjectObserv();
                                },
                                dense: true,
                                visualDensity:
                                    const VisualDensity(vertical: -4),
                                leading: const ImageIcon(
                                    Svg("assets/icons/view_project_icon.svg")),
                                title: Text(
                                  "projectObserv".tr,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    )
                  : const SizedBox();
            },
          ),
          ///////////////////// goToProjectObserv
          ///
          ///////////////////// createDefense
          Builder(
            builder: (context) {
              bool exists = false;
              for (var permission in userModel.permissions!) {
                if (permission.id == 24) {
                  exists = true;
                }
              }
              if (projectManagementController.projectData.isAuthorizedDefence ==
                  false) {
                exists = false;
              }
              if (projectManagementController.projectData.defenceId != null) {
                exists = false;
              }

              return exists
                  ? Column(
                      children: [
                        const SizedBox(height: 5),
                        ListTile(
                          onTap: () {
                            projectManagementController.goToCreateNewDefense();
                          },
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          leading: const Icon(
                            Icons.filter_frames_outlined,
                          ),
                          title: Text(
                            "createNewDefense".tr,
                            style: const TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    )
                  : const SizedBox();
            },
          ),
          ///////////////////// createDefense
          ///////////////////// withdraw
          Builder(
            builder: (context) {
              bool exists = false;
              for (var permission in userModel.permissions!) {
                if (permission.id == 36) {
                  print(permission.name);
                  exists = true;
                }
              }
              if (projectManagementController.projectData.status != "pending") {
                exists = false;
              }
              if (projectManagementController.projectData.projectHolder!.id !=
                  userModel.id) {
                exists = false;
              }

              return exists
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: "areUSure".tr,
                                content: Column(
                                  children: [
                                    TextButton.icon(
                                        icon: const ImageIcon(
                                          size: 23,
                                          Svg("assets/icons/delete_icon.svg"),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    redColor)),
                                        onPressed: () {
                                          projectManagementController
                                              .withdrawProject();
                                        },
                                        label: Text("delete".tr)),
                                    const SizedBox(height: 5),
                                    TextButton(
                                        onPressed: () {
                                          navigator!.pop();
                                        },
                                        child: Text("cancel".tr))
                                  ],
                                ));
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(transparentColor),
                            foregroundColor:
                                MaterialStateProperty.all(redColor),
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => redColor.withOpacity(0.2)),
                          ),
                          child: Text(
                            "withdraw".tr,
                          ),
                        )
                      ],
                    )
                  : const SizedBox();
            },
          ),
          ///////////////////// withdraw
        ],
      ),
    );
  }
}
