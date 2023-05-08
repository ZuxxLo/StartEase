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
          IconButton(
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
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).listTileTheme.tileColor),
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: ProfilePictureForOtherUsers(
                                      userModel: userModel)),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "skrt",
                                      style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .fontSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "this is so professional",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .fontSize),
                                    ),
                                    Text(
                                      projectManagementController
                                          .affichageDaysAgo(
                                              DateTime.utc(2022, 1, 30)), /////// hna dkl la date
                                      style:const TextStyle(fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Align(
                        alignment: Alignment.topRight,
                        child: PopupMenuButton<int>(
                          icon: const Icon(
                            Icons.more_vert,
                            color: bluePurpleColor,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              padding: EdgeInsets.only(right: 10, left: 10),
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
                              padding: EdgeInsets.only(right: 10, left: 10),
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
                          onSelected: (value) {},
                        ),
                      ),
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
