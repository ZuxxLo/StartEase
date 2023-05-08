import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/view/widgets.dart';

import '../backend/link_api.dart';
import '../controller/users_management_controller.dart';
import '../main.dart';
import '../model/roles_model.dart';

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
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 120,
                      width: 120,
                      child: !(usersManagementController
                                  .userDetails!.photoUrl ==
                              "http://localhost:8000/images/users/default.png")
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
                                        .userDetails!.username!.length),
                                child: Text(
                                  usersManagementController
                                      .userDetails!.username![0]
                                      .toUpperCase(),
                                  // style: const TextStyle(
                                  //     fontSize: 27, color: purpleTextColor),
                                ),
                              ),
                            )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${usersManagementController.userDetails?.username}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize),
                  ),

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
                      //firstname
                      usersManagementController
                                  .userDetails?.person?.firstName ==
                              null
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 15),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    prefixIcon: const ImageIcon(
                                      Svg("assets/icons/profile.svg"),
                                    ),
                                    hintText: usersManagementController
                                        .userDetails?.person?.firstName,
                                  ),
                                ),
                              ],
                            ),
                      //lastname
                      usersManagementController.userDetails?.person?.lastName ==
                              null
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 15),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    prefixIcon: const ImageIcon(
                                      Svg("assets/icons/profile.svg"),
                                    ),
                                    hintText: usersManagementController
                                        .userDetails?.person?.lastName,
                                  ),
                                ),
                              ],
                            ),
                      //personType
                      usersManagementController.userDetails?.personType == null
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 15),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    prefixIcon: const ImageIcon(
                                      Svg("assets/icons/profile.svg"),
                                    ),
                                    hintText: usersManagementController
                                        .userDetails?.personType,
                                  ),
                                ),
                              ],
                            ),

                      //establishment
                      usersManagementController
                                  .userDetails?.person?.establishment?.name ==
                              null
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 15),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    prefixIcon: const ImageIcon(
                                      Svg("assets/icons/profile.svg"),
                                    ),
                                    hintText: usersManagementController
                                        .userDetails
                                        ?.person
                                        ?.establishment
                                        ?.name,
                                  ),
                                ),
                              ],
                            ),
                      //grade
                      usersManagementController
                                  .userDetails?.person?.grade?.name ==
                              null
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 15),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      prefixIcon: const ImageIcon(
                                        Svg("assets/icons/profile.svg"),
                                      ),
                                      hintText: usersManagementController
                                          .userDetails?.person?.grade?.name),
                                ),
                              ],
                            ),
                      //speciality
                      usersManagementController
                                  .userDetails?.person?.speciality?.name ==
                              null
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 15),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      prefixIcon: const ImageIcon(
                                        Svg("assets/icons/profile.svg"),
                                      ),
                                      hintText: usersManagementController
                                          .userDetails
                                          ?.person
                                          ?.speciality
                                          ?.name),
                                ),
                              ],
                            ),
                      //filliere
                      usersManagementController
                                  .userDetails?.person?.filiere?.name ==
                              null
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 15),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      prefixIcon: const ImageIcon(
                                        Svg("assets/icons/profile.svg"),
                                      ),
                                      hintText: usersManagementController
                                          .userDetails
                                          ?.person
                                          ?.filiere
                                          ?.name),
                                ),
                              ],
                            ),
                      //birthday
                      usersManagementController.userDetails?.person?.birthday ==
                              null
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 15),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    prefixIcon: const ImageIcon(
                                      Svg("assets/icons/calendar_icon.svg"),
                                    ),
                                    hintText: usersManagementController
                                        .userDetails?.person?.birthday,
                                  ),
                                ),
                              ],
                            ),

                      //birthplace
                      usersManagementController
                                  .userDetails?.person?.birthPlace ==
                              null
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 15),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    prefixIcon: const ImageIcon(
                                      Svg("assets/icons/location_icon.svg"),
                                    ),
                                    hintText: usersManagementController
                                        .userDetails?.person?.birthPlace,
                                  ),
                                ),
                              ],
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

                  GetBuilder<UsersManagementController>(builder: (context) {
                    return TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              usersManagementController
                                          .userDetails?.isEnabled ==
                                      1
                                  ? redColor
                                  : bluePurpleColor)),
                      onPressed: () {
                        usersManagementController.enableDisable();
                      },
                      child: Text(
                          usersManagementController.userDetails?.isEnabled == 0
                              ? "enable".tr
                              : "disable".tr),
                    );
                  }),
                ],
              ),
            ),
            ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<UsersManagementController>(builder: (context) {
                      return Text(
                        usersManagementController.searchTextRole == ""
                            ? ""
                            : "searching".tr +
                                usersManagementController.searchTextRole,
                        style: TextStyle(fontSize: 18),
                      );
                    }),
                    IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: "searchByFirstLastName".tr,
                              content: Column(
                                children: [
                                  TextFormField(
                                    onChanged: (inputSearch) {
                                      usersManagementController
                                          .searchTextInputRole(inputSearch);
                                    },
                                    decoration: InputDecoration(
                                        hintText: usersManagementController
                                                    .searchTextRole ==
                                                ""
                                            ? "searchByFirstLastName".tr
                                            : usersManagementController
                                                .searchTextRole),
                                  ),
                                  const SizedBox(height: 10),
                                  TextButton(
                                      onPressed: () {
                                        usersManagementController.searchRole(
                                            usersManagementController
                                                .searchTextRole);
                                        navigator!.pop();
                                      },
                                      child: Text("confirm".tr)),
                                  const SizedBox(height: 10),
                                  TextButton(
                                      onPressed: () {
                                        usersManagementController
                                            .searchTextInputRole("");
                                        usersManagementController
                                            .searchRole("");
                                        navigator!.pop();
                                      },
                                      child: Text("clear".tr))
                                ],
                              ));
                        },
                        icon: const ImageIcon(
                            Svg("assets/icons/search_icon.svg"))),
                  ],
                ),
                GetBuilder<UsersManagementController>(builder: (context) {
                  return usersManagementController.rolesListToAffich!.isNotEmpty
                      ? !usersManagementController.rolesListToAffich!
                              .contains(Roles(id: -77, name: "error77empty"))
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: usersManagementController
                                  .rolesListToAffich!.length,
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
                                        child: Text(usersManagementController
                                            .rolesListToAffich![index].name
                                            .toString()),
                                      ),
                                      CupertinoSwitch(
                                        value: usersManagementController
                                            .rolesListToAffich![index].value!,
                                        onChanged: ((value) {
                                          usersManagementController
                                              .changeRoleValue(index, value);
                                        }),
                                        thumbColor: usersManagementController
                                                .rolesListToAffich![index]
                                                .value!
                                            ? bluePurpleColor
                                            : greyColor,
                                        activeColor:
                                            bluePurpleColor.withOpacity(0.5),
                                      )
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
                          : Center(child: Text("noResults".tr))
                      : usersManagementController.searchTextRole == ""
                          ? const CircularProgressIndicator()
                          : Center(child: Text("noResults".tr));
                }),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    usersManagementController.confirm();
                  },
                  child:
                      GetBuilder<UsersManagementController>(builder: (context) {
                    return Text("confirm".tr);
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
