import 'package:flutter/material.dart';

import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../Themes/colors.dart';
import '../controller/profile_page_controller.dart';
import '../main.dart';
import 'widgets.dart';

class ViewProfileInformations extends StatelessWidget {
  const ViewProfileInformations({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfilePageController profilePageController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: Text("PersonalInformation".tr),
      ),
      body: GetBuilder<ProfilePageController>(
        builder: (ctx) {
          if (profilePageController.isInternetConnected) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                          ProfilePicture(),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: IconButton(
                            onPressed: () {profilePageController.uploadPicture();},
                            icon: Container(
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: whiteColor,
                                  ),
                                  color: bluePurpleColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: const ImageIcon(
                                color: whiteColor,
                                size: 80,
                                Svg("assets/icons/edit_icon.svg"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TitleMediumText(
                        text: "${userModel.firstName} ${userModel.lastName}"),
                    const SizedBox(
                      height: 10,
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: UserNameText(text: "PersonalInformation".tr),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: profilePageController.formKey,
                      child: Column(
                        children: [
                          //Username
                          TextFormField(
                            initialValue: userModel.username,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              }
                              if (value.isNotEmpty && value.length < 3) {
                                return "usernameValidator".tr;
                              }

                              return null;
                            },
                            onChanged: (inputUsername) {
                              profilePageController
                                  .inputnewUsername(inputUsername);
                            },
                            decoration: const InputDecoration(
                              prefixIcon: ImageIcon(
                                Svg("assets/icons/tag_user_icon.svg"),
                              ),
                              hintText: "@user_name",
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //birthday
                          TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              prefixIcon: const ImageIcon(
                                Svg("assets/icons/calendar_icon.svg"),
                              ),
                              hintText: userModel.birthday,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //birthplace
                          TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              prefixIcon: const ImageIcon(
                                Svg("assets/icons/location_icon.svg"),
                              ),
                              hintText: userModel.birthPlace,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //email
                          TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              prefixIcon: const EmailIcon(),
                              hintText: userModel.email,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //phone number
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == "") {
                                return null;
                              }
                              if (!RegExp(
                                      r'(^[+][0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
                                  .hasMatch(value ?? '')) {
                                return "enterValidPhoneNumber".tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const ImageIcon(
                                Svg("assets/icons/phonenumber_icon.svg"),
                              ),
                              hintText: userModel.phoneNumber,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              child: Text(
                                "sendSMSVerification".tr,
                                style: const TextStyle(
                                  color: bluePurpleColor,
                                  fontSize: 15,
                                ),
                              ),
                              onTap: () {
                                profilePageController.sendSMSVerification();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: SmallBodyText(text: "enterSMS".tr)),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            enabled: profilePageController.smsEnabled,
                            onChanged: (inputUsername) {},
                            decoration: const InputDecoration(
                              prefixIcon: PasswordKeyIcon(),
                              hintText: "SMS",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextButton(
                      onPressed: () {
                        if (profilePageController.formKey.currentState!
                            .validate()) {
                          profilePageController.formKey.currentState!.save();
                          profilePageController.confirm();
                        }
                      },
                      child: Text(
                        "confirm".tr,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            profilePageController.getBoolisInternetConnected();
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
