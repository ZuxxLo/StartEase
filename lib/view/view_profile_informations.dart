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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackIconButton(),
          title: TabBar(
              indicatorPadding: const EdgeInsets.only(bottom: 2),
              indicatorColor: bluePurpleColor,
              labelColor: Theme.of(context).primaryColorLight,
              tabs: [
                Tab(
                  text: "informations".tr,
                ),
                Tab(
                  text: "roles".tr,
                )
              ]),
        ),
        body: GetBuilder<ProfilePageController>(
          builder: (ctx) {
            if (profilePageController.isInternetConnected) {
              return TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // ignore: prefer_const_constructors
                            GetBuilder<ProfilePageController>(
                                builder: (context) {
                              return const ProfilePicture();
                            }),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: IconButton(
                                onPressed: () {
                                  profilePageController.uploadPicture();
                                },
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
                        // TitleMediumText(
                        //     text: "${userModel.firstName} ${userModel.lastName}"),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: UserNameText(text: "PersonalInformation".tr),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: profilePageController.formKey,
                          child: Column(
                            children: [
                              //Username
                              TextFormField(
                                readOnly: true,
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

                              // //birthplace
                              // TextFormField(
                              //   enabled: false,
                              //   decoration: InputDecoration(
                              //     prefixIcon: const ImageIcon(
                              //       Svg("assets/icons/location_icon.svg"),
                              //     ),
                              //     hintText: userModel.birthPlace,
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              //email
                              TextFormField(
                                readOnly: true,
                                initialValue: userModel.email,
                                decoration: const InputDecoration(
                                  prefixIcon: EmailIcon(),
                                ),
                              ),
                              //firstName
                              userModel.person?.firstName == null
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          readOnly: true,
                                          initialValue:
                                              userModel.person?.firstName,
                                          decoration: const InputDecoration(
                                            prefixIcon: ImageIcon(
                                              Svg("assets/icons/profile.svg"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              //lastname
                              userModel.person?.lastName == null
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          readOnly: true,
                                          initialValue:
                                              userModel.person?.lastName,
                                          decoration: const InputDecoration(
                                            prefixIcon: ImageIcon(
                                              Svg("assets/icons/profile.svg"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              //personType
                              userModel.personType == null
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          readOnly: true,
                                          initialValue: userModel.personType,
                                          decoration: const InputDecoration(
                                            prefixIcon: ImageIcon(
                                              Svg("assets/icons/profile.svg"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              //establishment
                              userModel.person?.establishment?.name == null
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          readOnly: true,
                                          initialValue: userModel
                                              .person?.establishment?.name,
                                          decoration: const InputDecoration(
                                            prefixIcon: ImageIcon(
                                              Svg("assets/icons/location_icon.svg"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              //grade
                              userModel.person?.grade?.name == null
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          readOnly: true,
                                          initialValue:
                                              userModel.person?.grade?.name,
                                          decoration: const InputDecoration(
                                            prefixIcon: ImageIcon(
                                              Svg("assets/icons/location_icon.svg"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              //filiere
                              userModel.person?.filiere?.name == null
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          readOnly: true,
                                          initialValue:
                                              userModel.person?.filiere?.name,
                                          decoration: const InputDecoration(
                                            prefixIcon: ImageIcon(
                                              Svg("assets/icons/location_icon.svg"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              //birthday
                              userModel.person?.birthday == null
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          readOnly: true,
                                          initialValue:
                                              userModel.person?.birthday,
                                          decoration: const InputDecoration(
                                            prefixIcon: ImageIcon(
                                              Svg("assets/icons/location_icon.svg"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              //birthplace
                              userModel.person?.birthPlace == null
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          readOnly: true,
                                          initialValue:
                                              userModel.person?.birthPlace,
                                          decoration: const InputDecoration(
                                            prefixIcon: ImageIcon(
                                              Svg("assets/icons/calendar_icon.svg"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        // TextButton(
                        //   onPressed: () {
                        //     if (profilePageController.formKey.currentState!
                        //         .validate()) {
                        //       profilePageController.formKey.currentState!
                        //           .save();
                        //       profilePageController.confirm();
                        //     }
                        //   },
                        //   child: Text(
                        //     "confirm".tr,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  ListView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      userModel.roles!.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: userModel.roles!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 70,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .listTileTheme
                                          .tileColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(userModel.roles![index].name
                                            .toString()),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(
                                  thickness: 1,
                                );
                              },
                            )
                          : Center(child: Text("noRoles".tr)),
                    ],
                  ),
                ],
              );
            } else {
              profilePageController.getBoolisInternetConnected();
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
