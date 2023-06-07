import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Themes/colors.dart';
import '../controller/login_controller.dart';
import 'widgets.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoStartEaseWithText(),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: loginController.formKey,
                  child: Column(
                    children: [
                      GetBuilder<LoginController>(builder: (context) {
                        return TextFormField(
                          textInputAction: TextInputAction.next,
                          validator: loginController.emailValidator,
                          onChanged: (emailAddress) {
                            loginController.setUserEmail(emailAddress.trim());
                          },
                          decoration: InputDecoration(
                              prefixIcon: const EmailIcon(),
                              hintText: 'Email',
                              errorText: (loginController.loginError)
                                  ? "invalidEmailOrPassword".tr
                                  : null),
                        );
                      }),
                      SizedBox(
                        height: screenHeight * 0.013,
                      ),
                      GetBuilder<LoginController>(builder: (cntx) {
                        return TextFormField(
                          obscureText: loginController.securedPassword,
                          validator: loginController.passwordValidator,
                          onChanged: (password) {
                            loginController.setUserPassword(password);
                          },
                          decoration: InputDecoration(
                              prefixIcon: const PasswordKeyIcon(),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    loginController.invertSecuredPassword();
                                  },
                                  icon: loginController.securedPassword
                                      ? const Icon(
                                          Icons.visibility_off_outlined)
                                      : const Icon(Icons.visibility_outlined)),
                              hintText: 'password'.tr,
                              errorText: (loginController.loginError)
                                  ? "invalidEmailOrPassword".tr
                                  : null),
                        );
                      }),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
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
                      const SizedBox(
                        height: 25,
                      ),
                      TextButton(
                        onPressed: () {
                          if (loginController.formKey.currentState!
                              .validate()) {
                            loginController.formKey.currentState!.save();
                            loginController.signInAUser();
                          }
                        },
                        child: Text(
                          "login".tr,
                        ),
                      ),
                      // const SizedBox(height: 20),
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: InkWell(
                      //     child: Text(
                      //       "createAccount".tr,
                      //       style: TextStyle(
                      //         color: bluePurpleColor,
                      //         fontSize: screenWidth * 0.04,
                      //       ),
                      //     ),
                      //     onTap: () {
                      //      Get.toNamed("/SignUp");
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
