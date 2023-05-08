import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/controller/create_role_controller.dart';
import 'package:get/get.dart';
import 'package:startease/view/widgets.dart';

class CreateRole extends StatelessWidget {
  const CreateRole({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final CreateRoleController createRoleController = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("createRole".tr),
        leading: const BackIconButton(),
        actions: [
          GetBuilder<CreateRoleController>(
            builder: (controller) {
              if (createRoleController.currentStepIndex == 2) {
                return Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                      onPressed: () {
                        createRoleController.submit();
                      },
                      icon: const ImageIcon(Svg("assets/icons/done_icon.svg"),
                          color: bluePurpleColor, size: 30)),
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: GetBuilder<CreateRoleController>(builder: (context) {
                return SizedBox(
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: const Divider(
                          color: Colors.grey,
                          thickness: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int step in createRoleController.steps)
                            Container(
                              alignment: Alignment.center,
                              height: step <=
                                      createRoleController.currentStepIndex + 1
                                  ? 26.0
                                  : 26.0,
                              width: step <=
                                      createRoleController.currentStepIndex + 1
                                  ? 26.0
                                  : 26.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: step <=
                                        createRoleController.currentStepIndex +
                                            1
                                    ? bluePurpleColor
                                    : Colors.grey,
                              ),
                              child: Text(
                                step.toString(),
                                style: const TextStyle(
                                    fontSize: 15, color: whiteColor),
                              ),
                            )
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              height: screenHeight - 100,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: createRoleController.pageController,
                onPageChanged: (value) {
                  createRoleController.changeStepCurrentIndex(value);
                },
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleMediumText(text: "createRole".tr),
                      const SizedBox(
                        height: 10,
                      ),
                      SmallBodyText(text: "createRole1".tr),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            createRoleController.start();
                          },
                          child: Text("createRole2".tr))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TitleMediumText(text: "createRole3".tr),
                      const SizedBox(
                        height: 10,
                      ),
                      SmallBodyText(text: "createRole4".tr),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: createRoleController.roleNameFormKey,
                        child: TextFormField(
                          decoration:
                              InputDecoration(hintText: "createRole9".tr),
                          onChanged: (value) {
                            createRoleController.roleNameInput(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "enterRoleName".tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            if (createRoleController
                                .roleNameFormKey.currentState!
                                .validate()) {
                              createRoleController.roleNameFormKey.currentState!
                                  .save();
                              createRoleController.next();
                            }
                          },
                          child: Text("createRole5".tr))
                    ],
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleMediumText(text: "createRole6".tr),
                        const SizedBox(
                          height: 10,
                        ),
                        SmallBodyText(text: "createRole7".tr),
                        const SizedBox(
                          height: 10,
                        ),
                        GetBuilder<CreateRoleController>(builder: (context) {
                          return createRoleController.permissionsList.isNotEmpty
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return const Divider();
                                  },
                                  itemCount: createRoleController
                                      .permissionsList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 70,
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .listTileTheme
                                              .tileColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(createRoleController
                                              .permissionsList[index].name
                                              .toString()),
                                          CupertinoSwitch(
                                            value: createRoleController
                                                .permissionsList[index].value,
                                            onChanged: ((value) {
                                              createRoleController
                                                  .changePermissionValue(
                                                      index, value);
                                            }),
                                            thumbColor: createRoleController
                                                    .permissionsList[index]
                                                    .value
                                                ? bluePurpleColor
                                                : greyColor,
                                            activeColor: bluePurpleColor
                                                .withOpacity(0.5),
                                          )
                                        ],
                                      ),
                                    );
                                  })
                              : const Center(child: Text("is empty "));
                        }),
                        // const SizedBox(height: 20),
                        // TextButton(
                        //     onPressed: () {
                        //       createRoleController.submit();
                        //     },
                        //     child: Text("createRole8".tr))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
