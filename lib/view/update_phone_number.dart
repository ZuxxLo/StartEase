import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/view/widgets.dart';

import '../Themes/colors.dart';
import '../controller/profile_page_controller.dart';
import '../main.dart';

class UpdatePhoneNumber extends StatelessWidget {
  const UpdatePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfilePageController profilePageController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 15,
          ),
          //phone number
          Form(
            key: profilePageController.formKeyUpdatePhone,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (!RegExp(r'(^[+]?[0-9]{3,}$)').hasMatch(value ?? '')) {
                      return "enterValidPhoneNumber".tr;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    profilePageController.newPhoneNumber = value;
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
                      if (profilePageController.formKeyUpdatePhone.currentState!
                          .validate()) {
                        profilePageController.formKeyUpdatePhone.currentState!
                            .save();
                        profilePageController.sendSMSVerification();
                      }
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
                GetBuilder<ProfilePageController>(builder: (context) {
                  return TextFormField(
                    enabled: profilePageController.smsEnabled,
                    maxLength: 6,
                    onChanged: (inputSMS) {
                      profilePageController.codeSMS = inputSMS;
                    },
                    validator: (value) {
                      if (value!.length < 6) {
                        return "enterSMS".tr;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: PasswordKeyIcon(),
                      hintText: "SMS",
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              if (profilePageController.formKeyUpdatePhone.currentState!
                  .validate()) {
                profilePageController.formKeyUpdatePhone.currentState!.save();
                profilePageController.updatePhoneNumber();
              }
            },
            child: Text(
              "update".tr,
            ),
          ),
        ],
      ),
    );
  }
}
