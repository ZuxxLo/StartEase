import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/controller/permissions_management_controller.dart';
import 'package:startease/model/permissions_model.dart';

import 'widgets.dart';

class PermissionsManagement extends StatelessWidget {
  const PermissionsManagement({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final PermissionsManagementController permissionsManagement = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: GetBuilder<PermissionsManagementController>(builder: (context) {
          return Text(
            permissionsManagement.searchText == ""
                ? "createRole6".tr
                : "searching".tr + permissionsManagement.searchText,
            style: TextStyle(
                fontSize: permissionsManagement.searchText == "" ? 25 : 18),
          );
        }),
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "searchByFirstLastName".tr,
                    content: Column(
                      children: [
                        TextFormField(
                          onChanged: (inputSearch) {
                            permissionsManagement.searchTextInput(inputSearch);
                          },
                          decoration: InputDecoration(
                              hintText: permissionsManagement.searchText == ""
                                  ? "searchByFirstLastName".tr
                                  : permissionsManagement.searchText),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              permissionsManagement.searchPermission(
                                  permissionsManagement.searchText);
                              navigator!.pop();
                            },
                            child: Text("confirm".tr)),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              permissionsManagement.searchTextInput("");
                              permissionsManagement.searchPermission("");
                              navigator!.pop();
                            },
                            child: Text("clear".tr))
                      ],
                    ));
              },
              icon: const ImageIcon(Svg("assets/icons/search_icon.svg"))),
          IconButton(
              onPressed: () {
                permissionsManagement.addNewPermission();
              },
              icon: const ImageIcon(
                  size: 30, Svg("assets/icons/add_square_icon.svg")))
        ],
      ),
      body: GetBuilder<PermissionsManagementController>(builder: (context) {
        return permissionsManagement.allPermissionsListToAffich.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    permissionsManagement.allPermissionsListToAffich.length,
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
                          child: SmallBodyText(
                              text: permissionsManagement
                                  .allPermissionsListToAffich[index].name
                                  .toString()),
                        ),
                        permissionsManagement
                                    .allPermissionsListToAffich[index].type ==
                                PermissionsType.defaultType
                            ? const SizedBox()
                            : IconButton(
                                onPressed: () {
                                  if (!Get.isDialogOpen!) {
                                    Get.defaultDialog(
                                        title: "areUSure".tr,
                                        content: Column(
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  permissionsManagement
                                                      .deletePermissionRequest(
                                                          permissionsManagement
                                                              .allPermissionsListToAffich[
                                                                  index]
                                                              .id);
                                                  Get.back();
                                                },
                                                child: Text("confirm".tr)),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text("cancel".tr)),
                                          ],
                                        ));
                                  }
                                },
                                icon: const DeleteIcon())
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              )
            : permissionsManagement.searchText == ""
                ? const Center(child: CircularProgressIndicator())
                : Center(child: Text("noResults".tr));
      }),
    );
  }
}
