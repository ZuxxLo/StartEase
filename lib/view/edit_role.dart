import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/controller/all_roles_controller.dart';
import 'package:startease/view/widgets.dart';

class EditRole extends StatelessWidget {
  const EditRole({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
     final AllRolesController allRolesController = Get.find();
    return Scaffold(
      appBar: AppBar(
        //  title: Text("edit".tr),
        leading: const BackIconButton(),
        actions: [
          IconButton(
              onPressed: () {
                allRolesController.updateRolePermissions();
              },
              icon: const Icon(
                Icons.done_outline,
                size: 30,
                color: purpleColor,
              ))
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 70),
            child: Text("createRole6".tr),
          ),
          const Divider(),
          GetBuilder<AllRolesController>(builder: (context) {
            return SizedBox(
              height: screenHeight - 150,
              child: allRolesController.rolesList!.isNotEmpty
                  ? ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allRolesController.allPermissionsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(left: 30, right: 20),
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SmallBodyText(
                                          text: allRolesController
                                              .allPermissionsList[index].name
                                              .toString()),
                                    ]),
                              ),
                              CupertinoSwitch(
                                value: allRolesController
                                    .allPermissionsList[index].value,
                                onChanged: ((value) {
                                  allRolesController.changePermissionValue(
                                      index, value);
                                }),
                                thumbColor: allRolesController
                                        .allPermissionsList[index].value
                                    ? purpleColor
                                    : greyColor,
                                activeColor: purpleColor.withOpacity(0.5),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    )
                  : const Text("is empty "),
            );
          })
        ],
      ),
    );
  }
}
