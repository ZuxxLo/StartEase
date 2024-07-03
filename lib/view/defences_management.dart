import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/defence_management_controller.dart';
import 'widgets.dart';

class DefenceManagement extends StatelessWidget {
  const DefenceManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final DefenceManagementController defenceManagementController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: Text("defensesTable".tr),
      ),
      body: GetBuilder<DefenceManagementController>(builder: (context) {
        return FutureBuilder(
            future: defenceManagementController.loadDefences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (defenceManagementController.defencesList.isEmpty) {
                  return Center(
                    child: Text("noResults".tr),
                  );
                } else {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    shrinkWrap: true,
                    itemCount: defenceManagementController.defencesList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          defenceManagementController.loadOneDefenceData(index);
                          Get.toNamed("/DefencesAdmin");
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).listTileTheme.tileColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            defenceManagementController
                                .defencesList[index].project!.trademarkName!,
                            style: const TextStyle(fontSize: 18),
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
