import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

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
        title: GetBuilder<AllRolesController>(builder: (context) {
          return Text(
            allRolesController.searchTextPermission == ""
                ? "createRole6".tr
                : "searching".tr + allRolesController.searchTextPermission,
            style: TextStyle(
                fontSize:
                    allRolesController.searchTextPermission == "" ? 25 : 18),
          );
        }),
        leading: const BackIconButton(),
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "searchByName".tr,
                    content: Column(
                      children: [
                        TextFormField(
                          onChanged: (inputSearch) {
                            allRolesController
                                .searchTextInputPermission(inputSearch);
                          },
                          decoration: InputDecoration(
                              hintText:
                                  allRolesController.searchTextPermission == ""
                                      ? "searchByName".tr
                                      : allRolesController
                                          .searchTextPermission),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              allRolesController.searchPermission(
                                  allRolesController.searchTextPermission);
                              navigator!.pop();
                            },
                            child: Text("confirm".tr)),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              allRolesController.searchTextInputPermission("");
                              allRolesController.searchPermission("");
                              navigator!.pop();
                            },
                            child: Text("clear".tr))
                      ],
                    ));
              },
              icon: const ImageIcon(Svg("assets/icons/search_icon.svg"))),
          IconButton(
              onPressed: () {
                allRolesController.updateRolePermissions();
              },
              icon: const ImageIcon(Svg("assets/icons/done_icon.svg"))),
          const SizedBox(width: 10)
        ],
      ),
      body: GetBuilder<AllRolesController>(builder: (context) {
        return allRolesController.allPermissionsListToAffich.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                physics: const BouncingScrollPhysics(),
                 shrinkWrap: true,
                itemCount:
                    allRolesController.allPermissionsListToAffich.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 70,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).listTileTheme.tileColor,
                        borderRadius: BorderRadius.circular(15)),
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
                                        .allPermissionsListToAffich[index]
                                        .name
                                        .toString()),
                              ]),
                        ),
                        CupertinoSwitch(
                          value: allRolesController
                              .allPermissionsListToAffich[index].value,
                          onChanged: ((value) {
                            allRolesController.changePermissionValue(
                                index, value);
                          }),
                          thumbColor: allRolesController
                                  .allPermissionsListToAffich[index].value
                              ? bluePurpleColor
                              : greyColor,
                          activeColor: bluePurpleColor.withOpacity(0.5),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              )
            : Center(child: Text("noResults".tr));
      }),
    );
  }
}
