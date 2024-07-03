import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/controller/defence_management_controller.dart';

import '../Themes/colors.dart';
import 'widgets.dart';

class ViewDefense extends StatelessWidget {
  const ViewDefense({super.key});

  @override
  Widget build(BuildContext context) {
    final DefenceManagementController defenceManagementController = Get.find();

    final formKey1 = GlobalKey<FormState>();
    final formKey2 = GlobalKey<FormState>();
    final formKey3 = GlobalKey<FormState>();
    final formKey4 = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        //////////////////   title:   Text("Project Name"), //////////////////
        actions: const [
          //   GetBuilder<DefenceManagementController>(builder: (context) {
          //     bool exists = false;
          //     for (var permission in userModel.permissions!) {
          //       if (permission.id == 37) {
          //         exists = true;
          //       }
          //       if (defenceManagementController.defenceData!.id != userModel.id) {
          //         exists = false;
          //       }
          //     }
          //     return exists
          //         ? IconButton(
          //             onPressed: () {
          //               if (!defenceManagementController.isEditingProject) {
          //                 Get.defaultDialog(
          //                     title: "editYourProject".tr,
          //                     content: Column(
          //                       children: [
          //                         TextButton(
          //                             onPressed: () {
          //                               defenceManagementController
          //                                   .enableEditProject();

          //                               navigator!.pop();
          //                             },
          //                             child: Text("confirm".tr)),
          //                         const SizedBox(
          //                           height: 10,
          //                         ),
          //                         TextButton(
          //                             onPressed: () {
          //                               navigator!.pop();
          //                             },
          //                             child: Text("cancel".tr))
          //                       ],
          //                     ));
          //               } else {
          //                 defenceManagementController.enableEditProject();

          //                 MainFunctions.somethingWentWrongSnackBar(
          //                     "editCanceled".tr);
          //               }
          //             },
          //             icon: defenceManagementController.isEditingProject
          //                 ? const ImageIcon(
          //                     Svg("assets/icons/close_square_icon.svg"),
          //                     color: redColor,
          //                     size: 50)
          //                 : const ImageIcon(
          //                     Svg("assets/icons/edit_project_icon.svg"),
          //                     size: 30))
          //         : const SizedBox();
          //   }),
          //   const SizedBox(
          //     width: 10,
          //   )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: PageView(
          controller: defenceManagementController.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Form(
                      key: formKey1,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "date".tr,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),

                          TextFormField(
                              readOnly: true,
                              initialValue:
                                  defenceManagementController.defenceData!.date,
                              onTap: null,
                              keyboardType: TextInputType.datetime,
                              decoration: const InputDecoration(
                                prefixIcon: ImageIcon(
                                    Svg("assets/icons/calendar_icon.svg")),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          ///////////////////time
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "time".tr,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),

                          TextFormField(
                              readOnly: true,
                              initialValue:
                                  defenceManagementController.defenceData!.time,
                              onTap: null,
                              keyboardType: TextInputType.datetime,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.access_time),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          ///////////////////room

                          Builder(builder: (context) {
                            bool exists = false;
                            if (defenceManagementController
                                    .defenceData!.room?.name !=
                                null) {
                              exists = true;
                            }
                            if (exists) {
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "room".tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  TextFormField(
                                      readOnly: true,
                                      initialValue: defenceManagementController
                                              .defenceData!.room?.name ??
                                          defenceManagementController
                                              .defenceData!.otherPlace,
                                      onTap: null,
                                      keyboardType: TextInputType.datetime,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.roofing),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),

                          ///////////////////otherPlace

                          defenceManagementController.defenceData!.otherPlace !=
                                  null
                              ? Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "otherPlace".tr,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    TextFormField(
                                        readOnly: true,
                                        initialValue:
                                            defenceManagementController
                                                .defenceData!.otherPlace!,
                                        onTap: null,
                                        keyboardType: TextInputType.datetime,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.room),
                                        )),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          ///////////////////mode
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "mode".tr,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextFormField(
                              readOnly: true,
                              initialValue: defenceManagementController
                                  .defenceData!.mode!,
                              onTap: null,
                              keyboardType: TextInputType.datetime,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.settings),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          ///////////////////nature
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "nature".tr,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextFormField(
                              readOnly: true,
                              initialValue: defenceManagementController
                                  .defenceData!.nature!,
                              onTap: null,
                              keyboardType: TextInputType.datetime,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.settings),
                              )),
                          const SizedBox(height: 20),

                          TextButton(
                            onPressed: () {
                              if (true) {
                                // formKey.currentState!.validate()
                                //formKey.currentState!.save();
                                defenceManagementController.next();
                              }
                            },
                            child: Text(
                              "createRole5".tr,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "president".tr,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).listTileTheme.tileColor),
                      child: Row(
                        children: [
                          ProfilePictureForOtherUserss(
                              photoUrl: defenceManagementController
                                  .defenceData!.jurys!.president!.photoUrl!,
                              email: defenceManagementController
                                  .defenceData!.jurys!.president!.email!),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              "${defenceManagementController.defenceData!.jurys!.president!.email}",
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // SizedBox(
                          //     height: 45,
                          //     width: 45,
                          //     child: IconButton(
                          //       icon: const DeleteIcon(),
                          //       onPressed: () {},
                          //     )),
                        ],
                      )),
                  const SizedBox(height: 20),
                  Text(
                    "supervisor".tr,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).listTileTheme.tileColor),
                      child: Row(
                        children: [
                          ProfilePictureForOtherUserss(
                              photoUrl: defenceManagementController
                                  .defenceData!.jurys!.supervisor!.photoUrl!,
                              email: defenceManagementController
                                  .defenceData!.jurys!.supervisor!.email!),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              "${defenceManagementController.defenceData!.jurys!.supervisor!.email}",
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // SizedBox(
                          //     height: 45,
                          //     width: 45,
                          //     child: IconButton(
                          //       icon: const DeleteIcon(),
                          //       onPressed: () {},
                          //     )),
                        ],
                      )),
                  const SizedBox(height: 20),
                  Text(
                    "cosupervisor".tr,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).listTileTheme.tileColor),
                      child: Row(
                        children: [
                          ProfilePictureForOtherUserss(
                              photoUrl: defenceManagementController
                                  .defenceData!.jurys!.coSupervisor!.photoUrl!,
                              email: defenceManagementController
                                  .defenceData!.jurys!.coSupervisor!.email!),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              "${defenceManagementController.defenceData!.jurys!.coSupervisor!.email}",
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // SizedBox(
                          //     height: 45,
                          //     width: 45,
                          //     child: IconButton(
                          //       icon: const DeleteIcon(),
                          //       onPressed: () {},
                          //     )),
                        ],
                      )),
                  const SizedBox(height: 20),
                  Text(
                    "examiners".tr,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<DefenceManagementController>(builder: (conttext) {
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: defenceManagementController
                          .defenceData!.jurys!.examiners!.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(context).listTileTheme.tileColor),
                            child: Row(
                              children: [
                                ProfilePictureForOtherUserss(
                                    photoUrl: defenceManagementController
                                        .defenceData!
                                        .jurys!
                                        .examiners![index]
                                        .photoUrl!,
                                    email: defenceManagementController
                                        .defenceData!
                                        .jurys!
                                        .examiners![index]
                                        .email!),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    "${defenceManagementController.defenceData!.jurys!.examiners![index].email}",
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .fontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // SizedBox(
                                //     height: 45,
                                //     width: 45,
                                //     child: IconButton(
                                //       icon: const DeleteIcon(),
                                //       onPressed: () {},
                                //     )),
                              ],
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 20),
                  Text(
                    "projectTeam".tr,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<DefenceManagementController>(builder: (conttext) {
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: defenceManagementController
                          .defenceData!.project!.members!.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(context).listTileTheme.tileColor),
                            child: Row(
                              children: [
                                ProfilePictureForOtherUserss(
                                    photoUrl: defenceManagementController
                                        .defenceData!
                                        .project!
                                        .members![index]
                                        .photoUrl!,
                                    email: defenceManagementController
                                        .defenceData!
                                        .project!
                                        .members![index]
                                        .email!),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    "${defenceManagementController.defenceData!.project!.members![index].email}",
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .fontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // SizedBox(
                                //     height: 45,
                                //     width: 45,
                                //     child: IconButton(
                                //       icon: const DeleteIcon(),
                                //       onPressed: () {},
                                //     )),
                              ],
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 20),
                  defenceManagementController.defenceData!.files!.isNotEmpty
                      ? Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                if (true) {
                                  // formKey.currentState!.validate()
                                  //formKey.currentState!.save();
                                  defenceManagementController.next();
                                }
                              },
                              child: Text(
                                "createRole5".tr,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        )
                      : const SizedBox(),
                  TextButton(
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: bluePurpleColor)),
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => bluePurpleColor.withOpacity(0.2)),
                        backgroundColor:
                            MaterialStateProperty.all(transparentColor)),
                    onPressed: () {
                      if (true) {
                        // formKey.currentState!.validate()
                        //formKey.currentState!.save();
                        defenceManagementController.goBackPageView();
                      }
                    },
                    child: Text("goBack".tr,
                        style: const TextStyle(color: bluePurpleColor)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SingleChildScrollView(
              child: ListView.separated(
                itemCount:
                    defenceManagementController.defenceData!.files!.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      defenceManagementController.downloadfile(
                          defenceManagementController
                              .defenceData!.files!.entries
                              .toList()[index]);
                    },
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).listTileTheme.tileColor),
                        child: Row(
                          children: [
                            const SizedBox(
                                height: 45,
                                width: 45,
                                child: ImageIcon(
                                  size: 30,
                                  Svg("assets/icons/file_icon.svg"),
                                )),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                defenceManagementController
                                    .defenceData!.files!.keys
                                    .toList()[index],
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
