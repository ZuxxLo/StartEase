import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/controller/defence_management_controller.dart';
import 'package:startease/main.dart';
import 'package:startease/view/view_project.dart';

import '../Themes/colors.dart';
import '../controller/project_management_controller.dart';
import '../model/defences_model.dart';
import '../services/languages.dart';
import 'widgets.dart';

class CreateNewDefense extends StatelessWidget {
  const CreateNewDefense({super.key});

  @override
  Widget build(BuildContext context) {
    final DefenceManagementController defenceManagementController = Get.find();

    final formKey1 = GlobalKey<FormState>();
    final formKey2 = GlobalKey<FormState>();
    final formKey3 = GlobalKey<FormState>();
    final formKey4 = GlobalKey<FormState>();
    final formEmail = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: Text("createNewDefense".tr), //////////////////
        actions: [
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
          controller: defenceManagementController.pageControllerNewDefense,
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

                          GetBuilder<DefenceManagementController>(
                              builder: (contexxt) {
                            return TextFormField(
                                readOnly: true,
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
                                      defenceManagementController
                                          .inputDate(value);
                                    }
                                  });
                                },
                                validator: (value) {
                                  if (defenceManagementController
                                          .newDefense!.date ==
                                      null) {
                                    return "fillFiled".tr;
                                  }
                                  if (defenceManagementController
                                      .newDefense!.date!.isEmpty) {
                                    return "fillFiled".tr;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  hintText: defenceManagementController
                                          .newDefense!.date ??
                                      "yyyy-mm-dd",
                                  prefixIcon: const ImageIcon(
                                      Svg("assets/icons/calendar_icon.svg")),
                                ));
                          }),
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

                          GetBuilder<DefenceManagementController>(
                              builder: (contexxt) {
                            return TextFormField(
                                validator: (value) {
                                  if (defenceManagementController
                                          .newDefense!.time ==
                                      null) {
                                    return "fillFiled".tr;
                                  }
                                  if (defenceManagementController
                                      .newDefense!.time!.isEmpty) {
                                    return "fillFiled".tr;
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showTimePicker(
                                      context: context,
                                      helpText: "",
                                      hourLabelText: "",
                                      minuteLabelText: "",
                                      initialEntryMode:
                                          TimePickerEntryMode.dial,
                                      initialTime: TimeOfDay.now(),
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
                                      defenceManagementController
                                          .inputTime(value);
                                    }
                                  });
                                },
                                readOnly: true,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.access_time),
                                  hintText: defenceManagementController
                                          .newDefense!.time ??
                                      "h:m",
                                ));
                          }),

                          ///////////////////room
                          ///

                          GetBuilder<DefenceManagementController>(
                              builder: (context) {
                            return (defenceManagementController
                                            .newDefense!.otherPlace ==
                                        null ||
                                    defenceManagementController
                                            .newDefense!.otherPlace ==
                                        "")
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "room".tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      DropdownButtonFormField(
                                        isExpanded: true,
                                        isDense: false,
                                        menuMaxHeight: 300,
                                        iconSize: 0.0,
                                        dropdownColor: Get.isDarkMode
                                            ? greyColor
                                            : lightBlueColor,
                                        decoration: const InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20.0, right: 10),
                                              child: Icon(Icons.roofing),
                                            ),
                                            suffixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: Icon(Icons.expand_more,
                                                  size: 25),
                                            ),
                                            filled: true,
                                            hintStyle: TextStyle(
                                              fontSize: 17,
                                            )),
                                        validator: (value) {
                                          if (value == null) {
                                            return "selectDomicileEstab".tr;
                                          }
                                          if (value.name!.isEmpty) {
                                            return "selectDomicileEstab".tr;
                                          }
                                          return null;
                                        },
                                        value: defenceManagementController
                                            .newDefenseRooms?[0],
                                        onChanged: (room) {
                                          defenceManagementController
                                              .selectRoom(room);
                                        },
                                        items: defenceManagementController
                                            .newDefenseRooms!
                                            .map<DropdownMenuItem<Roomss>>(
                                                (Roomss value) {
                                          return DropdownMenuItem<Roomss>(
                                            value: value,
                                            child: Text(
                                              value.name!,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  )
                                : const SizedBox();
                          }),

                          const SizedBox(
                            height: 10,
                          ),

                          ///////////////////otherPlace
                          GetBuilder<DefenceManagementController>(
                              builder: (context) {
                            return (defenceManagementController
                                        .newDefense!.room!.id ==
                                    null)
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "otherPlace".tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      TextFormField(
                                          initialValue:
                                              defenceManagementController
                                                  .newDefense!.otherPlace,
                                          onChanged: (value) {
                                            defenceManagementController
                                                .inputOtherPlace(value);
                                          },
                                          validator: (value) {
                                            if (value == null) {
                                              return "fillFiled".tr;
                                            }
                                            if (value.isEmpty) {
                                              return "fillFiled".tr;
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.room),
                                          )),
                                    ],
                                  )
                                : const SizedBox();
                          }),

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
                          DropdownButtonFormField(
                            isExpanded: true,
                            isDense: false,
                            menuMaxHeight: 300,
                            iconSize: 0.0,
                            dropdownColor:
                                Get.isDarkMode ? greyColor : lightBlueColor,
                            decoration: const InputDecoration(
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.0, right: 10),
                                  child: Icon(Icons.settings),
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.expand_more, size: 25),
                                ),
                                filled: true,
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                )),
                            value: defenceManagementController.modes[0],
                            onChanged: (mode) {
                              defenceManagementController.selectMode(mode);
                            },
                            items: defenceManagementController.modes
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),

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
                          DropdownButtonFormField(
                            isExpanded: true,
                            isDense: false,
                            menuMaxHeight: 300,
                            iconSize: 0.0,
                            dropdownColor:
                                Get.isDarkMode ? greyColor : lightBlueColor,
                            decoration: const InputDecoration(
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.0, right: 10),
                                  child: Icon(Icons.settings),
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.expand_more, size: 25),
                                ),
                                filled: true,
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                )),
                            value: defenceManagementController.nature[0],
                            onChanged: (nature) {
                              defenceManagementController.selectNature(nature);
                            },
                            items: defenceManagementController.nature
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 20),

                          TextButton(
                            onPressed: () {
                              if (formKey1.currentState!.validate()) {
                                //
                                formKey1.currentState!.save();
                                defenceManagementController.nextNewDefense();
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
                  GetBuilder<DefenceManagementController>(builder: (contexxt) {
                    return Container(
                        padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).listTileTheme.tileColor),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(defenceManagementController
                                        .newDefense?.jurys?.president?.email ??
                                    "")),
                            SizedBox(
                              height: 45,
                              child: TextButton(
                                  style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(50, 0)),
                                      backgroundColor: MaterialStateProperty.all(
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
                                          key: formKey4,
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
                                                    return "enterValidEmail".tr;
                                                  }

                                                  return null;
                                                },
                                                onChanged:
                                                    (String inputSearch) {
                                                  defenceManagementController
                                                      .inputPresident(
                                                          inputSearch);
                                                },
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "searchByEmail".tr),
                                              ),
                                              const SizedBox(height: 10),
                                              TextButton(
                                                  onPressed: () {
                                                    if (formKey4.currentState!
                                                        .validate()) {
                                                      formKey4.currentState!
                                                          .save();
                                                      defenceManagementController
                                                          .addPresidentToDefense();
                                                      navigator!.pop();
                                                    }
                                                  },
                                                  child: Text("confirm".tr)),
                                              const SizedBox(height: 10),
                                              TextButton(
                                                  onPressed: () {
                                                    defenceManagementController
                                                        .inputPresident("");

                                                    navigator!.pop();
                                                  },
                                                  child: Text("clear".tr))
                                            ],
                                          ),
                                        ));
                                  },
                                  child: Text(defenceManagementController
                                              .newDefense
                                              ?.jurys
                                              ?.president
                                              ?.email ==
                                          null
                                      ? "add".tr
                                      : "edit".tr)),
                            ),
                          ],
                        ));
                  }),

                  const SizedBox(height: 20),
                  Text(
                    "supervisor".tr,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<DefenceManagementController>(builder: (contexxt) {
                    return Container(
                        padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).listTileTheme.tileColor),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(defenceManagementController
                                        .newDefense?.jurys?.supervisor?.email ??
                                    "")),
                            SizedBox(
                              height: 45,
                              child: TextButton(
                                  style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(50, 0)),
                                      backgroundColor: MaterialStateProperty.all(
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
                                          key: formKey4,
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
                                                    return "enterValidEmail".tr;
                                                  }

                                                  return null;
                                                },
                                                onChanged:
                                                    (String inputSearch) {
                                                  defenceManagementController
                                                      .inputSupervisor(
                                                          inputSearch);
                                                },
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "searchByEmail".tr),
                                              ),
                                              const SizedBox(height: 10),
                                              TextButton(
                                                  onPressed: () {
                                                    if (formKey4.currentState!
                                                        .validate()) {
                                                      formKey4.currentState!
                                                          .save();
                                                      defenceManagementController
                                                          .addSupervisorToDefense();
                                                      navigator!.pop();
                                                    }
                                                  },
                                                  child: Text("confirm".tr)),
                                              const SizedBox(height: 10),
                                              TextButton(
                                                  onPressed: () {
                                                    defenceManagementController
                                                        .inputSupervisor("");

                                                    navigator!.pop();
                                                  },
                                                  child: Text("clear".tr))
                                            ],
                                          ),
                                        ));
                                  },
                                  child: Text(defenceManagementController
                                              .newDefense
                                              ?.jurys
                                              ?.supervisor
                                              ?.email ==
                                          null
                                      ? "add".tr
                                      : "edit".tr)),
                            ),
                          ],
                        ));
                  }),

                  const SizedBox(height: 20),
                  Text(
                    "cosupervisor".tr,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<DefenceManagementController>(builder: (contexxt) {
                    return Container(
                        padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).listTileTheme.tileColor),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(defenceManagementController
                                        .newDefense
                                        ?.jurys
                                        ?.coSupervisor
                                        ?.email ??
                                    "")),
                            SizedBox(
                              height: 45,
                              child: TextButton(
                                  style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(50, 0)),
                                      backgroundColor: MaterialStateProperty.all(
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
                                          key: formKey4,
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
                                                    return "enterValidEmail".tr;
                                                  }

                                                  return null;
                                                },
                                                onChanged:
                                                    (String inputSearch) {
                                                  defenceManagementController
                                                      .inputCoSupervisor(
                                                          inputSearch);
                                                },
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "searchByEmail".tr),
                                              ),
                                              const SizedBox(height: 10),
                                              TextButton(
                                                  onPressed: () {
                                                    if (formKey4.currentState!
                                                        .validate()) {
                                                      formKey4.currentState!
                                                          .save();
                                                      defenceManagementController
                                                          .addCoSupervisorToDefense();
                                                      navigator!.pop();
                                                    }
                                                  },
                                                  child: Text("confirm".tr)),
                                              const SizedBox(height: 10),
                                              TextButton(
                                                  onPressed: () {
                                                    defenceManagementController
                                                        .inputCoSupervisor("");

                                                    navigator!.pop();
                                                  },
                                                  child: Text("clear".tr))
                                            ],
                                          ),
                                        ));
                                  },
                                  child: Text(defenceManagementController
                                              .newDefense
                                              ?.jurys
                                              ?.coSupervisor
                                              ?.email ==
                                          null
                                      ? "add".tr
                                      : "edit".tr)),
                            ),
                          ],
                        ));
                  }),
                  const SizedBox(height: 20),
                  Text(
                    "examiners".tr,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  GetBuilder<DefenceManagementController>(builder: (contexxt) {
                    return Column(
                      children: [
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 5);
                            },
                            itemCount: defenceManagementController
                                .newDefense!.jurys!.examiners!.length,
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
                                    Expanded(
                                      child: Text(defenceManagementController
                                          .newDefense!
                                          .jurys!
                                          .examiners![index]
                                          .email!),
                                    ),
                                    TextButton(
                                        style: ButtonStyle(
                                            fixedSize:
                                                MaterialStateProperty.all(
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
                                                key: formKey4,
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      validator:
                                                          (String? inputEmail) {
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
                                                      onChanged:
                                                          (String inputSearch) {
                                                        defenceManagementController
                                                            .inputExaminer(
                                                                inputSearch);
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  "searchByEmail"
                                                                      .tr),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    TextButton(
                                                        onPressed: () {
                                                          if (formKey4
                                                              .currentState!
                                                              .validate()) {
                                                            formKey4
                                                                .currentState!
                                                                .save();
                                                            defenceManagementController
                                                                .editExaminerToDefense(
                                                                    index);
                                                            navigator!.pop();
                                                          }
                                                        },
                                                        child:
                                                            Text("confirm".tr)),
                                                    const SizedBox(height: 10),
                                                    TextButton(
                                                        onPressed: () {
                                                          defenceManagementController
                                                              .inputExaminer(
                                                                  "");

                                                          navigator!.pop();
                                                        },
                                                        child: Text("clear".tr))
                                                  ],
                                                ),
                                              ));
                                        },
                                        child: Text("edit".tr)),
                                  ],
                                ),
                              );
                            }),
                        const SizedBox(height: 5),
                        defenceManagementController
                                    .newDefense!.jurys!.examiners!.length <
                                3
                            ? Container(
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 7, 10, 7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context)
                                        .listTileTheme
                                        .tileColor),
                                child: SizedBox(
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
                                              key: formKey4,
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
                                                      defenceManagementController
                                                          .inputExaminer(
                                                              inputSearch);
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "searchByEmail".tr),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  TextButton(
                                                      onPressed: () {
                                                        if (formKey4
                                                            .currentState!
                                                            .validate()) {
                                                          formKey4.currentState!
                                                              .save();
                                                          defenceManagementController
                                                              .addExaminerToDefense();
                                                          navigator!.pop();
                                                        }
                                                      },
                                                      child:
                                                          Text("confirm".tr)),
                                                  const SizedBox(height: 10),
                                                  TextButton(
                                                      onPressed: () {
                                                        defenceManagementController
                                                            .inputExaminer("");

                                                        navigator!.pop();
                                                      },
                                                      child: Text("clear".tr))
                                                ],
                                              ),
                                            ));
                                      },
                                      child: Text("add".tr)),
                                ))
                            : const SizedBox()
                      ],
                    );
                  }),
                  const SizedBox(height: 10),
                  Text(
                    "guest".tr,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<DefenceManagementController>(builder: (contexxt) {
                    return Container(
                        padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).listTileTheme.tileColor),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(defenceManagementController
                                        .newDefense?.jurys?.guest ??
                                    "")),
                            SizedBox(
                              height: 45,
                              child: TextButton(
                                  style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(50, 0)),
                                      backgroundColor: MaterialStateProperty.all(
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
                                          key: formKey4,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                validator:
                                                    (String? inputEmail) {
                                                  if (inputEmail == null) {
                                                    return "fillFiled".tr;
                                                  }
                                                  if (inputEmail.isEmpty) {
                                                    return "fillFiled".tr;
                                                  }

                                                  return null;
                                                },
                                                onChanged:
                                                    (String inputSearch) {
                                                  defenceManagementController
                                                      .inputGuest(inputSearch);
                                                },
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "searchByEmail".tr),
                                              ),
                                              const SizedBox(height: 10),
                                              TextButton(
                                                  onPressed: () {
                                                    if (formKey4.currentState!
                                                        .validate()) {
                                                      formKey4.currentState!
                                                          .save();
                                                      defenceManagementController
                                                          .addGuest();
                                                      navigator!.pop();
                                                    }
                                                  },
                                                  child: Text("confirm".tr)),
                                              const SizedBox(height: 10),
                                              TextButton(
                                                  onPressed: () {
                                                    defenceManagementController
                                                        .inputGuest("");

                                                    navigator!.pop();
                                                  },
                                                  child: Text("clear".tr))
                                            ],
                                          ),
                                        ));
                                  },
                                  child: Text(defenceManagementController
                                              .newDefense?.jurys?.guest ==
                                          null
                                      ? "add".tr
                                      : "edit".tr)),
                            ),
                          ],
                        ));
                  }),
                  // GetBuilder<DefenceManagementController>(builder: (conttext) {
                  //   return ListView.separated(
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemCount: defenceManagementController
                  //         .defenceData!.jurys!.examiners!.length,
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //           padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color:
                  //                   Theme.of(context).listTileTheme.tileColor),
                  //           child: Row(
                  //             children: [
                  //               // ProfilePictureForOtherUserss(
                  //               //     photoUrl: defenceManagementController
                  //               //         .defenceData!
                  //               //         .jurys!
                  //               //         .examiners![index]
                  //               //         .photoUrl!,
                  //               //     email: defenceManagementController
                  //               //         .defenceData!
                  //               //         .jurys!
                  //               //         .examiners![index]
                  //               //         .email!),
                  //               // const SizedBox(width: 5),
                  //               // Expanded(
                  //               //   child: Text(
                  //               //     "${defenceManagementController.defenceData!.jurys!.examiners![index].email}",
                  //               //     style: TextStyle(
                  //               //         fontSize: Theme.of(context)
                  //               //             .textTheme
                  //               //             .titleMedium!
                  //               //             .fontSize,
                  //               //         fontWeight: FontWeight.bold),
                  //               //   ),
                  //               // ),
                  //               // SizedBox(
                  //               //     height: 45,
                  //               //     width: 45,
                  //               //     child: IconButton(
                  //               //       icon: const DeleteIcon(),
                  //               //       onPressed: () {},
                  //               //     )),
                  //             ],
                  //           ));
                  //     },
                  //     separatorBuilder: (context, index) {
                  //       return const SizedBox(
                  //         height: 10,
                  //       );
                  //     },
                  //   );
                  // }),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      if (true) {
                        // formKey.currentState!.validate()
                        //formKey.currentState!.save();
                        defenceManagementController.createNewDefense();
                      }
                    },
                    child: Text(
                      "submit".tr,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // defenceManagementController.defenceData!.files!.isNotEmpty
                  //     ? Column(
                  //         children: [
                  //           TextButton(
                  //             onPressed: () {
                  //               if (true) {
                  //                 // formKey.currentState!.validate()
                  //                 //formKey.currentState!.save();
                  //                 defenceManagementController.next();
                  //               }
                  //             },
                  //             child: Text(
                  //               "createRole5".tr,
                  //             ),
                  //           ),
                  //           const SizedBox(height: 10),
                  //         ],
                  //       )
                  //     : const SizedBox(),
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
                        defenceManagementController.goBackPageViewNewDefense();
                      }
                    },
                    child: Text("goBack".tr,
                        style: const TextStyle(color: bluePurpleColor)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // SingleChildScrollView(
            //   child: ListView.separated(
            //     itemCount:
            //         defenceManagementController.defenceData!.files!.length,
            //     separatorBuilder: (context, index) {
            //       return const SizedBox(height: 10);
            //     },
            //     itemBuilder: (context, index) {
            //       return InkWell(
            //         onTap: () {
            //           defenceManagementController.downloadfile(
            //               defenceManagementController
            //                   .defenceData!.files!.entries
            //                   .toList()[index]);
            //         },
            //         child: Container(
            //             padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 color: Theme.of(context).listTileTheme.tileColor),
            //             child: Row(
            //               children: [
            //                 const SizedBox(
            //                     height: 45,
            //                     width: 45,
            //                     child: ImageIcon(
            //                       size: 30,
            //                       Svg("assets/icons/file_icon.svg"),
            //                     )),
            //                 const SizedBox(width: 10),
            //                 Expanded(
            //                   child: Text(
            //                     defenceManagementController
            //                         .defenceData!.files!.keys
            //                         .toList()[index],
            //                     style: TextStyle(
            //                         fontSize: Theme.of(context)
            //                             .textTheme
            //                             .titleMedium!
            //                             .fontSize,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                 ),
            //               ],
            //             )),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
