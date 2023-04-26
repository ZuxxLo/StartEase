import 'package:flutter/material.dart';
 
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
     final AllRolesController allRolesController = Get.find();
    return Scaffold(
      appBar: AppBar(
        //  title: Text("roles".tr),
        leading: const BackIconButton(),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("roles".tr),
                const SizedBox(
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
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allRolesController.rolesList!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(left: 20, right: 0),
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
                              const SizedBox(
                                width: 50,
                              ),
                              PopupMenuButton<int>(
                                icon: const Icon(
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
                        return const Divider();
                      },
                    ) : const Text("//")
                  : const Center(child: CircularProgressIndicator()),
            );
          })
        ],
      ),
    );
  }
}
