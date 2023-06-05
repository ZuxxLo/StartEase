import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/view/widgets.dart';

import '../controller/project_management_controller.dart';
import '../main.dart';

class ViewRemarks extends StatelessWidget {
  const ViewRemarks({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectManagementController projectManagementController = Get.find();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: Text("viewRemarks".tr),
        actions: [
    Builder(
            builder: (context) {
              bool exists = false;
              for (var permission in userModel.permissions!) {
                if (permission.id == 25) {
                  exists = true;
                }
              }
              return exists
                  ?    IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "enterARemark".tr,
                    content: Column(
                      children: [
                        TextFormField(
                          onChanged: (inputText) {
                            projectManagementController
                                .inputNewRemark(inputText);
                          },
                          decoration:
                              InputDecoration(hintText: "enterARemark".tr),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              projectManagementController.addANewRemark();
                            },
                            child: Text("confirm".tr)),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              projectManagementController.inputNewRemark("");

                              navigator!.pop();
                            },
                            child: Text("cancel".tr))
                      ],
                    ));
                //  projectManagementController.addNewRemark();
              },
              icon: const ImageIcon(
                  size: 30, Svg("assets/icons/add_square_icon.svg")))
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
            SmallBodyText(text: "seeBelowRemarks".tr),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<ProjectManagementController>(builder: (context) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    projectManagementController.projectData.remakrs!.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(10, 7, 15, 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).listTileTheme.tileColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: 45,
                                      width: 45,
                                      child: ProfilePictureForOtherUsers(
                                          userModel: projectManagementController
                                              .projectData
                                              .remakrs![index]
                                              .user!)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "${projectManagementController
                                              .projectData
                                              .remakrs![index]
                                              .user!
                                              .person!
                                              .firstName!} ${projectManagementController
                                              .projectData
                                              .remakrs![index]
                                              .user!
                                              .person!
                                              .lastName!}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                projectManagementController
                                    .projectData.remakrs![index].content!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                projectManagementController.projectData
                                        .remakrs![index].updatedAt ??
                                    projectManagementController
                                        .projectData.remakrs![index].createdAt!
                                        .toString(),
                                // projectManagementController
                                //     .affichageDaysAgo(DateTime.utc(2022,
                                //         1, 30)), /////// hna dkl la date
                                style:
                                    TextStyle(fontSize: 13, color: greyColor),
                              )
                            ],
                          )),
                      projectManagementController
                                  .projectData.remakrs![index].user?.id ==
                              userModel.id
                          ? Positioned(
                              right: -15,
                              top: -10,
                              child: PopupMenuButton<int>(
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: bluePurpleColor,
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    onTap: () {},
                                    value: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("delete".tr),
                                        const ImageIcon(
                                          size: 23,
                                          Svg("assets/icons/delete_icon.svg"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    onTap: () {},
                                    value: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("edit".tr),
                                        const ImageIcon(
                                          size: 20,
                                          Svg("assets/icons/edit_project_icon.svg"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == 1) {
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
                                                        MaterialStateProperty
                                                            .all(redColor)),
                                                onPressed: () {
                                                  projectManagementController
                                                      .deleteRemark(index);
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
                                  } else if (value == 2) {
                                    final formKey = GlobalKey<FormState>();
                                    Get.defaultDialog(
                                        title: "enterARemark".tr,
                                        content: Column(
                                          children: [
                                            Form(
                                                key: formKey,
                                                child: TextFormField(
                                                  initialValue:
                                                      projectManagementController
                                                          .projectData
                                                          .remakrs![index]
                                                          .content!,
                                                  onChanged:
                                                      (String remarkEdited) {
                                                    projectManagementController
                                                        .editRemarkOnChanged(
                                                            remarkEdited);
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "enterARemark".tr;
                                                    }
                                                    return null;
                                                  },
                                                )),
                                            const SizedBox(height: 10),
                                            TextButton(
                                                onPressed: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    projectManagementController
                                                        .editRemark(index);
                                                  }
                                                },
                                                child: Text("confirm".tr)),
                                            const SizedBox(height: 5),
                                            TextButton(
                                                onPressed: () {
                                                  navigator!.pop();
                                                },
                                                child: Text("cancel".tr))
                                          ],
                                        ));
                                  }
                                },
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
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
