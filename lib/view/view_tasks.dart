import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/view/widgets.dart';

import '../controller/project_management_controller.dart';
import '../main.dart';
import '../services/languages.dart';

class ViewTasks extends StatelessWidget {
  const ViewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectManagementController projectManagementController = Get.find();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: Text("viewTasks".tr),
        actions: [
          Builder(
            builder: (context) {
              bool exists = false;
              for (var permission in userModel.permissions!) {
                if (permission.id == 43) {
                  exists = true;
                }
              }
              return exists
                  ? IconButton(
                      onPressed: () {
                        projectManagementController.goToAddTask();

                        //  projectManagementController.addNewRemark();
                      },
                      icon: const ImageIcon(
                          size: 30, Svg("assets/icons/add_square_icon.svg")))
                  : const SizedBox();
            },
          )
        ],
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
                    projectManagementController.projectData.tasks!.length,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      projectManagementController
                                          .projectData.tasks![index].title!,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .fontSize,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    projectManagementController
                                        .projectData.tasks![index].status!,
                                    style: const TextStyle(
                                        fontSize: 16, color: bluePurpleColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                projectManagementController
                                    .projectData.tasks![index].description!,
                                textAlign: TextAlign.start,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "requiredAttachs".tr,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 5),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: projectManagementController
                                    .projectData
                                    .tasks![index]
                                    .resources!
                                    .length,
                                itemBuilder: (context, indexx) {
                                  return InkWell(
                                    onTap: () {
                                      projectManagementController.downloadfile(
                                          projectManagementController
                                              .projectData
                                              .tasks![index]
                                              .resources!
                                              .entries
                                              .toList()[indexx]);
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 7, 10, 7),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Theme.of(context)
                                                .listTileTheme
                                                .tileColor),
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
                                                "${projectManagementController.projectData.tasks![index].resources!.keys.toList()[indexx]}",
                                                style: TextStyle(
                                                    fontSize: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .fontSize,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )),
                                  );
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  projectManagementController.projectData
                                              .tasks![index].status ==
                                          "completed"
                                      ? Text(
                                          "${"approvDate".tr} : ${projectManagementController.projectData.tasks![index].completedDate!}",
                                          style: TextStyle(
                                              fontSize: 13, color: greyColor),
                                        )
                                      : Text(
                                          projectManagementController
                                                  .projectData
                                                  .tasks![index]
                                                  .updatedAt ??
                                              projectManagementController
                                                  .projectData
                                                  .tasks![index]
                                                  .createdAt!
                                                  .toString(),
                                          // projectManagementController
                                          //     .affichageDaysAgo(DateTime.utc(2022,
                                          //         1, 30)), /////// hna dkl la date
                                          style: TextStyle(
                                              fontSize: 13, color: greyColor),
                                        ),
                                  Text(
                                    "${"deadline".tr} : ${projectManagementController.projectData.tasks![index].deadline!}",
                                    style: TextStyle(
                                        fontSize: 13, color: greyColor),
                                  ),
                                  projectManagementController.projectData
                                              .tasks![index].status !=
                                          "in progress"
                                      ? Text(
                                          "viewSubmissions".tr,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: bluePurpleColor),
                                        )
                                      : const SizedBox(),
                                ],
                              )
                            ],
                          )),
                      Positioned(
                        right: -15,
                        top: -10,
                        child: Builder(builder: (context) {
                          bool editExists = false;
                          bool deleteExists = false;
                          bool validateExists = false;
                          bool submitExists = false;

                          for (var permission in userModel.permissions!) {
                            if (permission.id == 45) {
                              editExists = true;
                            }
                            if (permission.id == 44) {
                              deleteExists = true;
                            }
                            if (permission.id == 5) {
                              validateExists = true;
                            }
                            if (permission.id == 6) {
                              submitExists = true;
                            }
                          }
                          return PopupMenuButton<int>(
                            icon: const Icon(
                              Icons.more_vert,
                              color: bluePurpleColor,
                            ),
                            itemBuilder: (context) => [
                              if (deleteExists)
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
                              if (editExists)
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
                              if (projectManagementController
                                      .projectData.tasks![index].status ==
                                  "pending")
                                PopupMenuItem(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  onTap: () {},
                                  value: 3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("validate".tr),
                                      const ImageIcon(
                                        size: 20,
                                        Svg("assets/icons/shield_tick_icon.svg"),
                                      ),
                                    ],
                                  ),
                                ),
                              if (submitExists &&
                                  projectManagementController
                                          .projectData.tasks![index].status ==
                                      "in progress")
                                PopupMenuItem(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  onTap: () {},
                                  value: 4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("submit".tr),
                                      const ImageIcon(
                                        size: 20,
                                        Svg("assets/icons/import_file_icon.svg"),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                            onSelected: (value) {
                              print(value);
                              if (value == 1) {
                                if (deleteExists) {
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
                                                    .deleteTask(index);
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
                                } else {
                                  MainFunctions.somethingWentWrongSnackBar(
                                      "noPermission".tr);
                                }
                              } else if (value == 2) {
                                if (editExists) {
                                  final formKey = GlobalKey<FormState>();
                                  Get.bottomSheet(BottomSheet(
                                      onClosing: () {},
                                      builder: (context) {
                                        return SingleChildScrollView(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 0),
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Column(
                                            children: [
                                              Form(
                                                  key: formKey,
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        initialValue:
                                                            projectManagementController
                                                                .projectData
                                                                .tasks![index]
                                                                .title,
                                                        maxLength: 255,
                                                        decoration: InputDecoration(
                                                            prefixIcon:
                                                                const ImageIcon(Svg(
                                                                    "assets/icons/tasks_icon.svg")),
                                                            filled: true,
                                                            fillColor: Theme.of(
                                                                    context)
                                                                .listTileTheme
                                                                .tileColor,
                                                            hintText:
                                                                "title".tr,
                                                            hintStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        17)),
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return "fillFiled"
                                                                .tr;
                                                          }
                                                          if (value.isEmpty) {
                                                            return "fillFiled"
                                                                .tr;
                                                          }
                                                          return null;
                                                        },
                                                        onChanged: (value) {
                                                          projectManagementController
                                                              .ipnutEditTaskTitle(
                                                                  value, index);
                                                        },
                                                      ),

                                                      GetBuilder<
                                                              ProjectManagementController>(
                                                          builder: (context) {
                                                        return TextFormField(
                                                          initialValue:
                                                              projectManagementController
                                                                  .projectData
                                                                  .tasks![index]
                                                                  .description,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .done,
                                                          maxLength: 250,
                                                          maxLines: 5,
                                                          validator:
                                                              (inputValue) {
                                                            if (inputValue!
                                                                .isEmpty) {
                                                              return "fillFiled"
                                                                  .tr;
                                                            }
                                                            return null;
                                                          },
                                                          onChanged: (value) {
                                                            projectManagementController
                                                                .ipnutEditTaskDesc(
                                                                    value,
                                                                    index);
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "description"
                                                                    .tr,
                                                            hintStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        17),
                                                          ),
                                                        );
                                                      }),

                                                      GetBuilder<
                                                              ProjectManagementController>(
                                                          builder: (contexxt) {
                                                        return TextFormField(
                                                            readOnly: true,
                                                            onTap: () {
                                                              showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      DateTime
                                                                          .now(),
                                                                  firstDate:
                                                                      DateTime
                                                                          .now(),
                                                                  lastDate:
                                                                      DateTime.utc(
                                                                          2024),
                                                                  helpText: "",
                                                                  locale: Languages
                                                                      .initLang(),
                                                                  builder:
                                                                      (context,
                                                                          child) {
                                                                    return Theme(
                                                                      data: Theme.of(
                                                                              context)
                                                                          .copyWith(
                                                                        textButtonTheme:
                                                                            const TextButtonThemeData(),
                                                                      ),
                                                                      child:
                                                                          child!,
                                                                    );
                                                                  }).then((value) {
                                                                if (value !=
                                                                    null) {
                                                                  projectManagementController
                                                                      .ipnutEditTaskDeadlineDate(
                                                                          value,
                                                                          index);
                                                                }
                                                              });
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .datetime,
                                                            decoration: InputDecoration(
                                                                prefixIcon:
                                                                    const ImageIcon(Svg(
                                                                        "assets/icons/calendar_icon.svg")),
                                                                hintText: projectManagementController
                                                                        .projectData
                                                                        .tasks![
                                                                            index]
                                                                        .deadline ??
                                                                    "deadline"
                                                                        .tr));
                                                      }),
                                                      const SizedBox(
                                                          height: 10),
                                                      //////////////////
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "requiredAttachs".tr,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),

                                                      GetBuilder<
                                                              ProjectManagementController>(
                                                          builder: (context) {
                                                        return ListView
                                                            .separated(
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const SizedBox(
                                                                height: 5);
                                                          },
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              projectManagementController
                                                                  .projectData
                                                                  .tasks![index]
                                                                  .resources!
                                                                  .length,
                                                          itemBuilder: (context,
                                                              indeex) {
                                                            return Container(
                                                                padding: const EdgeInsets
                                                                        .fromLTRB(
                                                                    10,
                                                                    7,
                                                                    10,
                                                                    7),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Theme.of(
                                                                            context)
                                                                        .listTileTheme
                                                                        .tileColor),
                                                                child: Row(
                                                                  children: [
                                                                    const SizedBox(
                                                                        height:
                                                                            45,
                                                                        width:
                                                                            45,
                                                                        child:
                                                                            ImageIcon(
                                                                          size:
                                                                              30,
                                                                          Svg("assets/icons/file_icon.svg"),
                                                                        )),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        projectManagementController
                                                                            .projectData
                                                                            .tasks![index]
                                                                            .resources!
                                                                            .keys
                                                                            .toList()[indeex]
                                                                            .toString(),
                                                                      ),
                                                                    ),
                                                                    IconButton(
                                                                      icon:
                                                                          const DeleteIcon(),
                                                                      onPressed:
                                                                          () {
                                                                        print(
                                                                            "sq");

                                                                        if (projectManagementController.projectData.tasks![index].resources!.length ==
                                                                            1) {
                                                                          MainFunctions.somethingWentWrongSnackBar(
                                                                              "atLeast1".tr);
                                                                        } else {
                                                                          projectManagementController.deleteditResTask(
                                                                              projectManagementController.projectData.tasks![index].resources!.keys.toList()[indeex],
                                                                              index);
                                                                        }
                                                                      },
                                                                    ),
                                                                  ],
                                                                ));
                                                          },
                                                        );
                                                      }),
                                                      const SizedBox(height: 5),
                                                      Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10, 7, 10, 7),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Theme.of(
                                                                      context)
                                                                  .listTileTheme
                                                                  .tileColor),
                                                          child: Row(
                                                            children: [
                                                              const SizedBox(
                                                                  height: 45,
                                                                  width: 45,
                                                                  child:
                                                                      ImageIcon(
                                                                    size: 30,
                                                                    Svg("assets/icons/file_icon.svg"),
                                                                  )),
                                                              const Expanded(
                                                                child: Text(
                                                                  "",
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 45,
                                                                  child:
                                                                      TextButton(
                                                                          style: ButtonStyle(
                                                                              fixedSize: MaterialStateProperty.all(const Size(50, 0)),
                                                                              backgroundColor: MaterialStateProperty.all(transparentColor),
                                                                              overlayColor: MaterialStateColor.resolveWith((states) => bluePurpleColor.withOpacity(0.2)),
                                                                              foregroundColor: MaterialStateProperty.all(bluePurpleColor)),
                                                                          onPressed: () {
                                                                            Get.defaultDialog(
                                                                                onWillPop: () {
                                                                                  return Future.value(false);
                                                                                },
                                                                                title: "enterRessName".tr,
                                                                                content: Form(
                                                                                  key: projectManagementController.formKeyRessTask,
                                                                                  child: Column(
                                                                                    children: [
                                                                                      TextFormField(
                                                                                        validator: (String? input) {
                                                                                          if (input == null) {
                                                                                            return "enterRessName".tr;
                                                                                          }
                                                                                          if (input.isEmpty) {
                                                                                            return "enterRessName".tr;
                                                                                          }

                                                                                          return null;
                                                                                        },
                                                                                        onChanged: (String input) {
                                                                                          projectManagementController.inputResName(input);
                                                                                        },
                                                                                        decoration: InputDecoration(hintText: "enterRessName".tr),
                                                                                      ),
                                                                                      const SizedBox(height: 10),
                                                                                      TextButton(
                                                                                          onPressed: () {
                                                                                            if (projectManagementController.formKeyRessTask.currentState!.validate()) {
                                                                                              projectManagementController.formKeyRessTask.currentState!.save();
                                                                                              projectManagementController.editAddARess(index);
                                                                                              navigator!.pop();
                                                                                            }
                                                                                          },
                                                                                          child: Text("confirm".tr)),
                                                                                      const SizedBox(height: 10),
                                                                                      TextButton(
                                                                                          onPressed: () {
                                                                                            projectManagementController.inputResName("");

                                                                                            navigator!.pop();
                                                                                          },
                                                                                          child: Text("clear".tr))
                                                                                    ],
                                                                                  ),
                                                                                ));
                                                                          },
                                                                          child: Text("add".tr))),
                                                            ],
                                                          )),

                                                      ///

                                                      const SizedBox(
                                                          height: 20),
                                                      TextButton(
                                                        onPressed: () {
                                                          if (formKey
                                                              .currentState!
                                                              .validate()) {
                                                            formKey
                                                                .currentState!
                                                                .save();

                                                            projectManagementController.editTask(
                                                                projectManagementController
                                                                    .projectData
                                                                    .tasks![index]);
                                                          }
                                                        },
                                                        child: Text(
                                                          "edit".tr,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 20)
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        );
                                      }));
                                } else {
                                  MainFunctions.somethingWentWrongSnackBar(
                                      "noPermission".tr);
                                }
                              } else if (value == 3) {
                                if (validateExists) {
                                  Get.defaultDialog(
                                      title: "",
                                      content: Column(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                projectManagementController
                                                    .validateTask(index, true);
                                              },
                                              child: Text("validate".tr)),
                                          const SizedBox(height: 5),
                                          TextButton(
                                              onPressed: () {
                                                projectManagementController
                                                    .validateTask(index, false);
                                              },
                                              child: Text("refuse".tr)),
                                          const SizedBox(height: 5),
                                          TextButton(
                                              onPressed: () {
                                                navigator!.pop();
                                              },
                                              child: Text("cancel".tr))
                                        ],
                                      ));
                                }
                              } else if (value == 4) {
                                if (submitExists) {
                                  final formkey = GlobalKey<FormState>();
                                  Get.defaultDialog(
                                      title: "",
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                projectManagementController
                                                    .importTaskFile();
                                              },
                                              icon: const ImageIcon(
                                                size: 30,
                                                color: bluePurpleColor,
                                                Svg("assets/icons/import_file_icon.svg"),
                                              )),
                                          Form(
                                              key: formkey,
                                              child: TextFormField(
                                                maxLines: 2,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "";
                                                  }
                                                },
                                                onChanged: (value) {
                                                  projectManagementController
                                                      .projectData
                                                      .tasks![index]
                                                      .description = value;
                                                },
                                                decoration: InputDecoration(
                                                    hintText: "description".tr),
                                              )),
                                          const SizedBox(height: 10),
                                          TextButton(
                                              onPressed: () {
                                                if (formkey.currentState!
                                                    .validate()) {
                                                  formkey.currentState!.save();
                                                  projectManagementController
                                                      .submitTask(
                                                          projectManagementController
                                                              .projectData
                                                              .tasks![index]);
                                                }
                                              },
                                              child: Text("submit".tr)),
                                          const SizedBox(height: 5),
                                          TextButton(
                                              onPressed: () {
                                                navigator!.pop();
                                              },
                                              child: Text("cancel".tr))
                                        ],
                                      ));
                                }
                              }
                            },
                          );
                        }),
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
