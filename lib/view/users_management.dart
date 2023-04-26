import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/users_management_controller.dart';
import 'widgets.dart';

class UsersManagement extends StatelessWidget {
  const UsersManagement({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final UsersManagementController usersManagementController = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: MenuIcon(onPressed: () {
          Scaffold.of(context).openDrawer();
        }),
        title: Text("usersManagement".tr),
      ),
      body: GetBuilder<UsersManagementController>(
        builder: (context) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 20,
                  children: [
                    ListTile(
                      title: Text(
                        "allUsers".tr,
                      ),
                      leading: const ProfileCircleIcon(),
                      trailing: const SendIcon(),
                      onTap: () {
                        usersManagementController.goToAllUsers();
                      },
                    ),
                    ListTile(
                      title: Text(
                        "createNewUser".tr,
                      ),
                      leading: const ProfileCircleIcon(),
                      trailing: const SendIcon(),
                      onTap: () {
                        usersManagementController.goToCreateNewUser();
                      },
                    )
                  ]),
            ),
          );
        },
      ),
    );
  }
}
