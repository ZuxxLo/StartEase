import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../Themes/colors.dart';
import '../controller/project_management_controller.dart';
import '../main.dart';
import 'widgets.dart';

class ViewComments extends StatelessWidget {
  const ViewComments({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectManagementController projectManagementController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: Text("viewComments".tr),
        actions: [
          Builder(
            builder: (context) {
              bool exists = false;
              for (var permission in userModel.permissions!) {
                if (permission.id == 38) {
                  exists = true;
                }
              }
              return exists
                  ? IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                            title: "enterAComment".tr,
                            content: Column(
                              children: [
                                TextFormField(
                                  onChanged: (inputText) {
                                    projectManagementController
                                        .inputNewComment(inputText);
                                  },
                                  decoration: InputDecoration(
                                      hintText: "enterAComment".tr),
                                ),
                                const SizedBox(height: 10),
                                TextButton(
                                    onPressed: () {
                                      projectManagementController
                                          .addANewComment();
                                    },
                                    child: Text("confirm".tr)),
                                const SizedBox(height: 10),
                                TextButton(
                                    onPressed: () {
                                      projectManagementController
                                          .inputNewComment("");

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
            GetBuilder<ProjectManagementController>(builder: (context) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    projectManagementController.projectData.comments!.length,
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
                                              .comments![index]
                                              .user!)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "${projectManagementController.projectData.comments![index].user!.person!.firstName!} ${projectManagementController.projectData.comments![index].user!.person!.lastName!}",
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
                                    .projectData.comments![index].content!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    projectManagementController.projectData
                                            .comments![index].updatedAt ??
                                        projectManagementController.projectData
                                            .comments![index].createdAt!
                                            .toString(),
                                    // projectManagementController
                                    //     .affichageDaysAgo(DateTime.utc(2022,
                                    //         1, 30)), /////// hna dkl la date
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  ////////////////////////////replies
                                  const SizedBox(width: 20),
                                  projectManagementController.projectData
                                          .comments![index].replies!.isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            Get.bottomSheet(BottomSheet(
                                              onClosing: () {},
                                              builder: (context) {
                                                return SingleChildScrollView(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 0, 10, 20),
                                                    child: GetBuilder<
                                                            ProjectManagementController>(
                                                        builder: (context) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                Get
                                                                    .defaultDialog(
                                                                        title: "addAReply"
                                                                            .tr,
                                                                        content:
                                                                            Column(
                                                                          children: [
                                                                            TextFormField(
                                                                              onChanged: (inputText) {
                                                                                projectManagementController.inputNewReply(inputText);
                                                                              },
                                                                              decoration: InputDecoration(hintText: "addAReply".tr),
                                                                            ),
                                                                            const SizedBox(height: 10),
                                                                            TextButton(
                                                                                onPressed: () {
                                                                                  projectManagementController.addANewReply(index);
                                                                                },
                                                                                child: Text("confirm".tr)),
                                                                            const SizedBox(height: 10),
                                                                            TextButton(
                                                                                onPressed: () {
                                                                                  projectManagementController.inputNewReply("");

                                                                                  navigator!.pop();
                                                                                },
                                                                                child: Text("cancel".tr))
                                                                          ],
                                                                        ));
                                                                //  projectManagementController.addNewRemark();
                                                              },
                                                              icon: const ImageIcon(
                                                                  size: 30,
                                                                  Svg("assets/icons/add_square_icon.svg"))),
                                                          ListView.separated(
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                projectManagementController
                                                                    .projectData
                                                                    .comments![
                                                                        index]
                                                                    .replies!
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    indexx) {
                                                              return Container(
                                                                  padding:
                                                                      const EdgeInsets.fromLTRB(
                                                                          10,
                                                                          7,
                                                                          15,
                                                                          7),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: Theme.of(
                                                                              context)
                                                                          .listTileTheme
                                                                          .tileColor),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(
                                                                              height: 45,
                                                                              width: 45,
                                                                              child: ProfilePictureForOtherUsers(userModel: projectManagementController.projectData.comments![index].replies![indexx].user!)),
                                                                          const SizedBox(
                                                                              width: 10),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              "${projectManagementController.projectData.comments![index].replies![indexx].user!.person!.firstName!} ${projectManagementController.projectData.comments![index].replies![indexx].user!.person!.lastName!}",
                                                                              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              5),
                                                                      Text(
                                                                        projectManagementController
                                                                            .projectData
                                                                            .comments![index]
                                                                            .replies![indexx]
                                                                            .content!,
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                Theme.of(context).textTheme.titleMedium!.fontSize),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              5),
                                                                      Text(
                                                                        projectManagementController.projectData.comments![index].replies![indexx].updatedAt ??
                                                                            projectManagementController.projectData.comments![index].replies![indexx].createdAt!.toString(),
                                                                        // projectManagementController
                                                                        //     .affichageDaysAgo(DateTime.utc(2022,
                                                                        //         1, 30)), /////// hna dkl la date
                                                                        style:const TextStyle(
                                                                            fontSize:
                                                                                13),
                                                                      )
                                                                    ],
                                                                  ));
                                                            },
                                                            separatorBuilder:
                                                                (context,
                                                                    indexx) {
                                                              return const SizedBox(
                                                                height: 10,
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }));
                                              },
                                            ));
                                          },
                                          child: Text(
                                            "viewReplies".tr,
                                            // projectManagementController
                                            //     .affichageDaysAgo(DateTime.utc(2022,
                                            //         1, 30)), /////// hna dkl la date
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: bluePurpleColor),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Get.defaultDialog(
                                                title: "addAReply".tr,
                                                content: Column(
                                                  children: [
                                                    TextFormField(
                                                      onChanged: (inputText) {
                                                        projectManagementController
                                                            .inputNewReply(
                                                                inputText);
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  "addAReply"
                                                                      .tr),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    TextButton(
                                                        onPressed: () {
                                                          projectManagementController
                                                              .addANewReply(
                                                                  index);
                                                        },
                                                        child:
                                                            Text("confirm".tr)),
                                                    const SizedBox(height: 10),
                                                    TextButton(
                                                        onPressed: () {
                                                          projectManagementController
                                                              .inputNewReply(
                                                                  "");

                                                          navigator!.pop();
                                                        },
                                                        child:
                                                            Text("cancel".tr))
                                                  ],
                                                ));
                                            //  projectManagementController.addNewRemark();
                                          },
                                          child: Text(
                                            "addAReply".tr,
                                            // projectManagementController
                                            //     .affichageDaysAgo(DateTime.utc(2022,
                                            //         1, 30)), /////// hna dkl la date
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: bluePurpleColor),
                                          ),
                                        ),
                                  ///////////////////////////////replies
                                ],
                              )
                            ],
                          )),
                      projectManagementController
                                  .projectData.comments![index].user?.id ==
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
                                                      .deleteComment(index);
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
                                        title: "enterAComment".tr,
                                        content: Column(
                                          children: [
                                            Form(
                                                key: formKey,
                                                child: TextFormField(
                                                  initialValue:
                                                      projectManagementController
                                                          .projectData
                                                          .comments![index]
                                                          .content!,
                                                  onChanged:
                                                      (String remarkEdited) {
                                                    projectManagementController
                                                        .editCommentOnChanged(
                                                            remarkEdited);
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "enterAComment".tr;
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
                                                        .editComment(index);
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
