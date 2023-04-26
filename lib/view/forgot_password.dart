import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../Themes/colors.dart';
import '../controller/forgot_password_controller.dart';
import 'widgets.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController forgotPasswordController = Get.find();

    double screenHeight = MediaQuery.of(context).size.height;
     return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          height: screenHeight / 1.35,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: forgotPasswordController.pageController,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const LogoStartEase(),
                  // SizedBox(
                  //   height: screenHeight * 0.025,
                  // ),
                  // Text("resetPassword".tr,
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize:
                  //             Theme.of(context).textTheme.titleLarge!.fontSize,
                  //         color:
                  //             Theme.of(context).textTheme.titleLarge!.color)),
                  // SizedBox(
                  //   height: screenHeight * 0.03,
                  // ),
                  TitleLargeText(text: "resetPassword".tr),
                  const SizedBox(
                    height: 15,
                  ),
                  SmallBodyText(text: "forgotYourPassword?".tr),
                  SmallBodyText(text: "weWillSendUReset".tr),
                  const SizedBox(
                    height: 25,
                  ),
                  Form(
                    key: forgotPasswordController.emailFormKey,
                    child: Column(
                      children: [
                        GetBuilder<ForgotPasswordController>(
                            builder: (context) {
                          return TextFormField(
                            textInputAction: TextInputAction.done,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "enterAnEmail".tr;
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(val)) {
                                return "enterValidEmail".tr;
                              }

                              return null;
                            },
                            onChanged: (emailAddress) {
                              forgotPasswordController
                                  .inputfgbEmail(emailAddress);
                            },
                            decoration: InputDecoration(
                                prefixIcon: const EmailIcon(),

                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: orangeColor, width: 2.0),
                                //     borderRadius: BorderRadius.all(
                                //         Radius.circular(15))),

                                hintText: 'Email',
                                errorText: forgotPasswordController.someError
                                    ? "emailNotFound".tr
                                    : null),
                          );
                        }),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                            onPressed: () {
                              if (forgotPasswordController
                                  .emailFormKey.currentState!
                                  .validate()) {
                                forgotPasswordController
                                    .emailFormKey.currentState!
                                    .save();
                                forgotPasswordController.sendEmail();
                              }
                            },
                            child: Text("sendEmail".tr)),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: screenHeight * 0.025,
                  // ),
                  // const LogoStartEase(),
                  // SizedBox(
                  //   height: screenHeight * 0.03,
                  // ),
                  SmallBodyText(
                    text: "resetPasswordEmail".tr,
                  ),
                  Text(forgotPasswordController.fgpEmail.toString()),
                  const SizedBox(
                    height: 25,
                  ),
                  Form(
                    key: forgotPasswordController.codePINFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "enterCodePIN".tr;
                            }
                            if (val.length < 6) {
                              return "enterCodePIN".tr;
                            }

                            return null;
                          },
                          onChanged: (inputcodePIN) {
                            forgotPasswordController.inputCodePIN(inputcodePIN);
                          },
                          decoration: InputDecoration(
                              suffixIcon: const ImageIcon(
                                Svg("assets/icons/touch_id_icon.svg"),
                              ),
                              hintText: 'Code',
                              errorText: forgotPasswordController.someError
                                  ? "invalidCode".tr
                                  : null),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                            onPressed: () {
                              if (forgotPasswordController
                                  .codePINFormKey.currentState!
                                  .validate()) {
                                forgotPasswordController
                                    .codePINFormKey.currentState!
                                    .save();
                                forgotPasswordController.verifyCode();
                              }
                            },
                            child: Text("verifyCode".tr)),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                    const BorderSide(color: bluePurpleColor)),
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        bluePurpleColor.withOpacity(0.2)),
                                backgroundColor: MaterialStateProperty.all(
                                    transparentColor)),
                            onPressed: () {},
                            child: Text(
                              "resendSecretCodeEmail".tr,
                              style: const TextStyle(
                                color: bluePurpleColor,
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                    const BorderSide(color: bluePurpleColor)),
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        bluePurpleColor.withOpacity(0.2)),
                                backgroundColor: MaterialStateProperty.all(
                                    transparentColor)),
                            onPressed: () {
                              forgotPasswordController.changeEmail();
                            },
                            child: Text(
                              "changeEmail".tr,
                              style: const TextStyle(color: bluePurpleColor),
                            )),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TitleLargeText(text: "resetPassword".tr),
                  const SizedBox(
                    height: 15,
                  ),
                  SmallBodyText(text: "enterNewPassword".tr),
                  const SizedBox(
                    height: 25,
                  ),
                  Form(
                    key: forgotPasswordController.passwordFormKey,
                    child: Column(
                      children: [
                        GetBuilder<ForgotPasswordController>(builder: (cntx) {
                          return TextFormField(
                            obscureText:
                                forgotPasswordController.securedPassword,
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
                              forgotPasswordController
                                  .inputnewPassword(password);
                            },
                            decoration: InputDecoration(
                              prefixIcon: const PasswordKeyIcon(),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    forgotPasswordController
                                        .invertSecuredPassword();
                                  },
                                  icon: forgotPasswordController.securedPassword
                                      ? const Icon(
                                          Icons.visibility_off_outlined)
                                      : const Icon(Icons.visibility_outlined)),
                              hintText: 'newPassword'.tr,
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 15,
                        ),
                        GetBuilder<ForgotPasswordController>(builder: (cntx) {
                          return TextFormField(
                            obscureText:
                                forgotPasswordController.securedPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "enterPassword".tr;
                              }
                              if (value !=
                                  forgotPasswordController.newPassword) {
                                return "passwordsNoMatch".tr;
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const PasswordKeyIcon(),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    forgotPasswordController
                                        .invertSecuredPassword();
                                  },
                                  icon: forgotPasswordController.securedPassword
                                      ? const Icon(
                                          Icons.visibility_off_outlined)
                                      : const Icon(Icons.visibility_outlined)),
                              hintText: 'newPassword'.tr,
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                            onPressed: () {
                              if (forgotPasswordController
                                  .passwordFormKey.currentState!
                                  .validate()) {
                                forgotPasswordController
                                    .passwordFormKey.currentState!
                                    .save();
                                forgotPasswordController.resetPassword();
                              }
                            },
                            child: Text("resetPassword".tr)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
