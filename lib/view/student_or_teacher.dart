import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Themes/colors.dart';
import '../controller/sign_up_controller.dart';
import 'widgets.dart';

class StudentOrTeacher extends StatelessWidget {
  const StudentOrTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.find();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackIconButton(),
        title: Text("registration".tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: [
            Text("studentOrTeacher".tr),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                signUpController.chooseTeacher();

                //  projectManagementAdminController.goToProjectsTable();
              },
              child: GetBuilder<SignUpController>(builder: (context) {
                return Container(
                  width: 200,
                  height: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: signUpController.isTeacher
                          ? Border.all(color: bluePurpleColor, width: 2)
                          : Border.all(color: greyColor)),
                  child: Column(children: [
                    Expanded(
                      child: Image.asset(
                        "assets/images/roles.png",
                      ),
                    ),
                    Text(
                      "teacher".tr,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ]),
                );
              }),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                signUpController.chooseStudent();
                //    projectManagementAdminController.goToPeriodsManagement();
              },
              child: GetBuilder<SignUpController>(builder: (context) {
                return Container(
                  width: 200,
                  height: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: signUpController.isStudent
                          ? Border.all(color: bluePurpleColor, width: 2)
                          : Border.all(color: greyColor)),
                  child: Column(children: [
                    Expanded(
                      child: Image.asset(
                        "assets/images/roles.png",
                      ),
                    ),
                    Text(
                      "student".tr,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ]),
                );
              }),
            ),
            const SizedBox(height: 20),
            TextButton(onPressed: (){
              signUpController.chooseTeacherOrStudent();
            }, child: Text("createRole5".tr))
          ],
        ),
      ),
    );
  }
}
