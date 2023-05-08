import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/model/period_model.dart';
import 'package:startease/view/widgets.dart';

import '../controller/periods_management_controller.dart';
import '../services/languages.dart';

class PeriodsManagement extends StatelessWidget {
  const PeriodsManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final PeriodsManagementController periodsManagementController = Get.find();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: Text("periodsManagement".tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("period".tr),
            ),
            const SizedBox(
              height: 5,
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    GetBuilder<PeriodsManagementController>(
                        builder: (contextt) {
                      return DropdownButtonFormField(
                        isExpanded: true,
                        decoration: InputDecoration(
                            prefixIcon: const ImageIcon(
                                Svg("assets/icons/period_icon.svg")),
                            filled: true,
                            fillColor:
                                Theme.of(context).listTileTheme.tileColor,
                            hintText: "selectPeriod".tr),
                        dropdownColor:
                            Get.isDarkMode ? greyColor : lightBlueColor,
                        validator: (value) {
                          if (value == null) {
                            return "selectPeriod".tr;
                          }
                          // if (value == 0) {
                          //   return "selectAPeriod".tr;
                          // }
                          return null;
                        },
                        onChanged: (Period? period) {
                          periodsManagementController.inputPeriodValue(period);
                        },
                        onSaved: (Period? period) {
                          print("saaaaaaaaaaaaaaaaved");
                          periodsManagementController.inputPeriodValue(period);
                        },
                        items: periodsManagementController.periodsList
                            .map<DropdownMenuItem<Period>>((Period value) {
                          return DropdownMenuItem<Period>(
                            value: value,
                            child: Text(
                              value.name!,
                              style:
                                  const TextStyle(overflow: TextOverflow.clip),
                            ),
                          );
                        }).toList(),
                      );
                    }),
                    const SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("startTime".tr),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GetBuilder<PeriodsManagementController>(
                        builder: (contexxt) {
                      return TextFormField(
                          readOnly: true,
                          validator: (value) {
                            if (periodsManagementController.startDate == null) {
                              return "enterADate".tr;
                            }
                            if (periodsManagementController
                                .startDate!.isEmpty) {
                              return "enterADate".tr;
                            }
                            if (periodsManagementController.endDate != null &&
                                DateTime.parse(
                                        periodsManagementController.startDate!)
                                    .isAfter(DateTime.parse(
                                        periodsManagementController
                                            .endDate!))) {
                              return "startDateBeforeEndDate".tr;
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
                                periodsManagementController
                                    .inputStartDate(value);
                              }
                            });
                          },
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              prefixIcon: const ImageIcon(
                                  Svg("assets/icons/calendar_icon.svg")),
                              hintText: periodsManagementController
                                      .selectedPeriod?.startDate ??
                                  "startTime".tr));
                    }),
                    const SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("endTime".tr),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GetBuilder<PeriodsManagementController>(
                        builder: (contxext) {
                      return TextFormField(
                          readOnly: true,
                          validator: (value) {
                            if (periodsManagementController.endDate == null) {
                              return "enterADate".tr;
                            }
                            if (periodsManagementController.endDate!.isEmpty) {
                              return "enterADate".tr;
                            }
                            if (periodsManagementController.startDate != null &&
                                DateTime.parse(
                                        periodsManagementController.endDate!)
                                    .isBefore(DateTime.parse(
                                        periodsManagementController
                                            .startDate!))) {
                              return "startDateBeforeEndDate".tr;
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
                                periodsManagementController.inputEndDate(value);
                              }
                            });
                          },
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              prefixIcon: const ImageIcon(
                                  Svg("assets/icons/calendar_icon.svg")),
                              hintText: periodsManagementController
                                      .selectedPeriod?.endDate ??
                                  "endTime".tr));
                    }),
                  ],
                )),
            const SizedBox(
              height: 35,
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  periodsManagementController.confirm();
                  print(periodsManagementController.selectedPeriod!.endDate);
                }
              },
              child: Text(
                "update".tr,
              ),
            )
          ],
        ),
      ),
    );
  }
}
