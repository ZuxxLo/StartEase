import 'package:flutter/material.dart';
import 'package:get/get.dart';
 

import '../Themes/colors.dart';
import '../controller/forgot_password.dart';
import 'widgets.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController forgotPasswordController = Get.find();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor:transparentColor,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const Align(
              alignment: Alignment.topCenter, child: BackgroundImageBlurred()),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: screenHeight / 1.35,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: forgotPasswordController.pageController,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const LogoTakharouji(),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "reset".tr,
                                  style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .fontSize,
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color)),
                              TextSpan(
                                  text: " ",
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .fontSize,
                                  )),
                              TextSpan(
                                  text: "password".tr,
                                  style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .fontSize,
                                      color: purpleColor)),
                            ])),
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                              SmallBodyText(text: "forgotYourPassword?".tr),
                              SmallBodyText(text: "weWillSendUReset".tr),
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Form(
                                key: forgotPasswordController.emailFormKey,
                                child: Column(
                                  children: [
                                    TextFormField(
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
                                      decoration: const InputDecoration(
                                        suffixIcon: AtIcon(),

                                        // focusedBorder: OutlineInputBorder(
                                        //     borderSide: BorderSide(
                                        //         color: orangeColor, width: 2.0),
                                        //     borderRadius: BorderRadius.all(
                                        //         Radius.circular(15))),

                                        hintText: 'Email',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.03,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          if (forgotPasswordController
                                              .emailFormKey.currentState!
                                              .validate()) {
                                            forgotPasswordController
                                                .sendEmail();
                                          }
                                        },
                                        child: Text("sendEmail".tr)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const LogoTakharouji(),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "reset".tr,
                                  style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .fontSize,
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color)),
                              TextSpan(
                                  text: " ",
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .fontSize,
                                  )),
                              TextSpan(
                                  text: "password".tr,
                                  style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .fontSize,
                                      color: purpleColor)),
                            ])),
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            SmallBodyText(
                              text: "resetPasswordEmail".tr,
                            ),
                            Text(forgotPasswordController.fgpEmail.toString()),
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Form(
                                key: forgotPasswordController.codePINFormKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      maxLength: 8,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "enterCodePIN".tr;
                                        }

                                        return null;
                                      },
                                      onChanged: (inputcodePIN) {
                                        forgotPasswordController
                                            .inputCodePIN(inputcodePIN);
                                      },
                                      decoration: const InputDecoration(
                                        suffixIcon: ImageIcon(
                                          AssetImage(
                                              "assets/icons/touch_id_icon.png"),
                                        ),

                                        // focusedBorder: OutlineInputBorder(
                                        //     borderSide: BorderSide(
                                        //         color: orangeColor, width: 2.0),
                                        //     borderRadius: BorderRadius.all(
                                        //         Radius.circular(15))),

                                        hintText: 'Code PIN',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.03,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          if (forgotPasswordController
                                              .codePINFormKey.currentState!
                                              .validate()) {
                                            forgotPasswordController
                                                .verifyCode();
                                          }
                                        },
                                        child: Text("verifyCode".tr)),
                                    SizedBox(
                                      height: screenHeight * 0.012,
                                    ),
                                    TextButton(
                                        style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => purpleColor
                                                        .withOpacity(0.2)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    transparentColor)),
                                        onPressed: () {},
                                        child: Text(
                                          "resendSecretCodeEmail".tr,
                                          style: const TextStyle(
                                              color: purpleColor),
                                        )),
                                    TextButton(
                                        style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => purpleColor
                                                        .withOpacity(0.2)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    transparentColor)),
                                        onPressed: () {
                                          forgotPasswordController
                                              .changeEmail();
                                        },
                                        child: Text(
                                          "changeEmail".tr,
                                          style: const TextStyle(
                                              color: purpleColor),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              SmallBodyText(text: "enterNewPassword".tr),
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Form(
                                key: forgotPasswordController.passwordFormKey,
                                child: Column(
                                  children: [
                                    GetBuilder<ForgotPasswordController>(
                                        builder: (cntx) {
                                      return TextFormField(
                                        obscureText: forgotPasswordController
                                            .securedPassword,
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
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                forgotPasswordController
                                                    .invertSecuredPassword();
                                              },
                                              icon: forgotPasswordController
                                                      .securedPassword
                                                  ? const Icon(
                                                      Icons.visibility_off)
                                                  : const Icon(
                                                      Icons.visibility)),
                                          hintText: 'Password',
                                        ),
                                      );
                                    }),
                                    SizedBox(
                                      height: screenHeight * 0.013,
                                    ),
                                    GetBuilder<ForgotPasswordController>(
                                        builder: (cntx) {
                                      return TextFormField(
                                        obscureText: forgotPasswordController
                                            .securedPassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "enterPassword".tr;
                                          }
                                          if (value !=
                                              forgotPasswordController
                                                  .newPassword) {
                                            return "passwordsNoMatch".tr;
                                          }

                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                forgotPasswordController
                                                    .invertSecuredPassword();
                                              },
                                              icon: forgotPasswordController
                                                      .securedPassword
                                                  ? const Icon(
                                                      Icons.visibility_off)
                                                  : const Icon(
                                                      Icons.visibility)),
                                          hintText: 'Password',
                                        ),
                                      );
                                    }),
                                    SizedBox(
                                      height: screenHeight * 0.03,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          if (forgotPasswordController
                                              .passwordFormKey.currentState!
                                              .validate()) {
                                            forgotPasswordController
                                                .resetPassword();
                                          }
                                        },
                                        child: Text(
                                            "${"reset".tr} ${"password".tr}")),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
