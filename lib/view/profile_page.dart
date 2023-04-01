import 'package:flutter/material.dart';
import 'package:get/get.dart';
 

import '../Themes/colors.dart';
import '../controller/profile_page_controller.dart';
import '../main.dart';
import 'widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final ProfilePageController profilePageController = Get.find();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: transparentColor,
            leading: const BackButton(
              color: purpleColor,
            )),
        body: GetBuilder<ProfilePageController>(
          builder: (context) {
            if (profilePageController.isInternetConnected ) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: screenHeight * 0.16,
                        width: double.maxFinite,
                        child: Card(
                          color: purpleColor,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Row(children: [
                              Container(
                                margin: const EdgeInsets.only(right: 5),
                                height: screenHeight * 0.13,
                                width: screenHeight * 0.13,
                                child: CircleAvatar(
                                  radius: 90,
                                  backgroundImage:
                                      NetworkImage(userModel.getUserImageURL),
                                  onBackgroundImageError:
                                      (exception, stackTrace) {
                                    print('error');
                                  },
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TitleMediumText(
                                              text: userModel.getUserFirstName +
                                                  " " +
                                                  userModel.getUserLastName),
                                          TitleSmallText(
                                              text: "@" +
                                                  userModel.getuserUserName)
                                        ],
                                      ))),
                              IconButton(
                                  onPressed: () {},
                                  icon: const EditPencilIcon()),
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ///////////////////
                      ///
                      ///
                      ///
                      Card(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  ...ListTile.divideTiles(
                                    color: purpleColor,
                                    tiles: [
                                      ListTile(
                                          leading: const ListTileIcons(
                                              iconName: "email_icon"),
                                          title:
                                              TitleSmallText(text: "email".tr),
                                          subtitle: SmallBodyText(
                                              text: userModel.getUserEmail)),
                                      ListTile(
                                          leading: const ListTileIcons(
                                              iconName: "phonenumber_icon"),
                                          title: TitleSmallText(
                                              text: "phoneNumber".tr),
                                          subtitle: SmallBodyText(
                                              text: userModel
                                                  .getuserPhoneNumber)),
                                      ListTile(
                                          leading: const ListTileIcons(
                                              iconName: "birthday_icon"),
                                          title: TitleSmallText(
                                              text: "birthday".tr),
                                          subtitle: SmallBodyText(
                                              text: userModel.getUserBirthday)),
                                      ListTile(
                                        leading: const ListTileIcons(
                                            iconName: "birthplace_icon"),
                                        title: TitleSmallText(
                                            text: "birthplace".tr),
                                        subtitle: SmallBodyText(
                                            text: userModel.getBirthplace),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )

                      ///
                    ],
                  ),
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

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: screenHeight * 0.16,
              width: double.maxFinite,
              child: Card(
                color: purpleColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(children: [
                    SizedBox(
                      height: screenHeight * 0.13,
                      width: screenHeight * 0.13,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(userModel.getUserImageURL),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TitleMediumText(
                                    text: userModel.getUserFirstName +
                                        " " +
                                        userModel.getUserLastName),
                                TitleSmallText(
                                    text: "@" + userModel.getuserUserName)
                              ],
                            ))),
                    IconButton(onPressed: () {}, icon: const EditPencilIcon()),
                  ]),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ///////////////////
            ///
            ///
            ///
            Card(
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        ...ListTile.divideTiles(
                          color: purpleColor,
                          tiles: [
                            ListTile(
                                leading:
                                    const ListTileIcons(iconName: "email_icon"),
                                title: TitleSmallText(text: "email".tr),
                                subtitle: SmallBodyText(
                                    text: userModel.getUserEmail)),
                            ListTile(
                                leading: const ListTileIcons(
                                    iconName: "phonenumber_icon"),
                                title: TitleSmallText(text: "phoneNumber".tr),
                                subtitle: SmallBodyText(
                                    text: userModel.getuserPhoneNumber)),
                            ListTile(
                                leading: const ListTileIcons(
                                    iconName: "birthday_icon"),
                                title: TitleSmallText(text: "birthday".tr),
                                subtitle: SmallBodyText(
                                    text: userModel.getUserBirthday)),
                            ListTile(
                              leading: const ListTileIcons(
                                  iconName: "birthplace_icon"),
                              title: TitleSmallText(text: "birthplace".tr),
                              subtitle:
                                  SmallBodyText(text: userModel.getBirthplace),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )

            ///
          ],
        ),
      ),
    );
  }
}

class ProfilePageNoConnection extends StatelessWidget {
  const ProfilePageNoConnection({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfilePageController profilePageController = Get.find();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (profilePageController.isInternetConnected ) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: screenHeight * 0.16,
                width: double.maxFinite,
                child: Card(
                  color: purpleColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(children: [
                      SizedBox(
                        height: screenHeight * 0.13,
                        width: screenHeight * 0.13,
                        child: const CircleAvatar(
                          backgroundColor: bluePurpleColor,
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  TitleMediumText(text: " "),
                                  TitleSmallText(text: "@")
                                ],
                              ))),
                      IconButton(
                          onPressed: () {}, icon: const EditPencilIcon()),
                    ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ///////////////////
              ///
              ///
              ///
              Card(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ...ListTile.divideTiles(
                            color: purpleColor,
                            tiles: [
                              ListTile(
                                leading:
                                    const ListTileIcons(iconName: "email_icon"),
                                title: TitleSmallText(text: "email".tr),
                              ),
                              ListTile(
                                leading: const ListTileIcons(
                                    iconName: "phonenumber_icon"),
                                title: TitleSmallText(text: "phoneNumber".tr),
                              ),
                              ListTile(
                                leading: const ListTileIcons(
                                    iconName: "birthday_icon"),
                                title: TitleSmallText(text: "birthday".tr),
                              ),
                              ListTile(
                                leading: const ListTileIcons(
                                    iconName: "birthplace_icon"),
                                title: TitleSmallText(text: "birthplace".tr),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )

              ///
            ],
          ),
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
