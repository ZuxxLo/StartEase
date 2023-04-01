import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
 
import '../Themes/colors.dart';
import '../controller/login_controller.dart';
import 'widgets.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const Align(
              alignment: Alignment.topCenter, child: BackgroundImageBlurred()),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: screenHeight / 1.2,
              child: Column(
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
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.025,
                        ),
                        const LogoTakharouji(),
                        Image.asset(
                          "assets/images/takharouji_text.png",
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: loginController.formKey,
                            child: Column(
                              children: [
                                 GetBuilder<LoginController>(
                                  builder: (context) {
                                    return TextFormField(
                                      textInputAction: TextInputAction.next,
                                      validator: loginController.emailValidator,
                                      onChanged: (emailAddress) {
                                        loginController
                                            .setUserEmail(emailAddress.trim());
                                      },
                                      decoration: InputDecoration(
                                          suffixIcon: AtIcon(),

                                          // focusedBorder: OutlineInputBorder(
                                          //     borderSide: BorderSide(
                                          //         color: orangeColor, width: 2.0),
                                          //     borderRadius: BorderRadius.all(
                                          //         Radius.circular(15))),

                                          hintText: 'Email',
                                          labelText: "Email",
                                          errorText: (loginController.loginError)
                                              ? "invalidEmailOrPassword".tr
                                              : null),
                                    );
                                  }
                                ),
                                SizedBox(
                                  height: screenHeight * 0.013,
                                ),
                                GetBuilder<LoginController>(builder: (cntx) {
                                  return TextFormField(
                                    obscureText:
                                        loginController.securedPassword,
                                    validator:
                                        loginController.passwordValidator,
                                    onChanged: (password) {
                                      loginController.setUserPassword(password);
                                    },
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              loginController
                                                  .invertSecuredPassword();
                                            },
                                            icon: loginController
                                                    .securedPassword
                                                ? const Icon(
                                                    Icons.visibility_off)
                                                : const Icon(Icons.visibility)),
                                        // focusedBorder: const OutlineInputBorder(
                                        //     borderSide: BorderSide(
                                        //         color: orangeColor, width: 2.0),
                                        //     borderRadius: BorderRadius.all(
                                        //         Radius.circular(15))),
                                        hintText: 'password'.tr,
                                        labelText: 'password'.tr,
                                        errorText: (loginController.loginError)
                                            ? "invalidEmailOrPassword".tr
                                            : null),
                                  );
                                }),
                                SizedBox(
                                  height: screenHeight * 0.025,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    child: Text(
                                      "forgotYourPassword?".tr,
                                      style: TextStyle(
                                        color: bluePurpleColor,
                                        fontSize: screenWidth * 0.04,
                                      ),
                                    ),
                                    onTap: () {
                                      loginController.getToForgetPasswrodPage();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.025,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (loginController.formKey.currentState!
                                        .validate()) {
                                      loginController.formKey.currentState!
                                          .save();
                                      loginController.signInAUser();
                                    }
                                  },
                                  child: Text(
                                    "login".tr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
