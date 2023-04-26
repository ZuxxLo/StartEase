import 'package:flutter/material.dart';
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
        title: Text(
          "allUsers".tr,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const Divider(),
          GetBuilder<UsersManagementController>(builder: (context) {
            return SizedBox(
              height: screenHeight - 150,
              child: usersManagementController.allUsersList.isNotEmpty
                  ? ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: usersManagementController.allUsersList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            usersManagementController.goToUserDetails(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 30, right: 20),
                            height: 40,
                            color: usersManagementController
                                        .allUsersList[index].isEnabled ==
                                    1
                                ? transparentColor
                                : redColor.withOpacity(0.08),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: !(usersManagementController
                                                .allUsersList[index].photoUrl ==
                                            "https://via.placeholder.com/640x480.png/002277?text=architecto")
                                        ? ClipOval(
                                            child: Image.network(
                                            linkServerName +
                                                usersManagementController
                                                    .allUsersList[index]
                                                    .photoUrl!
                                                    .substring(21),
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const CircularProgressIndicator();
                                            },
                                          ))
                                        : ClipOval(
                                            child: Container(
                                              alignment: Alignment.center,
                                              color: MainFunctions
                                                  .generatePresizedColor(
                                                      usersManagementController
                                                          .allUsersList[index]
                                                          .username
                                                          .length),
                                              child: Text(
                                                usersManagementController
                                                    .allUsersList[index]
                                                    .firstName[0]
                                                    .toUpperCase(),
                                                // style: const TextStyle(
                                                //     fontSize: 27, color: purpleTextColor),
                                              ),
                                            ),
                                          )),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: SmallBodyText(
                                      text:
                                          "${usersManagementController.allUsersList[index].firstName} ${usersManagementController.allUsersList[index].lastName}"),
                                ),
                                const SendIcon()
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    )
                  : const Center(child: CircularProgressIndicator()),
            );
          })
        ],
      ),
    );
  }
}
