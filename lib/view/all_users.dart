import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: BackIconButton(),
        title: Text(
          "allUsers".tr,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const Divider(),
          GetBuilder<UsersManagementController>(builder: (context) {
            return SizedBox(
              height: screenHeight - 150,
              child: usersManagementController.allUsersList.isNotEmpty
                  ? ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: usersManagementController.allUsersList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            usersManagementController.goToUserDetails(index);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 30, right: 20),
                            height: 40,
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
                                              return CircularProgressIndicator();
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
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: SmallBodyText(
                                      text:
                                          "${usersManagementController.allUsersList[index].firstName} ${usersManagementController.allUsersList[index].lastName}"),
                                ),
                                SendIcon()
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            );
          })
        ],
      ),
    );
  }
}
