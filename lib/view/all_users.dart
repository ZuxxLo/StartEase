import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/view/widgets.dart';

import '../backend/link_api.dart';
import '../controller/users_management_controller.dart';
import '../main.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final UsersManagementController usersManagementController = Get.find();
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: GetBuilder<UsersManagementController>(builder: (context) {
          return Text(
            usersManagementController.searchText == ""
                ? "allUsers".tr
                : "searching".tr + usersManagementController.searchText,
            style: TextStyle(
                fontSize: usersManagementController.searchText == "" ? 25 : 18),
          );
        }),
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    onWillPop: () {
                      return Future.value(false);
                    },
                    title: "searchByName".tr,
                    content: Column(
                      children: [
                        TextFormField(
                          onChanged: (inputSearch) {
                            usersManagementController
                                .searchTextInput(inputSearch);
                          },
                          decoration: InputDecoration(
                              hintText:
                                  usersManagementController.searchText == ""
                                      ? "searchByName".tr
                                      : usersManagementController.searchText),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              usersManagementController.searchUser(
                                  usersManagementController.searchText);
                              navigator!.pop();
                            },
                            child: Text("confirm".tr)),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              usersManagementController.searchTextInput("");
                              usersManagementController.searchUser("");
                              navigator!.pop();
                            },
                            child: Text("clear".tr))
                      ],
                    ));
              },
              icon: const ImageIcon(Svg("assets/icons/search_icon.svg")))
        ],
      ),
      body: GetBuilder<UsersManagementController>(builder: (context) {
        return usersManagementController.allUsersListToAffich.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                shrinkWrap: true,
                itemCount:
                    usersManagementController.allUsersListToAffich.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      usersManagementController.goToUserDetails(index);
                    },
                    child: Container(
                      height: 80,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: usersManagementController
                                      .allUsersListToAffich[index].isEnabled ==
                                  1
                              ? Theme.of(context).listTileTheme.tileColor
                              : redColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: ProfilePictureForOtherUsers(
                                userModel: usersManagementController
                                    .allUsersListToAffich[index]),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                                
                                    "${usersManagementController.allUsersListToAffich[index].username}"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              )
            : usersManagementController.searchText == ""
                ? const Center(child: CircularProgressIndicator())
                : Center(child: Text("noResults".tr));
      }),
    );
  }
}
