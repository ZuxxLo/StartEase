import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/Themes/colors.dart';

import '../controller/projects_table_controller.dart';
import 'widgets.dart';

class ProjectsTable extends StatelessWidget {
  const ProjectsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectsTableController projectsTableController = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: Text(
            projectsTableController.searchTextProject == ""
                ? "projectsTable".tr
                : "searching".tr + projectsTableController.searchTextProject,
            style: TextStyle(
                fontSize:
                    projectsTableController.searchTextProject == "" ? 25 : 18)),
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "searchByFirstLastName".tr,
                    content: Column(
                      children: [
                        TextFormField(
                          onChanged: (inputSearch) {
                            // projectsTableController
                            //     .searchTextInputProject(inputSearch);
                          },
                          decoration: InputDecoration(
                              // hintText:
                              //     projectsTableController.searchTextProject == ""
                              //         ? "searchByFirstLastName".tr
                              //         : projectsTableController
                              //             .searchTextProject
                              ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              // projectsTableController.searchProject(
                              //     projectsTableController.searchTextProject);
                              navigator!.pop();
                            },
                            child: Text("confirm".tr)),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              // projectsTableController.searchTextInputProject("");
                              // projectsTableController.searchProject("");
                              navigator!.pop();
                            },
                            child: Text("clear".tr))
                      ],
                    ));
              },
              icon: const ImageIcon(Svg("assets/icons/search_icon.svg"))),
        ],
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Get.toNamed("/ProjectManagement");
            },
            child: Container(
              height: 70,
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).listTileTheme.tileColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Rockerts Space Ships"),
                  Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: greenColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50)),
                      child: ImageIcon(
                          color: greenDeepColor,
                          Svg("assets/icons/recourse_icon.svg")))
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
