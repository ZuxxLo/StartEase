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
    double screenWidth = MediaQuery.of(context).size.width;
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
              icon: Icon(
                Icons.done_outline,
                size: 30,
                color: purpleColor,
              ))
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 70),
            child: Text("createRole6".tr),
          ),
          const Divider(),
          GetBuilder<AllRolesController>(builder: (context) {
            return SizedBox(
              height: screenHeight - 150,
              child: allRolesController.rolesList!.isNotEmpty
                  ? ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allRolesController.allPermissionsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(left: 30, right: 20),
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
                        return Divider();
                      },
                    )
                  : Text("is empty "),
            );
          })
        ],
      ),
    );
  }
}
