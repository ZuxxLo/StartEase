import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/main.dart';

import '../Themes/colors.dart';
import '../controller/project_deposit_controller.dart';
import 'widgets.dart';

class ProjectDeposit extends StatelessWidget {
  const ProjectDeposit({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectDepositController projectDepositController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: projectDepositController.pageController,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Form(
                    key: projectDepositController.formKey1,
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
                          initialValue: userModel.person?.establishment?.name,
                          maxLines: null,
                          readOnly: true,
                          decoration: InputDecoration(
                              prefixIcon: const ImageIcon(
                                  Svg("assets/icons/domicile_estab_icon.svg")),
                              hintText: userModel.person?.establishment?.name,
                              hintStyle: const TextStyle(fontSize: 17)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("projectType".tr),
                        ),
                        const SizedBox(height: 5),
                        GetBuilder<ProjectDepositController>(
                            builder: (conttext) {
                          return DropdownButtonFormField(
                            value: projectDepositController.projectData.type,
                            decoration: InputDecoration(
                                prefixIcon: const ImageIcon(
                                    Svg("assets/icons/view_project_icon.svg")),
                                filled: true,
                                fillColor:
                                    Theme.of(context).listTileTheme.tileColor,
                                hintText:
                                    projectDepositController.projectData.type,
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
                            onChanged: (String? newValue) {
                              projectDepositController
                                  .inputProjectType(newValue);
                            },
                            items: projectDepositController.projectTypesList
                                .map<DropdownMenuItem<String>>((String value) {
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
                        GetBuilder<ProjectDepositController>(
                            builder: (context) {
                          return TextFormField(
                            maxLines: null,
                            initialValue: projectDepositController
                                .projectData.trademarkName,
                            textInputAction: TextInputAction.next,
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
                              projectDepositController
                                  .inputTrademarkName(value);
                            },
                          );
                        }),
                        const SizedBox(
                          height: 7,
                        ),
                        GetBuilder<ProjectDepositController>(
                            builder: (context) {
                          return TextFormField(
                            initialValue: projectDepositController
                                .projectData.scientificName,
                            maxLines: null,
                            textInputAction: TextInputAction.next,
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
                              projectDepositController
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
                        GetBuilder<ProjectDepositController>(
                            builder: (context) {
                          return TextFormField(
                            initialValue:
                                projectDepositController.projectData.resume,
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
                              projectDepositController.inputSummary(input);
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
                            if (projectDepositController.formKey1.currentState!
                                .validate()) {
                              // formKey.currentState!.validate()
                              //formKey.currentState!.save();
                              projectDepositController.next();
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
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            physics: const BouncingScrollPhysics(),
            child: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("projectTeam".tr,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 20),
                (projectDepositController.projectData.members == null ||
                        projectDepositController.projectData.members!.isEmpty)
                    ? const SizedBox()
                    : GetBuilder<ProjectDepositController>(builder: (context) {
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: projectDepositController
                              .projectData.members!.length,
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
                                    SizedBox(
                                        height: 45,
                                        width: 45,
                                        child: ProfilePictureForOtherUsers(
                                            userModel: projectDepositController
                                                .projectData.members![index])),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        "${projectDepositController.projectData.members![index].email}",
                                        style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .fontSize,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    projectDepositController.projectData
                                                .members![index].id !=
                                            userModel.id
                                        ? SizedBox(
                                            height: 45,
                                            width: 45,
                                            child: GetBuilder<
                                                    ProjectDepositController>(
                                                builder: (context) {
                                              return IconButton(
                                                icon: const DeleteIcon(),
                                                onPressed: () {
                                                  projectDepositController
                                                      .deleteAProjectMember(
                                                          projectDepositController
                                                              .projectData
                                                              .members![index]);
                                                },
                                              );
                                            }))
                                        : const SizedBox(),
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
                const SizedBox(height: 5),
                GetBuilder<ProjectDepositController>(builder: (conttext) {
                  if (projectDepositController.projectData.members!.length >=
                      6) {
                    return const SizedBox();
                  } else {
                    return Container(
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
                                            key: projectDepositController
                                                .formKey2,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  validator:
                                                      (String? inputEmail) {
                                                    if (inputEmail == null) {
                                                      return "enterAnEmail".tr;
                                                    }
                                                    if (inputEmail.isEmpty) {
                                                      return "enterAnEmail".tr;
                                                    }
                                                    if (!RegExp(
                                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                        .hasMatch(inputEmail)) {
                                                      return "enterValidEmail"
                                                          .tr;
                                                    }

                                                    return null;
                                                  },
                                                  onChanged:
                                                      (String inputSearch) {
                                                    projectDepositController
                                                        .searchTextInput(
                                                            inputSearch);
                                                  },
                                                  decoration: InputDecoration(
                                                      hintText: projectDepositController
                                                                  .searchText ==
                                                              ""
                                                          ? "searchByEmail".tr
                                                          : projectDepositController
                                                              .searchText),
                                                ),
                                                const SizedBox(height: 10),
                                                TextButton(
                                                    onPressed: () {
                                                      if (projectDepositController
                                                          .formKey2
                                                          .currentState!
                                                          .validate()) {
                                                        projectDepositController
                                                            .formKey2
                                                            .currentState!
                                                            .save();
                                                        projectDepositController
                                                            .addAProjectMember(
                                                                projectDepositController
                                                                    .searchText!);
                                                      }
                                                    },
                                                    child: Text("confirm".tr)),
                                                const SizedBox(height: 10),
                                                TextButton(
                                                    onPressed: () {
                                                      projectDepositController
                                                          .searchTextInput("");

                                                      navigator!.pop();
                                                    },
                                                    child: Text("clear".tr))
                                              ],
                                            ),
                                          ));
                                    },
                                    child: Text("add".tr))),
                          ],
                        ));
                  }
                }),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    if (true) {
                      // formKey.currentState!.validate()
                      //formKey.currentState!.save();
                      projectDepositController.next();
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
                      projectDepositController.goBackPageView();
                    }
                  },
                  child: Text("goBack".tr,
                      style: const TextStyle(color: bluePurpleColor)),
                )
              ],
            )),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            physics: const BouncingScrollPhysics(),
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
            GetBuilder<ProjectDepositController>(
              builder: (ctx) {
                if (projectDepositController.projectData.supervisor ==
                    null) {
                  return Container(
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
                                        const Size(50, 40)),
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
                                        key: projectDepositController
                                            .formKey3,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              validator:
                                                  (String? inputEmail) {
                                                if (inputEmail == null) {
                                                  return "enterAnEmail".tr;
                                                }
                                                if (inputEmail.isEmpty) {
                                                  return "enterAnEmail".tr;
                                                }
                                                if (!RegExp(
                                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                    .hasMatch(inputEmail)) {
                                                  return "enterValidEmail"
                                                      .tr;
                                                }

                                                return null;
                                              },
                                              onChanged:
                                                  (String inputSearch) {
                                                projectDepositController
                                                    .searchTextInput(
                                                        inputSearch);
                                              },
                                              decoration: InputDecoration(
                                                  hintText: projectDepositController
                                                              .searchText ==
                                                          ""
                                                      ? "searchByEmail".tr
                                                      : projectDepositController
                                                          .searchText),
                                            ),
                                            const SizedBox(height: 10),
                                            TextButton(
                                                onPressed: () {
                                                  if (projectDepositController
                                                      .formKey3
                                                      .currentState!
                                                      .validate()) {
                                                    projectDepositController
                                                        .formKey3
                                                        .currentState!
                                                        .save();
                                                    projectDepositController
                                                        .addAProjectSupervisor(
                                                            projectDepositController
                                                                .searchText!);
                                                  }
                                                },
                                                child: Text("confirm".tr)),
                                            const SizedBox(height: 10),
                                            TextButton(
                                                onPressed: () {
                                                  projectDepositController
                                                      .searchTextInput("");

                                                  navigator!.pop();
                                                },
                                                child: Text("clear".tr))
                                          ],
                                        ),
                                      ));
                                },
                                child: Text("add".tr)),
                          ),
                        ],
                      ));
                } else {
                  return Container(
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
                                  userModel: projectDepositController
                                      .projectData.supervisor!)),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              "${projectDepositController.projectData.supervisor?.username}",
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
                              child: IconButton(
                                icon: const DeleteIcon(),
                                onPressed: () {
                                  projectDepositController
                                      .deleteAProjectSupervisor();
                                },
                              )),
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
            GetBuilder<ProjectDepositController>(
              builder: (ctx) {
                if (projectDepositController.projectData.coSupervisor ==
                    null) {
                  return Container(
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
                                        const Size(50, 40)),
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
                                        key: projectDepositController
                                            .formKey4,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              validator:
                                                  (String? inputEmail) {
                                                if (inputEmail == null) {
                                                  return "enterAnEmail".tr;
                                                }
                                                if (inputEmail.isEmpty) {
                                                  return "enterAnEmail".tr;
                                                }
                                                if (!RegExp(
                                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                    .hasMatch(inputEmail)) {
                                                  return "enterValidEmail"
                                                      .tr;
                                                }

                                                return null;
                                              },
                                              onChanged:
                                                  (String inputSearch) {
                                                projectDepositController
                                                    .searchTextInput(
                                                        inputSearch);
                                              },
                                              decoration: InputDecoration(
                                                  hintText: projectDepositController
                                                              .searchText ==
                                                          ""
                                                      ? "searchByEmail".tr
                                                      : projectDepositController
                                                          .searchText),
                                            ),
                                            const SizedBox(height: 10),
                                            TextButton(
                                                onPressed: () {
                                                  if (projectDepositController
                                                      .formKey4
                                                      .currentState!
                                                      .validate()) {
                                                    projectDepositController
                                                        .formKey4
                                                        .currentState!
                                                        .save();
                                                    projectDepositController
                                                        .addAProjectCoSupervisor(
                                                            projectDepositController
                                                                .searchText!);
                                                  }
                                                },
                                                child: Text("confirm".tr)),
                                            const SizedBox(height: 10),
                                            TextButton(
                                                onPressed: () {
                                                  projectDepositController
                                                      .searchTextInput("");

                                                  navigator!.pop();
                                                },
                                                child: Text("clear".tr))
                                          ],
                                        ),
                                      ));
                                },
                                child: Text("add".tr)),
                          ),
                        ],
                      ));
                } else {
                  return Container(
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
                                  userModel: projectDepositController
                                      .projectData.coSupervisor!)),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              "${projectDepositController.projectData.coSupervisor?.username}",
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
                              child: IconButton(
                                icon: const DeleteIcon(),
                                onPressed: () {
                                  projectDepositController
                                      .deleteAProjectCoSupervisor();
                                },
                              )),
                        ],
                      ));
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                if (true) {
//                      projectDepositController.projectData.supervisor !=   null
                  // formKey.currentState!.validate()
                  //formKey.currentState!.save();
                  projectDepositController.submit();
                } else {}
              },
              child: Text(
                "submit".tr,
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
                  projectDepositController.goBackPageView();
                }
              },
              child: Text("goBack".tr,
                  style: const TextStyle(color: bluePurpleColor)),
            )
              ],
            ),
          ),
          //////////////////////////////// attachments
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            physics: const BouncingScrollPhysics(),
            child: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("attachments".tr,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    GetBuilder<ProjectDepositController>(builder: (context) {
                      return IconButton(
                          style: ButtonStyle(
                              fixedSize:
                                  MaterialStateProperty.all(const Size(50, 0)),
                              backgroundColor:
                                  MaterialStateProperty.all(transparentColor),
                              foregroundColor:
                                  MaterialStateProperty.all(bluePurpleColor)),
                          onPressed: () {
                            projectDepositController.importFiles();
                          },
                          icon: const ImageIcon(
                            size: 30,
                            color: bluePurpleColor,
                            Svg("assets/icons/import_file_icon.svg"),
                          ));
                    }),
                  ],
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: SmallBodyText(text: "UCAddFiles".tr)),
                const SizedBox(
                  height: 15,
                ),
                projectDepositController.projectData.files == null
                    ? const SizedBox()
                    : GetBuilder<ProjectDepositController>(builder: (context) {
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: projectDepositController
                              .projectData.files!.length,
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
                                        "${projectDepositController.fileList[index].name}",
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
                                        child: IconButton(
                                          icon: const DeleteIcon(),
                                          onPressed: () {
                                            projectDepositController
                                                .deleteFile(index);
                                          },
                                        )),
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
                TextButton(
                  onPressed: () {
                    if (true) {
                      // formKey.currentState!.validate()
                      //formKey.currentState!.save();
                      projectDepositController.next();
                    }
                  },
                  child: Text(
                    "submit".tr,
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
                      projectDepositController.goBackPageView();
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
    );
  }
}
