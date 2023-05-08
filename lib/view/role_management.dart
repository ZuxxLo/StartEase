import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';

import '../controller/role_management_controller.dart';
import 'widgets.dart';

class RoleManagemenet extends StatelessWidget {
  const RoleManagemenet({super.key});

  @override
  Widget build(BuildContext context) {
    final RoleManagemenetController roleManagemenetController = Get.find();
    return Scaffold(
        appBar: AppBar(
          leading: MenuIcon(onPressed: () {
            Scaffold.of(context).openDrawer();
          }),
          title: Text("roleManagement".tr),
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Column(
              children: [
                // ProfilePicture(),
                // TitleMediumText(
                //     text: "${userModel.firstName} ${userModel.lastName}"),
                // const SizedBox(
                //   height: 10,
                // ),
                InkWell(
                  onTap: () {
                    roleManagemenetController.roles();
                  },
                  child: Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: greyColor)),
                    child: Column(children: [
                      Expanded(
                        child: Image.asset(
                          "assets/images/roles.png",
                        ),
                      ),
                      Text(
                        "roles".tr,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    roleManagemenetController.createNewRole();
                  },
                  child: Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: greyColor)),
                    child: Column(children: [
                      Expanded(
                        //      child: ImageIcon(Svg("assets/images/Mask group.svg"))
                        child: Image.asset(
                          "assets/images/create_new_role.png",
                        ),
                      ),
                      Text(
                        "createRole".tr,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    roleManagemenetController.permissionsManagement();
                  },
                  child: Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: greyColor)),
                    child: Column(children: [
                      Expanded(
                        child: SizedBox(
                          child: Image.asset(
                            "assets/images/permission_management.png",
                          ),
                        ),
                      ),
                      Text(
                        "permissionsManagement".tr,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
