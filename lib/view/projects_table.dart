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
                    title: "searchByName".tr,
                    content: Column(
                      children: [
                        TextFormField(
                          onChanged: (inputSearch) {
                            projectsTableController
                                .searchTextInputProject(inputSearch);
                          },
                          decoration: InputDecoration(
                              hintText: projectsTableController
                                          .searchTextProject ==
                                      ""
                                  ? "searchByName".tr
                                  : projectsTableController.searchTextProject),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              projectsTableController.searchProjectByTradeMark(
                                  projectsTableController.searchTextProject);
                              navigator!.pop();
                            },
                            child: Text("confirm".tr)),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              projectsTableController
                                  .searchTextInputProject("");
                              projectsTableController
                                  .searchProjectByTradeMark("");
                              navigator!.pop();
                            },
                            child: Text("clear".tr))
                      ],
                    ));
              },
              icon: const ImageIcon(Svg("assets/icons/search_icon.svg"))),
        ],
      ),
      body: GetBuilder<ProjectsTableController>(builder: (context) {
        return FutureBuilder(
            future: projectsTableController.loadProjects(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (projectsTableController.projectsListToAffich.isEmpty) {
                  return Center(
                    child: Text("noResults".tr),
                  );
                } else {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    shrinkWrap: true,
                    itemCount:
                        projectsTableController.projectsListToAffich.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Get.toNamed("/ProjectManagement",
                              arguments: projectsTableController
                                  .projectsListToAffich[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).listTileTheme.tileColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  projectsTableController
                                      .projectsListToAffich[index]
                                      .trademarkName!,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: projectsTableController
                                          .getStatusColorOut(
                                              projectsTableController
                                                  .projectsListToAffich[index]
                                                  .status!),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: ImageIcon(
                                      color: projectsTableController
                                          .getStatusColorIn(
                                              projectsTableController
                                                  .projectsListToAffich[index]
                                                  .status!),
                                      Svg("assets/icons/${projectsTableController.getStatusIcon(projectsTableController.projectsListToAffich[index].status!)}.svg")))
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Center(
                  child: Text("noResults".tr),
                );
              }
            });
      }),
    );
  }
}
