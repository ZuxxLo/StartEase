import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/main.dart';

import '../Themes/colors.dart';
import '../controller/project_management_controller.dart';
import 'widgets.dart';

class ViewProject extends StatelessWidget {
  const ViewProject({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectManagementController projectManagementController = Get.find();
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: const Text("Project Name"), //////////////////
        actions: [
          GetBuilder<ProjectManagementController>(builder: (context) {
            return IconButton(
                onPressed: () {
                  if (!projectManagementController.isEditingProject) {
                    Get.defaultDialog(
                        title: "editYourProject".tr,
                        content: Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  projectManagementController
                                      .enableEditProject();
                                  navigator!.pop();
                                },
                                child: Text("confirm".tr)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  navigator!.pop();
                                },
                                child: Text("cancel".tr))
                          ],
                        ));
                  } else {
                    projectManagementController.enableEditProject();
                    MainFunctions.somethingWentWrongSnackBar("editCanceled".tr);
                  }
                },
                icon: projectManagementController.isEditingProject
                    ? const ImageIcon(Svg("assets/icons/close_square_icon.svg"),
                        color: redColor, size: 50)
                    : const ImageIcon(Svg("assets/icons/edit_project_icon.svg"),
                        size: 30));
          }),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        height: screenHeight,
        child: PageView(
          controller: projectManagementController.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Form(
                      key: projectManagementController.formKey1,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("domicileEstab".tr),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GetBuilder<ProjectManagementController>(
                              builder: (contdext) {
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                  prefixIcon: const ImageIcon(Svg(
                                      "assets/icons/domicile_estab_icon.svg")),
                                  filled: true,
                                  fillColor:
                                      Theme.of(context).listTileTheme.tileColor,
                                  hintText: "domicileEstab".tr,
                                  hintStyle: const TextStyle(fontSize: 17)),
                              dropdownColor:
                                  Get.isDarkMode ? greyColor : lightBlueColor,
                              validator: (value) {
                                if (value == null) {
                                  return "selectDomicileEstab".tr;
                                }
                                if (value.isEmpty) {
                                  return "selectDomicileEstab".tr;
                                }
                                return null;
                              },
                              onChanged:
                                  projectManagementController.isEditingProject
                                      ? (String? newValue) {
                                          projectManagementController
                                              .inputDomicileEstab(newValue);
                                        }
                                      : null,
                              items: projectManagementController
                                  .domicileEstabList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("projectType".tr),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GetBuilder<ProjectManagementController>(
                              builder: (conttext) {
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                  prefixIcon: const ImageIcon(Svg(
                                      "assets/icons/view_project_icon.svg")),
                                  filled: true,
                                  fillColor:
                                      Theme.of(context).listTileTheme.tileColor,
                                  hintText: "projectType".tr,
                                  hintStyle: const TextStyle(fontSize: 17)),
                              dropdownColor:
                                  Get.isDarkMode ? greyColor : lightBlueColor,
                              validator: (value) {
                                if (value == null) {
                                  return "selectProjectType".tr;
                                }
                                if (value.isEmpty) {
                                  return "selectProjectType".tr;
                                }
                                return null;
                              },
                              isExpanded: true,
                              onChanged:
                                  projectManagementController.isEditingProject
                                      ? (String? newValue) {
                                          projectManagementController
                                              .inputDomicileEstab(newValue);
                                        }
                                      : null,
                              items: projectManagementController
                                  .domicileEstabList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("infoInnovativeIdea".tr),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GetBuilder<ProjectManagementController>(
                              builder: (context) {
                            return TextFormField(
                              textInputAction: TextInputAction.next,
                              readOnly:
                                  !projectManagementController.isEditingProject,
                              decoration: InputDecoration(
                                  prefixIcon: const ImageIcon(
                                    Svg("assets/icons/trade_mark_icon.svg"),
                                  ),
                                  hintText: "trademarkName".tr,
                                  hintStyle: const TextStyle(fontSize: 17)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enterTrademarkName".tr;
                                }
                                return null;
                              },
                              onChanged: (value) {
                                projectManagementController
                                    .inputTrademarkName(value);
                              },
                            );
                          }),
                          const SizedBox(
                            height: 7,
                          ),
                          GetBuilder<ProjectManagementController>(
                              builder: (context) {
                            return TextFormField(
                              textInputAction: TextInputAction.next,
                              readOnly:
                                  !projectManagementController.isEditingProject,
                              decoration: InputDecoration(
                                  prefixIcon: const ImageIcon(
                                    Svg("assets/icons/scientific_commi_icon.svg"),
                                  ),
                                  hintText: "sciNameInnovProd".tr,
                                  hintStyle: const TextStyle(fontSize: 16)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enterTrademarkName".tr;
                                }
                                return null;
                              },
                              onChanged: (value) {
                                projectManagementController
                                    .inputTrademarkName(value);
                              },
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("summary".tr),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: SmallBodyText(text: "enterSummary".tr)),
                          const SizedBox(height: 5),
                          GetBuilder<ProjectManagementController>(
                              builder: (context) {
                            return TextFormField(
                              readOnly:
                                  !projectManagementController.isEditingProject,
                              textInputAction: TextInputAction.done,
                              maxLength: 250,
                              maxLines: 4,
                              validator: (inputValue) {
                                if (inputValue!.isEmpty) {
                                  return "enterSummary".tr;
                                }
                                return null;
                              },
                              onChanged: (input) {
                                projectManagementController.inputSummary(input);
                              },
                              decoration: InputDecoration(
                                hintText: "summary".tr,
                                hintStyle: const TextStyle(fontSize: 17),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              if (true) {
                                // formKey.currentState!.validate()
                                //formKey.currentState!.save();
                                projectManagementController.next();
                              }
                            },
                            child: Text(
                              "createRole5".tr,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                  key: projectManagementController.formKey2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("projectTeam".tr),
                          GetBuilder<ProjectManagementController>(
                              builder: (context) {
                            return AnimatedVisibility(
                              projectManagementController:
                                  projectManagementController,
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
                                  onPressed: () {},
                                  child: Text("add".tr)),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            projectManagementController.projectTeamList.length,
                        itemBuilder: (context, index) {
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
                                      child: ProfileCircleIcon()),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      "${projectManagementController.projectTeamList[index].person?.firstName} ${projectManagementController.projectTeamList[index].person?.lastName}",
                                      style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .fontSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 45,
                                      width: 45,
                                      child: GetBuilder<
                                              ProjectManagementController>(
                                          builder: (context) {
                                        return AnimatedVisibility(
                                          projectManagementController:
                                              projectManagementController,
                                          child: IconButton(
                                            icon: const DeleteIcon(),
                                            onPressed: () {},
                                          ),
                                        );
                                      })),
                                ],
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          if (true) {
                            // formKey.currentState!.validate()
                            //formKey.currentState!.save();
                            projectManagementController.next();
                          }
                        },
                        child: Text(
                          "createRole5".tr,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                            projectManagementController.goBackPageView();
                          }
                        },
                        child: Text("goBack".tr,
                            style: const TextStyle(color: bluePurpleColor)),
                      )
                    ],
                  )),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                  key: projectManagementController.formKey3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("managementTeam".tr),
                          GetBuilder<ProjectManagementController>(
                              builder: (context) {
                            return AnimatedVisibility(
                              projectManagementController:
                                  projectManagementController,
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
                                  onPressed: () {},
                                  child: Text("add".tr)),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            projectManagementController.projectTeamList.length,
                        itemBuilder: (context, index) {
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
                                      child: ProfileCircleIcon()),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      "${projectManagementController.projectTeamList[index].person?.firstName} ${projectManagementController.projectTeamList[index].person?.lastName}",
                                      style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .fontSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 45,
                                      width: 45,
                                      child: GetBuilder<
                                              ProjectManagementController>(
                                          builder: (context) {
                                        return AnimatedVisibility(
                                          projectManagementController:
                                              projectManagementController,
                                          child: IconButton(
                                            icon: const DeleteIcon(),
                                            onPressed: () {},
                                          ),
                                        );
                                      })),
                                ],
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          if (true) {
                            // formKey.currentState!.validate()
                            //formKey.currentState!.save();
                            projectManagementController.next();
                          }
                        },
                        child: Text(
                          "createRole5".tr,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                            projectManagementController.goBackPageView();
                          }
                        },
                        child: Text("goBack".tr,
                            style: const TextStyle(color: bluePurpleColor)),
                      )
                    ],
                  )),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                  key: projectManagementController.formKey4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("attachments".tr),
                          GetBuilder<ProjectManagementController>(
                              builder: (context) {
                            return AnimatedVisibility(
                              projectManagementController:
                                  projectManagementController,
                              child: IconButton(
                                  style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(50, 0)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              transparentColor),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              bluePurpleColor)),
                                  onPressed: () {
                                    projectManagementController.importFiles();
                                  },
                                  icon: const ImageIcon(
                                    size: 30,
                                    color: bluePurpleColor,
                                    Svg("assets/icons/import_file_icon.svg"),
                                  )),
                            );
                          }),
                        ],
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: SmallBodyText(text: "UCAddFiles".tr)),
                      const SizedBox(
                        height: 15,
                      ),
                      GetBuilder<ProjectManagementController>(
                          builder: (context) {
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              projectManagementController.fileList.length,
                          itemBuilder: (context, index) {
                            return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 7, 10, 7),
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
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        "${projectManagementController.fileList[index].name}",
                                        style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .fontSize,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                        height: 45,
                                        width: 45,
                                        child: GetBuilder<
                                                ProjectManagementController>(
                                            builder: (context) {
                                          return AnimatedVisibility(
                                            projectManagementController:
                                                projectManagementController,
                                            child: IconButton(
                                              icon: const DeleteIcon(),
                                              onPressed: () {
                                                projectManagementController
                                                    .deleteFile(index);
                                              },
                                            ),
                                          );
                                        })),
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
                      const SizedBox(
                        height: 20,
                      ),
                      GetBuilder<ProjectManagementController>(
                          builder: (context) {
                        return AnimatedVisibility(
                          projectManagementController:
                              projectManagementController,
                          child: TextButton(
                            onPressed: () {
                              if (true) {
                                // formKey.currentState!.validate()
                                //formKey.currentState!.save();
                                projectManagementController.next();
                              }
                            },
                            child: Text(
                              "submit".tr,
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
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
                            projectManagementController.goBackPageView();
                          }
                        },
                        child: Text("goBack".tr,
                            style: const TextStyle(color: bluePurpleColor)),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedVisibility extends StatelessWidget {
  const AnimatedVisibility(
      {super.key,
      required this.projectManagementController,
      required this.child});

  final Widget child;
  final ProjectManagementController projectManagementController;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: projectManagementController.isEditingProject
          ? Offset.zero
          : const Offset(0, -1),
      duration: const Duration(milliseconds: 200),
      child: AnimatedOpacity(
        // If the widget is visible, animate to 0.0 (invisible).
        // If the widget is hidden, animate to 1.0 (fully visible).
        opacity: projectManagementController.isEditingProject ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        // The green box must be a child of the AnimatedOpacity widget.
        child: child,
      ),
    );
  }
}
