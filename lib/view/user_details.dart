import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/view/widgets.dart';
 
import '../backend/link_api.dart';
import '../controller/users_management_controller.dart';
import '../main.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final UsersManagementController usersManagementController = Get.find();
    double screenHeight = MediaQuery.of(context).size.height;
     return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackIconButton(),
          title: TabBar(
              indicatorPadding: const EdgeInsets.only(bottom: 2),
              indicatorColor: purpleColor,
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
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 120,
                      width: 120,
                      child: !(usersManagementController
                                  .userDetails!.photoUrl ==
                              "https://via.placeholder.com/640x480.png/002277?text=architecto")
                          ? ClipOval(
                              child: Image.network(
                              linkServerName +
                                  usersManagementController
                                      .userDetails!.photoUrl!
                                      .substring(21),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const CircularProgressIndicator();
                              },
                            ))
                          : ClipOval(
                              child: Container(
                                alignment: Alignment.center,
                                color: MainFunctions.generatePresizedColor(
                                    usersManagementController
                                        .userDetails!.username.length),
                                child: Text(
                                  usersManagementController
                                      .userDetails!.firstName[0]
                                      .toUpperCase(),
                                  // style: const TextStyle(
                                  //     fontSize: 27, color: purpleTextColor),
                                ),
                              ),
                            )),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleMediumText(
                      text:
                          "${usersManagementController.userDetails?.firstName} ${usersManagementController.userDetails?.lastName}"),
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
                  Column(
                    children: [
                      //Username
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.perm_contact_cal_sharp),
                          hintText:
                              usersManagementController.userDetails?.username,
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
                          hintText:
                              usersManagementController.userDetails?.birthday,
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
                          hintText:
                              usersManagementController.userDetails?.birthPlace,
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
                          hintText:
                              usersManagementController.userDetails?.email,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //phone number
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: const ImageIcon(
                            Svg("assets/icons/phonenumber_icon.svg"),
                          ),
                          hintText: usersManagementController
                              .userDetails?.phoneNumber,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),

                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            usersManagementController.userDetails?.isEnabled ==
                                    1
                                ? redColor
                                : bluePurpleColor)),
                    onPressed: () {
                      usersManagementController.enableDisable();
                    },
                    child: GetBuilder<UsersManagementController>(
                        builder: (context) {
                      return Text(
                          usersManagementController.userDetails?.isEnabled == 0
                              ? "enable".tr
                              : "disable".tr);
                    }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight - 200,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: usersManagementController.allRolesList!.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(usersManagementController
                                    .allRolesList![index].name
                                    .toString()),
                              ),
                              GetBuilder<UsersManagementController>(
                                  builder: (context) {
                                return CupertinoSwitch(
                                  value: usersManagementController
                                      .allRolesList![index].value!,
                                  onChanged: ((value) {
                                    usersManagementController.changeRoleValue(
                                        index, value);
                                  }),
                                  thumbColor: usersManagementController
                                          .allRolesList![index].value!
                                      ? purpleColor
                                      : greyColor,
                                  activeColor: purpleColor.withOpacity(0.5),
                                );
                              })
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 1,
                        );
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      usersManagementController.confirm();
                    },
                    child: GetBuilder<UsersManagementController>(
                        builder: (context) {
                      return Text("confirm".tr);
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
