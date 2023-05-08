import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../controller/profile_page_controller.dart';
import '../main.dart';
import 'widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final ProfilePageController profilePageController = Get.find();

    return Scaffold(
        key: profilePageController.scaffoldKey,
        appBar: AppBar(
          leading: const BackIconButton(),
          title: Text("Account".tr),
        ),

        // Drawer(
        //   child: ListView(
        //     children: <Widget>[
        //       ExpansionTile(
        //         title: Text("Expansion Title"),
        //         children: <Widget>[Text("children 1"), Text("children 2")],
        //       )
        //     ],
        //   ),
        // ),
        body: GetBuilder<ProfilePageController>(
          builder: (context) {
            if (profilePageController.isInternetConnected) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: prefer_const_constructors
                    ProfilePicture(),
                    TitleMediumText(
                        text: userModel.person?.firstName != null
                            ? "${userModel.person?.firstName} ${userModel.person?.lastName}"
                            : ""),
                    UserNameText(text: "@${userModel.username}"),
                    const SizedBox(
                      height: 40,
                    ),
                    Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 20,
                        children: [
                          ListTile(
                            title: Text(
                              "yourInformations".tr,
                            ),
                            leading: const ProfileCircleIcon(),
                            onTap: () {
                              profilePageController.goToInformationsPage();
                            },
                          ),
                          ListTile(
                            title: Text(
                              "changePassword".tr,
                            ),
                            leading: const PasswordKeyIcon(),
                            onTap: () {
                              profilePageController.goToChangePassword();
                            },
                          ),
                          ListTile(
                            title: Text(
                              "updatePhoneNumber".tr,
                            ),
                            leading: const ImageIcon(
                              Svg("assets/icons/phonenumber_icon.svg"),
                            ),
                            onTap: () {
                              profilePageController.goToUpdatePhoneNumber();
                            },
                          )
                        ]),
                  ],
                ),
              );
            } else {
              profilePageController.getBoolisInternetConnected();
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
