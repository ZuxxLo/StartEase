import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/controller/all_roles_controller.dart';
import 'package:startease/model/roles_model.dart';
import 'package:startease/view/widgets.dart';

class AllRoles extends StatelessWidget {
  const AllRoles({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final AllRolesController allRolesController = Get.find();
    return Scaffold(
      appBar: AppBar(
        //  title: Text("roles".tr),
        leading: const BackIconButton(),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("roles".tr),
                SizedBox(
                  width: 50,
                ),
                Text("users".tr)
              ],
            ),
          ),
          const Divider(),
          GetBuilder<AllRolesController>(builder: (context) {
            return SizedBox(
              height: screenHeight - 150,
              child: allRolesController.rolesList!.isNotEmpty
                  ? !allRolesController.rolesList!.contains(Roles(id: -77,name: "error77empty"))? ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allRolesController.rolesList!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(left: 20, right: 0),
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
                                              .rolesList![index].name
                                              .toString()),
                                      SmallBodyText(
                                          text: allRolesController
                                              .rolesList![index].usersCount
                                              .toString()),
                                    ]),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              PopupMenuButton<int>(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: purpleColor,
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {},
                                    value: 1,
                                    child: Text("delete".tr),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {},
                                    value: 2,
                                    child: Text("edit".tr),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == 2) {
                                    allRolesController.editRole(index);
                                  } else if (value == 1) {
                                    allRolesController.deleteRole(allRolesController
                                              .rolesList![index].id);
                                  }
                                },
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    ) : Text("//")
                  : Center(child: CircularProgressIndicator()),
            );
          })
        ],
      ),
    );
  }
}
