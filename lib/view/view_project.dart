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
        //////////////////   title:   Text("Project Name"), //////////////////
        actions: [
          GetBuilder<ProjectManagementController>(builder: (context) {
            bool exists = false;
            for (var permission in userModel.permissions!) {
              if (permission.id == 37) {
                exists = true;
              }
            }
            return exists
                ? IconButton(
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
                        projectManagementController.restoreNonEditedData();

                        MainFunctions.somethingWentWrongSnackBar(
                            "editCanceled".tr);
                      }
                    },
                    icon: projectManagementController.isEditingProject
                        ? const ImageIcon(
                            Svg("assets/icons/close_square_icon.svg"),
                            color: redColor,
                            size: 50)
                        : const ImageIcon(
                            Svg("assets/icons/edit_project_icon.svg"),
                            size: 30))
                : const SizedBox();
          }),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                          TextFormField(
                            initialValue: projectManagementController
                                .projectData.establishment?.name,
                            readOnly: true,
                            decoration: InputDecoration(
                                prefixIcon: const ImageIcon(Svg(
                                    "assets/icons/domicile_estab_icon.svg")),
                                filled: true,
                                fillColor:
                                    Theme.of(context).listTileTheme.tileColor,
                                hintText: projectManagementController
                                    .projectData.establishment?.name,
                                hintStyle: const TextStyle(fontSize: 17)),
                            validator: (value) {
                              if (value == null) {
                                return "selectDomicileEstab".tr;
                              }
                              if (value.isEmpty) {
                                return "selectDomicileEstab".tr;
                              }
                              return null;
                            },
                            onChanged: null,
                          ),
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
                                  hintText: projectManagementController
                                      .projectData.type,
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
                                  // projectManagementController.isEditingProject
                                  //     ? (String? newValue) {
                                  //         projectManagementController
                                  //             .inputProjectType(newValue);
                                  //       }
                                  //     :
                                  null,
                              items: projectManagementController
                                  .projectTypesList
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
                              maxLines: null,
                              initialValue: projectManagementController
                                  .projectData.trademarkName,
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
                              initialValue: projectManagementController
                                  .projectData.scientificName,
                              maxLines: null,
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
                                  return "enterSciNameInnovProd".tr;
                                }
                                return null;
                              },
                              onChanged: (value) {
                                projectManagementController
                                    .inputScientificName(value);
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
                              initialValue: projectManagementController
                                  .projectData.resume,
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
                          ),
                          const SizedBox(height: 20)
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
                    "projectTeam".tr,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<ProjectManagementController>(builder: (conttext) {
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: projectManagementController
                          .projectData.members!.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(context).listTileTheme.tileColor),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${projectManagementController.projectData.members![index].email}",
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .fontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                projectManagementController.projectData
                                            .members![index].email ==
                                        projectManagementController
                                            .projectData.projectHolder?.email
                                    ? const SizedBox(
                                        width: 45,
                                      )
                                    : SizedBox(
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
                                                    .deleteAProjectMember(
                                                        projectManagementController
                                                            .projectData
                                                            .members![index]);
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
                  const SizedBox(height: 10),
                  GetBuilder<ProjectManagementController>(builder: (contetxt) {
                    return AnimatedVisibility(
                      projectManagementController: projectManagementController,
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).listTileTheme.tileColor),
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: ClipOval(
                                    child: Container(
                                      color: const Color.fromARGB(
                                          255, 226, 228, 235),
                                    ),
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
                                            title: "searchByEmail".tr,
                                            content: Form(
                                              key: projectManagementController
                                                  .formKey2,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    validator:
                                                        (String? inputEmail) {
                                                      if (inputEmail == null) {
                                                        return "enterAnEmail"
                                                            .tr;
                                                      }
                                                      if (inputEmail.isEmpty) {
                                                        return "enterAnEmail"
                                                            .tr;
                                                      }
                                                      if (!RegExp(
                                                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                          .hasMatch(
                                                              inputEmail)) {
                                                        return "enterValidEmail"
                                                            .tr;
                                                      }

                                                      return null;
                                                    },
                                                    onChanged:
                                                        (String inputSearch) {
                                                      projectManagementController
                                                          .searchTextInput(
                                                              inputSearch);
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText: projectManagementController
                                                                    .searchText ==
                                                                ""
                                                            ? "searchByEmail".tr
                                                            : projectManagementController
                                                                .searchText),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  TextButton(
                                                      onPressed: () {
                                                        if (projectManagementController
                                                            .formKey2
                                                            .currentState!
                                                            .validate()) {
                                                          projectManagementController
                                                              .formKey2
                                                              .currentState!
                                                              .save();
                                                          projectManagementController
                                                              .addAProjectMember(
                                                                  projectManagementController
                                                                      .searchText!);
                                                        }
                                                      },
                                                      child:
                                                          Text("confirm".tr)),
                                                  const SizedBox(height: 10),
                                                  TextButton(
                                                      onPressed: () {
                                                        projectManagementController
                                                            .searchTextInput(
                                                                "");

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
                    );
                  }),
                  const SizedBox(height: 20),
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
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("managementTeam".tr,
                          style: const TextStyle(fontWeight: FontWeight.w600))),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "supervisor".tr,
                      style: const TextStyle(fontSize: 19),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<ProjectManagementController>(
                    builder: (ctx) {
                      if (projectManagementController.projectData.supervisor ==
                          null) {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(context).listTileTheme.tileColor),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: ClipOval(
                                      child: Container(
                                        color: const Color.fromARGB(
                                            255, 226, 228, 235),
                                      ),
                                    )),
                                const Expanded(
                                  child: Text(
                                    "",
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  child:
                                      GetBuilder<ProjectManagementController>(
                                          builder: (context) {
                                    return AnimatedVisibility(
                                      projectManagementController:
                                          projectManagementController,
                                      child: TextButton(
                                          style: ButtonStyle(
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      const Size(50, 40)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      transparentColor),
                                              overlayColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      bluePurpleColor
                                                          .withOpacity(0.2)),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      bluePurpleColor)),
                                          onPressed: () {
                                            Get.defaultDialog(
                                                onWillPop: () {
                                                  return Future.value(false);
                                                },
                                                title: "searchByEmail".tr,
                                                content: Form(
                                                  key:
                                                      projectManagementController
                                                          .formKey3,
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        validator: (String?
                                                            inputEmail) {
                                                          if (inputEmail ==
                                                              null) {
                                                            return "enterAnEmail"
                                                                .tr;
                                                          }
                                                          if (inputEmail
                                                              .isEmpty) {
                                                            return "enterAnEmail"
                                                                .tr;
                                                          }
                                                          if (!RegExp(
                                                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                              .hasMatch(
                                                                  inputEmail)) {
                                                            return "enterValidEmail"
                                                                .tr;
                                                          }

                                                          return null;
                                                        },
                                                        onChanged: (String
                                                            inputSearch) {
                                                          projectManagementController
                                                              .searchTextInput(
                                                                  inputSearch);
                                                        },
                                                        decoration: InputDecoration(
                                                            hintText: projectManagementController
                                                                        .searchText ==
                                                                    ""
                                                                ? "searchByEmail"
                                                                    .tr
                                                                : projectManagementController
                                                                    .searchText),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      TextButton(
                                                          onPressed: () {
                                                            if (projectManagementController
                                                                .formKey3
                                                                .currentState!
                                                                .validate()) {
                                                              projectManagementController
                                                                  .formKey3
                                                                  .currentState!
                                                                  .save();
                                                              projectManagementController
                                                                  .addAProjectSupervisor(
                                                                      projectManagementController
                                                                          .searchText!);
                                                            }
                                                          },
                                                          child: Text(
                                                              "confirm".tr)),
                                                      const SizedBox(
                                                          height: 10),
                                                      TextButton(
                                                          onPressed: () {
                                                            projectManagementController
                                                                .searchTextInput(
                                                                    "");

                                                            navigator!.pop();
                                                          },
                                                          child:
                                                              Text("clear".tr))
                                                    ],
                                                  ),
                                                ));
                                          },
                                          child: Text("add".tr)),
                                    );
                                  }),
                                ),
                              ],
                            ));
                      } else {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(context).listTileTheme.tileColor),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${projectManagementController.projectData.supervisor?.email}",
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
                                    child:
                                        GetBuilder<ProjectManagementController>(
                                            builder: (context) {
                                      return AnimatedVisibility(
                                        projectManagementController:
                                            projectManagementController,
                                        child: IconButton(
                                          icon: const DeleteIcon(),
                                          onPressed: () {
                                            projectManagementController
                                                .deleteAProjectSupervisor();
                                          },
                                        ),
                                      );
                                    })),
                              ],
                            ));
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "cosupervisor".tr,
                      style: const TextStyle(fontSize: 19),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<ProjectManagementController>(
                    builder: (ctx) {
                      if (projectManagementController
                              .projectData.coSupervisor ==
                          null) {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(context).listTileTheme.tileColor),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: ClipOval(
                                      child: Container(
                                        color: const Color.fromARGB(
                                            255, 226, 228, 235),
                                      ),
                                    )),
                                const Expanded(
                                  child: Text(
                                    "",
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  child:
                                      GetBuilder<ProjectManagementController>(
                                          builder: (context) {
                                    return AnimatedVisibility(
                                      projectManagementController:
                                          projectManagementController,
                                      child: TextButton(
                                          style: ButtonStyle(
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      const Size(50, 40)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      transparentColor),
                                              overlayColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      bluePurpleColor
                                                          .withOpacity(0.2)),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      bluePurpleColor)),
                                          onPressed: () {
                                            Get.defaultDialog(
                                                onWillPop: () {
                                                  return Future.value(false);
                                                },
                                                title: "searchByEmail".tr,
                                                content: Form(
                                                  key:
                                                      projectManagementController
                                                          .formKey4,
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        validator: (String?
                                                            inputEmail) {
                                                          if (inputEmail ==
                                                              null) {
                                                            return "enterAnEmail"
                                                                .tr;
                                                          }
                                                          if (inputEmail
                                                              .isEmpty) {
                                                            return "enterAnEmail"
                                                                .tr;
                                                          }
                                                          if (!RegExp(
                                                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                              .hasMatch(
                                                                  inputEmail)) {
                                                            return "enterValidEmail"
                                                                .tr;
                                                          }

                                                          return null;
                                                        },
                                                        onChanged: (String
                                                            inputSearch) {
                                                          projectManagementController
                                                              .searchTextInput(
                                                                  inputSearch);
                                                        },
                                                        decoration: InputDecoration(
                                                            hintText: projectManagementController
                                                                        .searchText ==
                                                                    ""
                                                                ? "searchByEmail"
                                                                    .tr
                                                                : projectManagementController
                                                                    .searchText),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      TextButton(
                                                          onPressed: () {
                                                            if (projectManagementController
                                                                .formKey4
                                                                .currentState!
                                                                .validate()) {
                                                              projectManagementController
                                                                  .formKey4
                                                                  .currentState!
                                                                  .save();
                                                              projectManagementController
                                                                  .addAProjectCoSupervisor(
                                                                      projectManagementController
                                                                          .searchText!);
                                                            }
                                                          },
                                                          child: Text(
                                                              "confirm".tr)),
                                                      const SizedBox(
                                                          height: 10),
                                                      TextButton(
                                                          onPressed: () {
                                                            projectManagementController
                                                                .searchTextInput(
                                                                    "");

                                                            navigator!.pop();
                                                          },
                                                          child:
                                                              Text("clear".tr))
                                                    ],
                                                  ),
                                                ));
                                          },
                                          child: Text("add".tr)),
                                    );
                                  }),
                                ),
                              ],
                            ));
                      } else {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(context).listTileTheme.tileColor),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${projectManagementController.projectData.coSupervisor?.email}",
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
                                    child:
                                        GetBuilder<ProjectManagementController>(
                                            builder: (context) {
                                      return AnimatedVisibility(
                                        projectManagementController:
                                            projectManagementController,
                                        child: IconButton(
                                          icon: const DeleteIcon(),
                                          onPressed: () {
                                            projectManagementController
                                                .deleteAProjectCoSupervisor();
                                          },
                                        ),
                                      );
                                    })),
                              ],
                            ));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<ProjectManagementController>(builder: (context) {
                    return AnimatedVisibility(
                      projectManagementController: projectManagementController,
                      child: TextButton(
                        onPressed: () {
                          if (true) {
                            //                      projectManagementController.projectData.supervisor !=   null
                            // formKey.currentState!.validate()
                            //formKey.currentState!.save();
                            projectManagementController.submitEditProject();
                          }
                        },
                        child: Text(
                          "submit".tr,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
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
            //   SingleChildScrollView(
            //     physics: const BouncingScrollPhysics(),
            //     child: Form(
            //         key: projectManagementController.formKey4,
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text("attachments".tr),
            //                 GetBuilder<ProjectManagementController>(
            //                     builder: (context) {
            //                   return AnimatedVisibility(
            //                     projectManagementController:
            //                         projectManagementController,
            //                     child: IconButton(
            //                         style: ButtonStyle(
            //                             fixedSize: MaterialStateProperty.all(
            //                                 const Size(50, 0)),
            //                             backgroundColor:
            //                                 MaterialStateProperty.all(
            //                                     transparentColor),
            //                             foregroundColor:
            //                                 MaterialStateProperty.all(
            //                                     bluePurpleColor)),
            //                         onPressed: () {
            //                           projectManagementController.importFiles();
            //                         },
            //                         icon: const ImageIcon(
            //                           size: 30,
            //                           color: bluePurpleColor,
            //                           Svg("assets/icons/import_file_icon.svg"),
            //                         )),
            //                   );
            //                 }),
            //               ],
            //             ),
            //             Align(
            //                 alignment: Alignment.centerLeft,
            //                 child: SmallBodyText(text: "UCAddFiles".tr)),
            //             const SizedBox(
            //               height: 15,
            //             ),
            //             GetBuilder<ProjectManagementController>(
            //                 builder: (context) {
            //               return ListView.separated(
            //                 physics: const NeverScrollableScrollPhysics(),
            //                 shrinkWrap: true,
            //                 itemCount: projectManagementController
            //                     .projectData.files!.length,
            //                 itemBuilder: (context, index) {
            //                   return Container(
            //                       padding:
            //                           const EdgeInsets.fromLTRB(10, 7, 10, 7),
            //                       decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(10),
            //                           color: Theme.of(context)
            //                               .listTileTheme
            //                               .tileColor),
            //                       child: Row(
            //                         children: [
            //                           const SizedBox(
            //                               height: 45,
            //                               width: 45,
            //                               child: ImageIcon(
            //                                 size: 30,
            //                                 Svg("assets/icons/file_icon.svg"),
            //                               )),
            //                           const SizedBox(width: 20),
            //                           Expanded(
            //                             child: Text(
            //                               "${projectManagementController.projectData.files?.entries.elementAt(index).value.name}",
            //                               style: TextStyle(
            //                                   fontSize: Theme.of(context)
            //                                       .textTheme
            //                                       .titleMedium!
            //                                       .fontSize,
            //                                   fontWeight: FontWeight.bold),
            //                             ),
            //                           ),
            //                           SizedBox(
            //                               height: 45,
            //                               width: 45,
            //                               child: GetBuilder<
            //                                       ProjectManagementController>(
            //                                   builder: (context) {
            //                                 return AnimatedVisibility(
            //                                   projectManagementController:
            //                                       projectManagementController,
            //                                   child: IconButton(
            //                                     icon: const DeleteIcon(),
            //                                     onPressed: () {
            //                                       projectManagementController
            //                                           .deleteFile(index);
            //                                     },
            //                                   ),
            //                                 );
            //                               })),
            //                         ],
            //                       ));
            //                 },
            //                 separatorBuilder: (context, index) {
            //                   return const SizedBox(
            //                     height: 10,
            //                   );
            //                 },
            //               );
            //             }),
            //             const SizedBox(
            //               height: 20,
            //             ),
            //             GetBuilder<ProjectManagementController>(
            //                 builder: (context) {
            //               return AnimatedVisibility(
            //                 projectManagementController:
            //                     projectManagementController,
            //                 child: TextButton(
            //                   onPressed: () {
            //                     if (true) {
            //                       // formKey.currentState!.validate()
            //                       //formKey.currentState!.save();
            //                       projectManagementController.next();
            //                     }
            //                   },
            //                   child: Text(
            //                     "submit".tr,
            //                   ),
            //                 ),
            //               );
            //             }),
            //             const SizedBox(
            //               height: 10,
            //             ),
            //             TextButton(
            //               style: ButtonStyle(
            //                   side: MaterialStateProperty.all(
            //                       const BorderSide(color: bluePurpleColor)),
            //                   overlayColor: MaterialStateColor.resolveWith(
            //                       (states) => bluePurpleColor.withOpacity(0.2)),
            //                   backgroundColor:
            //                       MaterialStateProperty.all(transparentColor)),
            //               onPressed: () {
            //                 if (true) {
            //                   // formKey.currentState!.validate()
            //                   //formKey.currentState!.save();
            //                   projectManagementController.goBackPageView();
            //                 }
            //               },
            //               child: Text("goBack".tr,
            //                   style: const TextStyle(color: bluePurpleColor)),
            //             )
            //           ],
            //         )),
            //   ),
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
