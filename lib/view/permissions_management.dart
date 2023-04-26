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
    double screenWidth = MediaQuery.of(context).size.width;
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
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 70),
            child: Text("createRole6".tr),
          ),
          const Divider(),
          GetBuilder<PermissionsManagementController>(builder: (context) {
            return SizedBox(
              height: screenHeight - 150,
              child: permissionsManagement.allPermissionsList.isNotEmpty
                  ? ListView.separated(
                       physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          permissionsManagement.allPermissionsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(left: 30, right: 20),
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
                                  icon: DeleteIcon())
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            );
          })
        ],
      ),
    );
  }
}
