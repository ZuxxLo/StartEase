import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/controller/permissions_management_controller.dart';

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
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: whiteColor,
        ),
        onPressed: () {
          permissionsManagement.addNewPermission();
        },
      ),floatingActionButtonLocation:FloatingActionButtonLocation.endTop ,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 70),
            child: Text("createRole6".tr),
          ),
          const Divider(),
          GetBuilder<PermissionsManagementController>(builder: (context) {
            return SizedBox(
              height: screenHeight - 150,
              child: permissionsManagement.allPermissionsList.isNotEmpty
                  ? ListView.separated(
                       physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          permissionsManagement.allPermissionsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(left: 30, right: 20),
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SmallBodyText(
                                    text: permissionsManagement
                                        .allPermissionsList[index].name
                                        .toString()),
                              ),
                              IconButton(
                                  onPressed: () {
                                    permissionsManagement.deletePermission(
                                        permissionsManagement
                                            .allPermissionsList[index].id);
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
                  : const Center(child: CircularProgressIndicator()),
            );
          })
        ],
      ),
    );
  }
}
