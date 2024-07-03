import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:startease/controller/defence_management_controller.dart';

import '../Themes/colors.dart';
import 'widgets.dart';

class ViewDelibration extends StatelessWidget {
  const ViewDelibration({super.key});

  @override
  Widget build(BuildContext context) {
    final DefenceManagementController defenceManagementController = Get.find();

    final formKey1 = GlobalKey<FormState>();
    final formKey2 = GlobalKey<FormState>();
    final formKey3 = GlobalKey<FormState>();
    final formKey4 = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        //////////////////   title:   Text("Project Name"), //////////////////
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: PageView(
          controller: defenceManagementController.pageController1,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Form(
                      key: formKey1,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "infoInnovativeIdea".tr,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),

                          TextFormField(
                              readOnly: true,
                              initialValue: defenceManagementController
                                  .defenceData!.project!.trademarkName,
                              onTap: null,
                              keyboardType: TextInputType.datetime,
                              decoration: const InputDecoration(
                                prefixIcon: ImageIcon(
                                    Svg("assets/icons/trade_mark_icon.svg")),
                              )),
                          const SizedBox(height: 7),
                          ///////////////////scientificName

                          TextFormField(
                              readOnly: true,
                              initialValue: defenceManagementController
                                  .defenceData!.project!.scientificName,
                              onTap: null,
                              keyboardType: TextInputType.datetime,
                              decoration: const InputDecoration(
                                prefixIcon: ImageIcon(
                                  Svg("assets/icons/scientific_commi_icon.svg"),
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          ///////////////////reserves
                          defenceManagementController.defenceData!.reserve !=
                                  null
                              ? Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "reserves".tr,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    TextFormField(
                                        readOnly: true,
                                        initialValue:
                                            defenceManagementController
                                                .defenceData!.reserve,
                                        onTap: null,
                                        keyboardType: TextInputType.datetime,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.roofing),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              : const SizedBox(),

                          const SizedBox(
                            height: 10,
                          ),

                          TextButton(
                            onPressed: () {
                              if (true) {
                                // formKey.currentState!.validate()
                                //formKey.currentState!.save();
                                defenceManagementController.next1();
                              }
                            },
                            child: Text(
                              "createRole5".tr,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 5,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: defenceManagementController
                          .deliberation!.members!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: bluePurpleColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 7, 10, 7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context)
                                          .listTileTheme
                                          .tileColor),
                                  child: Row(
                                    children: [
                                      ProfilePictureForOtherUserss(
                                        photoUrl: defenceManagementController
                                            .deliberation!
                                            .members![index]
                                            .photoUrl!,
                                        email: defenceManagementController
                                            .deliberation!
                                            .members![index]
                                            .email!,
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          "${defenceManagementController.defenceData!.jurys!.president!.email}",
                                          style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .fontSize,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )),
                              const SizedBox(height: 5),
                              ///////////////////mark
                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Text(
                              //     "mark".tr,
                              //     style:
                              //         const TextStyle(fontWeight: FontWeight.w600),
                              //   ),
                              // ),
                              TextFormField(
                                  readOnly: true,
                                  initialValue: defenceManagementController
                                      .deliberation!.members![index].mark!,
                                  onTap: null,
                                  keyboardType: TextInputType.datetime,
                                  decoration: const InputDecoration(
                                    prefixIcon: ImageIcon(
                                        Svg("assets/icons/tasks_icon.svg")),
                                  )),
                              const SizedBox(height: 5),
                              ///////////////////mark
                              ///
                              ///////////////////mention
                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Text(
                              //     "mention".tr,
                              //     style:
                              //         const TextStyle(fontWeight: FontWeight.w600),
                              //   ),
                              // ),
                              TextFormField(
                                  readOnly: true,
                                  initialValue: defenceManagementController
                                      .deliberation!.members![index].mention!,
                                  onTap: null,
                                  keyboardType: TextInputType.datetime,
                                  decoration: const InputDecoration(
                                    prefixIcon: ImageIcon(
                                        Svg("assets/icons/tasks_icon.svg")),
                                  )),
                              const SizedBox(height: 5),
                              ///////////////////mention
                              ///
                              ///////////////////appreciation
                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Text(
                              //     "appreciation".tr,
                              //     style:
                              //         const TextStyle(fontWeight: FontWeight.w600),
                              //   ),
                              // ),
                              TextFormField(
                                  readOnly: true,
                                  initialValue: defenceManagementController
                                      .deliberation!
                                      .members![index]
                                      .appreciation!,
                                  onTap: null,
                                  keyboardType: TextInputType.datetime,
                                  decoration: const InputDecoration(
                                    prefixIcon: ImageIcon(
                                        Svg("assets/icons/tasks_icon.svg")),
                                  )),
                              const SizedBox(height: 5),
                              ///////////////////appreciation
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(
                              const BorderSide(color: bluePurpleColor)),
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => bluePurpleColor.withOpacity(0.2)),
                          backgroundColor:
                              MaterialStateProperty.all(transparentColor)),
                      onPressed: () {
                        if (true) {
                          // formKey.currentState!.validate()
                          //formKey.currentState!.save();
                          defenceManagementController.goBackPageView1();
                        }
                      },
                      child: Text("goBack".tr,
                          style: const TextStyle(color: bluePurpleColor)),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
