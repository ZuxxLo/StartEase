import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../Themes/colors.dart';
import '../controller/sign_up_controller.dart';
import '../services/languages.dart';
import 'widgets.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.find();

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackIconButton(),
        title: Text("registration".tr),
        bottom: PreferredSize(
            preferredSize: const Size(20, 20),
            child: Center(
              child: GetBuilder<SignUpController>(builder: (context) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: const Divider(
                          color: Colors.grey,
                          thickness: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int step in signUpController.steps)
                            Container(
                              alignment: Alignment.center,
                              height:
                                  step <= signUpController.currentStepIndex + 1
                                      ? 26.0
                                      : 26.0,
                              width:
                                  step <= signUpController.currentStepIndex + 1
                                      ? 26.0
                                      : 26.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: step <=
                                        signUpController.currentStepIndex + 1
                                    ? bluePurpleColor
                                    : Colors.grey,
                              ),
                              child: Text(
                                step.toString(),
                                style: const TextStyle(
                                    fontSize: 15, color: whiteColor),
                              ),
                            )
                        ],
                      )
                    ],
                  ),
                );
              }),
            )),
        actions: const [
          SizedBox(height: 40, width: 40, child: LogoStartEase()),
          SizedBox(
            width: 10,
          )
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: signUpController.pageController,
          children: [
            Form(
                key: signUpController.formKey1,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SmallBodyText(text: "userName".tr),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: signUpController.userName,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_pin_outlined),
                        hintText: signUpController.userName ?? "userName".tr,
                      ),
                      validator: (value) {
                        if (signUpController.userName != null) {
                          value = signUpController.userName;
                        }
                        if (value!.length < 3) {
                          return "usernameValidator".tr;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        signUpController.inputUserName(value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    /////
                    SmallBodyText(text: "email".tr),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: signUpController.email,
                      decoration: InputDecoration(
                        prefixIcon: const EmailIcon(),
                        hintText: signUpController.email ?? "email".tr,
                      ),
                      validator: signUpController.emailValidator,
                      onChanged: (value) {
                        signUpController.inputEmail(value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ), /////
                    SmallBodyText(text: "firstName".tr),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: signUpController.firstName,
                      decoration: InputDecoration(
                        prefixIcon:
                            const ImageIcon(Svg("assets/icons/profile.svg")),
                        hintText: signUpController.firstName ?? "firstName".tr,
                      ),
                      validator: (value) {
                        if (signUpController.firstName != null) {
                          value = signUpController.firstName;
                        }
                        if (value!.length < 3) {
                          return "field3c".tr;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        signUpController.inputFirstName(value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ), /////
                    SmallBodyText(text: "lastName".tr),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: signUpController.lastName,
                      decoration: InputDecoration(
                        prefixIcon:
                            const ImageIcon(Svg("assets/icons/profile.svg")),
                        hintText: signUpController.lastName ?? "lastName".tr,
                      ),
                      validator: (value) {
                        if (signUpController.lastName != null) {
                          value = signUpController.lastName;
                        }
                        if (value!.length < 3) {
                          return "field3c".tr;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        signUpController.inputLastName(value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ), /////
                    SmallBodyText(text: "birthplace".tr),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: signUpController.birthplace,
                      decoration: InputDecoration(
                        prefixIcon: const ImageIcon(
                          Svg("assets/icons/location_icon.svg"),
                        ),
                        hintText:
                            signUpController.birthplace ?? "birthplace".tr,
                      ),
                      validator: (value) {
                        if (signUpController.birthplace != null) {
                          value = signUpController.birthplace;
                        }
                        if (value!.isEmpty) {
                          return "enterBirthplace".tr;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        signUpController.inputBirthplace(value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ), /////
                    SmallBodyText(text: "Birthday".tr),
                    const SizedBox(
                      height: 5,
                    ),
                    GetBuilder<SignUpController>(builder: (ctx) {
                      return TextFormField(
                        textInputAction: TextInputAction.next,
                        initialValue: signUpController.birthday,
                        decoration: InputDecoration(
                          prefixIcon: const ImageIcon(
                            Svg("assets/icons/calendar_icon.svg"),
                          ),
                          hintText: signUpController.birthday ?? "yyyy/mm/dd",
                        ),
                        validator: (value) {
                          if (signUpController.birthday != null) {
                            value = signUpController.birthday;
                          }
                          if (value!.isEmpty) {
                            return "enterBirthday".tr;
                          }
                          return null;
                        },
                        readOnly: true,
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.utc(1940),
                              lastDate: DateTime.now(),
                              helpText: "",
                              locale: Languages.initLang(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    textButtonTheme:
                                        const TextButtonThemeData(),
                                  ),
                                  child: child!,
                                );
                              }).then((value) {
                            if (value != null) {
                              signUpController.inputBirthday(value);
                            }
                          });
                        },
                      );
                    }),
                    const SizedBox(
                      height: 15,
                    ),

                    TextButton(
                        onPressed: () {
                          if (signUpController.formKey1.currentState!
                              .validate()) {
                            signUpController.formKey1.currentState!.save();
                            signUpController.next();
                          }
                        },
                        child: Text("createRole5".tr)),
                    const SizedBox(height: 10),
                  ],
                )),
            Form(
                key: signUpController.formKey2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /////
                    SmallBodyText(text: "phoneNumber".tr),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      initialValue: signUpController.phoneNumber,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: const ImageIcon(
                          Svg("assets/icons/phonenumber_icon.svg"),
                        ),
                        suffixIcon: TextButton(
                          onPressed: () {
                            signUpController.sendSMSVerification();
                          },
                          style: ButtonStyle(
                              fixedSize:
                                  MaterialStateProperty.all(const Size(0, 0)),
                              foregroundColor:
                                  MaterialStateProperty.all(bluePurpleColor),
                              backgroundColor:
                                  MaterialStateProperty.all(transparentColor)),
                          child: Text("send".tr),
                        ),
                        hintText:
                            signUpController.phoneNumber ?? "phoneNumber".tr,
                      ),
                      maxLength: 10,
                      validator: (value) {
                        if (signUpController.phoneNumber != null) {
                          value = signUpController.phoneNumber;
                        }
                        if (!RegExp(r'(^[0-9]{10}$)').hasMatch(value ?? '')) {
                          return "enterValidPhoneNumber".tr;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        signUpController.inputPhoneNumber(value);
                      },
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SmallBodyText(text: "enterSMS".tr)),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      enabled: signUpController.smsEnabled,
                      onChanged: (input) {},
                      decoration: const InputDecoration(
                        prefixIcon:
                            ImageIcon(Svg("assets/icons/touch_id_icon.svg")),
                        hintText: "SMS",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    TextButton(
                        onPressed: () {
                          signUpController.formKey2.currentState!.save();
                          signUpController.next();
                        },
                        child: Text("createRole5".tr)),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(
                                const BorderSide(color: bluePurpleColor)),
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => bluePurpleColor.withOpacity(0.2)),
                            backgroundColor:
                                MaterialStateProperty.all(transparentColor)),
                        onPressed: () {
                          signUpController.goBackPageView();
                        },
                        child: Text(
                          "goBack".tr,
                          style: const TextStyle(color: bluePurpleColor),
                        )),
                  ],
                )),
            Form(
                key: signUpController.formKey3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallBodyText(text: "password".tr),
                    const SizedBox(
                      height: 5,
                    ),
                    GetBuilder<SignUpController>(builder: (cntx) {
                      return TextFormField(
                        textInputAction: TextInputAction.next,
                        obscureText: signUpController.securedPassword,
                        validator: (value) {
                          if (signUpController.password != null) {
                            value = signUpController.password;
                          }
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
                          signUpController.inputPassword(password);
                        },
                        decoration: InputDecoration(
                          prefixIcon: const PasswordKeyIcon(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                signUpController.invertSecuredPassword();
                              },
                              icon: signUpController.securedPassword
                                  ? const Icon(Icons.visibility_off_outlined)
                                  : const Icon(Icons.visibility_outlined)),
                          hintText: "password".tr,
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    GetBuilder<SignUpController>(builder: (cntx) {
                      return TextFormField(
                        obscureText: signUpController.securedPassword,
                        validator: (value) {
                          if (signUpController.password != null) {
                            value = signUpController.password;
                          }
                          if (value!.isEmpty) {
                            return "enterPassword".tr;
                          }
                          if (value != signUpController.password) {
                            return "passwordsNoMatch".tr;
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const PasswordKeyIcon(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                signUpController.invertSecuredPassword();
                              },
                              icon: signUpController.securedPassword
                                  ? const Icon(Icons.visibility_off_outlined)
                                  : const Icon(Icons.visibility_outlined)),
                          hintText: "password".tr,
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: () {
                          if (signUpController.formKey3.currentState!
                              .validate()) {
                            signUpController.formKey3.currentState!.save();
                            signUpController.signUp();
                          }
                        },
                        child: Text("submit".tr)),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(
                                const BorderSide(color: bluePurpleColor)),
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => bluePurpleColor.withOpacity(0.2)),
                            backgroundColor:
                                MaterialStateProperty.all(transparentColor)),
                        onPressed: () {
                          signUpController.goBackPageView();
                        },
                        child: Text(
                          "goBack".tr,
                          style: const TextStyle(color: bluePurpleColor),
                        )),
                  ],
                )),
            // Column(
            //   children: [
            //     const SizedBox(
            //       height: 50,
            //     ),
            //     TextButton.icon(
            //         onPressed: () {
            //           signUpController.uploadPicture();
            //         },
            //         icon: const Icon(Icons.add_a_photo_outlined),
            //         label: Text("add a photo")),
            //     const SizedBox(
            //       height: 10,
            //     ),
            //     TextButton(
            //         style: ButtonStyle(
            //             side: MaterialStateProperty.all(
            //                 const BorderSide(color: bluePurpleColor)),
            //             overlayColor: MaterialStateColor.resolveWith(
            //                 (states) => bluePurpleColor.withOpacity(0.2)),
            //             backgroundColor:
            //                 MaterialStateProperty.all(transparentColor)),
            //         onPressed: () {
            //           signUpController.goBackPageView();
            //         },
            //         child: Text(
            //           "goBack".tr,
            //           style: const TextStyle(color: bluePurpleColor),
            //         )),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
