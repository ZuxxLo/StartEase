import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/view/widgets.dart';

import '../Themes/colors.dart';
import '../controller/project_management_controller.dart';
import '../services/languages.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectManagementController projectManagementController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Form(
                key: projectManagementController.formKeyAddTask,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("title".tr,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      maxLength: 255,
                      decoration: InputDecoration(
                          prefixIcon: const ImageIcon(
                              Svg("assets/icons/tasks_icon.svg")),
                          filled: true,
                          fillColor: Theme.of(context).listTileTheme.tileColor,
                          hintText: "title".tr,
                          hintStyle: const TextStyle(fontSize: 17)),
                      validator: (value) {
                        if (value == null) {
                          return "fillFiled".tr;
                        }
                        if (value.isEmpty) {
                          return "fillFiled".tr;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        projectManagementController.ipnutNewTaskTitle(value);
                      },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("description".tr,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GetBuilder<ProjectManagementController>(builder: (context) {
                      return TextFormField(
                        textInputAction: TextInputAction.done,
                        maxLength: 250,
                        maxLines: 5,
                        validator: (inputValue) {
                          if (inputValue!.isEmpty) {
                            return "fillFiled".tr;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          projectManagementController.ipnutNewTaskDesc(value);
                        },
                        decoration: InputDecoration(
                          hintText: "description".tr,
                          hintStyle: const TextStyle(fontSize: 17),
                        ),
                      );
                    }),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("deadline".tr,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GetBuilder<ProjectManagementController>(
                        builder: (contexxt) {
                      return TextFormField(
                          readOnly: true,
                          validator: (value) {
                            if (projectManagementController.newTask.deadline ==
                                null) {
                              return "enterADate".tr;
                            }
                            if (projectManagementController
                                .newTask.deadline!.isEmpty) {
                              return "enterADate".tr;
                            }

                            return null;
                          },
                          onTap: () {
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.utc(2024),
                                helpText: "",
                                locale: Languages.initLang(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      textButtonTheme:
                                          const TextButtonThemeData(),
                                    ),
                                    child: child!,
                                  );
                                }).then((value) {
                              if (value != null) {
                                projectManagementController
                                    .inputDeadlineDate(value);
                              }
                            });
                          },
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              prefixIcon: const ImageIcon(
                                  Svg("assets/icons/calendar_icon.svg")),
                              hintText: projectManagementController
                                      .newTask.deadline ??
                                  "deadline".tr));
                    }),
                    const SizedBox(height: 10),
                    //////////////////
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "requiredAttachs".tr,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 5),

                    GetBuilder<ProjectManagementController>(builder: (context) {
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 5);
                        },
                        shrinkWrap: true,
                        itemCount: projectManagementController
                            .newTask.resources!.length,
                        itemBuilder: (context, indeex) {
                          return Container(
                              padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                  Expanded(
                                    child: Text(
                                      projectManagementController
                                          .newTask.resources!.keys
                                          .toList()[indeex]
                                          .toString(),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const DeleteIcon(),
                                    onPressed: () {
                                      projectManagementController
                                          .deleteResAddTask(
                                              projectManagementController
                                                  .newTask.resources!.keys
                                                  .toList()[indeex]);
                                    },
                                  ),
                                ],
                              ));
                        },
                      );
                    }),
                    const SizedBox(height: 5),
                    Container(
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
                            const Expanded(
                              child: Text(
                                "",
                              ),
                            ),
                            SizedBox(
                                height: 45,
                                child: TextButton(
                                    style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                            const Size(50, 0)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                transparentColor),
                                        overlayColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => bluePurpleColor
                                                    .withOpacity(0.2)),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                bluePurpleColor)),
                                    onPressed: () {
                                      Get.defaultDialog(
                                          onWillPop: () {
                                            return Future.value(false);
                                          },
                                          title: "enterRessName".tr,
                                          content: Form(
                                            key: projectManagementController
                                                .formKeyRessTask,
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
                                                    projectManagementController
                                                        .inputResName(input);
                                                  },
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "enterRessName".tr),
                                                ),
                                                const SizedBox(height: 10),
                                                TextButton(
                                                    onPressed: () {
                                                      if (projectManagementController
                                                          .formKeyRessTask
                                                          .currentState!
                                                          .validate()) {
                                                        projectManagementController
                                                            .formKeyRessTask
                                                            .currentState!
                                                            .save();
                                                        projectManagementController
                                                            .addARess();
                                                        navigator!.pop();
                                                      }
                                                    },
                                                    child: Text("confirm".tr)),
                                                const SizedBox(height: 10),
                                                TextButton(
                                                    onPressed: () {
                                                      projectManagementController
                                                          .inputResName("");

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

                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        if (projectManagementController
                            .formKeyAddTask.currentState!
                            .validate()) {
                          projectManagementController
                              .formKeyAddTask.currentState!
                              .save();

                          projectManagementController.addATask();
                        }
                      },
                      child: Text(
                        "submit".tr,
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
