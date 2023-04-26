import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_page_controller.dart';
import 'widgets.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfilePageController profilePageController = Get.find();
    double screenHeight = MediaQuery.of(context).size.height;
     return Scaffold(
      appBar: AppBar(
        title: Text("changePassword".tr),
        leading: const BackIconButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Form(
          key: profilePageController.passwordFormKey,
          child: Column(
            children: [
              GetBuilder<ProfilePageController>(builder: (cntx) {
                return TextFormField(
                  obscureText: profilePageController.securedPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enterPassword".tr;
                    }

                    return null;
                  },
                  onChanged: (password) {
                    profilePageController.inputoldPassword(password);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const PasswordKeyIcon(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          profilePageController.invertSecuredPassword();
                        },
                        icon: profilePageController.securedPassword
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined)),
                    hintText: "oldPassword".tr,
                  ),
                );
              }),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              GetBuilder<ProfilePageController>(builder: (cntx) {
                return TextFormField(
                  obscureText: profilePageController.securedPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enterPassword".tr;
                    }
                    if (value.length > 20) {
                      return "password>20".tr;
                    }
                    if (value.length < 8) {
                      return "password<8".tr;
                    }

                    return null;
                  },
                  onChanged: (password) {
                    profilePageController.inputnewPassword(password);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const PasswordKeyIcon(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          profilePageController.invertSecuredPassword();
                        },
                        icon: profilePageController.securedPassword
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined)),
                    hintText: "newPassword".tr,
                  ),
                );
              }),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              GetBuilder<ProfilePageController>(builder: (cntx) {
                return TextFormField(
                  obscureText: profilePageController.securedPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enterPassword".tr;
                    }
                    if (value != profilePageController.newPassword) {
                      return "passwordsNoMatch".tr;
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const PasswordKeyIcon(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          profilePageController.invertSecuredPassword();
                        },
                        icon: profilePageController.securedPassword
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined)),
                    hintText: "newPassword".tr,
                  ),
                );
              }),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              TextButton(
                  onPressed: () {
                    if (profilePageController.passwordFormKey.currentState!
                        .validate()) {profilePageController.passwordFormKey.currentState!
                        .save();
                        profilePageController.upadatePassword();
                        
                        }
                  },
                  child: Text("changePassword".tr)),
            ],
          ),
        ),
      ),
    );
  }
}
