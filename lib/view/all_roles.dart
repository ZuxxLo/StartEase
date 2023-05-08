import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

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
        title: GetBuilder<AllRolesController>(builder: (context) {
          return Text(
            allRolesController.searchText == ""
                ? ""
                : "searching".tr + allRolesController.searchText,
            style: TextStyle(fontSize: 18),
          );
        }),
        leading: const BackIconButton(),
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "searchByFirstLastName".tr,
                    content: Column(
                      children: [
                        TextFormField(
                          onChanged: (inputSearch) {
                            allRolesController.searchTextInput(inputSearch);
                          },
                          decoration: InputDecoration(
                              hintText: allRolesController.searchText == ""
                                  ? "searchByFirstLastName".tr
                                  : allRolesController.searchText),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              allRolesController
                                  .searchRole(allRolesController.searchText);
                              navigator!.pop();
                            },
                            child: Text("confirm".tr)),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              allRolesController.searchTextInput("");
                              allRolesController.searchRole("");
                              navigator!.pop();
                            },
                            child: Text("clear".tr))
                      ],
                    ));
              },
              icon: const ImageIcon(Svg("assets/icons/search_icon.svg"))),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 40),
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
            return allRolesController.rolesListToAffich!.isNotEmpty
                ? !allRolesController.rolesListToAffich!
                        .contains(Roles(id: -77, name: "error77empty"))
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allRolesController.rolesListToAffich!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 70,
                            padding: const EdgeInsets.only(left: 20, right: 0),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).listTileTheme.tileColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: SmallBodyText(
                                            text: allRolesController
                                                .rolesListToAffich![index].name
                                                .toString(),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        SmallBodyText(
                                            text: allRolesController
                                                .rolesListToAffich![index]
                                                .usersCount
                                                .toString()),
                                      ]),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                allRolesController
                                            .rolesListToAffich![index].type ==
                                        RolesType.defaultType
                                    ? IconButton(
                                        onPressed: () {
                                          allRolesController.editRole(index);
                                        },
                                        icon: const ImageIcon(
                                          color: bluePurpleColor,
                                          size: 20,
                                          Svg("assets/icons/edit_project_icon.svg"),
                                        ),
                                      )
                                    : PopupMenuButton<int>(
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color: bluePurpleColor,
                                        ),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            onTap: () {},
                                            value: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("delete".tr),
                                                const ImageIcon(
                                                  size: 23,
                                                  Svg("assets/icons/delete_icon.svg"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            onTap: () {},
                                            value: 2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("edit".tr),
                                                const ImageIcon(
                                                  size: 20,
                                                  Svg("assets/icons/edit_project_icon.svg"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                        onSelected: (value) {
                                          if (value == 2) {
                                            allRolesController.editRole(index);
                                          } else if (value == 1) {
                                            allRolesController.deleteRole(
                                                allRolesController
                                                    .rolesListToAffich![index]
                                                    .id);
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
                      )
                    : Center(child: Text("noResults".tr))
                : allRolesController.searchText == ""
                    ? Column(
                        children: [
                          SizedBox(height: screenHeight / 3),
                          const CircularProgressIndicator(),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(height: screenHeight / 3),
                          Text("noResults".tr),
                        ],
                      );
          })
        ],
      ),
    );
  }
}
