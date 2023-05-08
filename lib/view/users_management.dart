import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../Themes/colors.dart';
import '../controller/users_management_controller.dart';
import 'widgets.dart';

class UsersManagement extends StatelessWidget {
  const UsersManagement({super.key});

  @override
  Widget build(BuildContext context) {
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
                    // ListTile(
                    //   title: Text(
                    //     "allUsers".tr,
                    //   ),
                    //   leading: const ImageIcon(
                    //     size: 35,
                    //     Svg("assets/icons/multiple_users.svg"),
                    //   ),
                    //   onTap: () {
                    //     usersManagementController.goToAllUsers();
                    //   },
                    // ),
                    // ListTile(
                    //   title: Text(
                    //     "createNewUser".tr,
                    //   ),
                    //   leading: const ImageIcon(
                    //     size: 35,
                    //     Svg("assets/icons/add_user.svg"),
                    //   ),
                    //   onTap: () {
                    //     usersManagementController.goToCreateNewUser();
                    //   },
                    // ),
                    InkWell(
                      onTap: () {
                        usersManagementController.goToAllUsers();
                      },
                      child: Container(
                        width: 200,
                        height: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: greyColor)),
                        child: Column(children: [
                          const Expanded(
                            child: ImageIcon(
                              size: 80,
                              Svg("assets/icons/multiple_users.svg"),
                            ),
                          ),
                          Text(
                            "allUsers".tr,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        usersManagementController.goToCreateNewUser();
                      },
                      child: Container(
                        width: 200,
                        height: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: greyColor)),
                        child: Column(children: [
                          const Expanded(
                            child: ImageIcon(
                              size: 80,
                              Svg("assets/icons/add_user.svg"),
                            ),
                          ),
                          Text(
                            "createNewUser".tr,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ]),
                      ),
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
