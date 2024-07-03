import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startease/controller/defence_management_controller.dart';
import 'package:startease/main.dart';
import 'package:startease/view/project_manag_admin.dart';
import 'package:startease/view/role_management.dart';
import 'package:startease/view/users_management.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../Themes/colors.dart';
import '../controller/home_screen_controller.dart';
import '../controller/project_manag_admin_controller.dart';
import '../controller/role_management_controller.dart';
import '../controller/users_management_controller.dart';
import '../model/permissions_model.dart';
import 'defenses_bottom_bar.dart';
import 'widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeScreenController homeScreenController = Get.find();

    List<Widget> affichBottomNavBarScreens() {
      bool firstIF = true;
      bool secondIF = true;
      bool thirdIF = true;
      bool forthIF = true;
      List<Widget> tempsList = [];
      for (Permissions element in userModel.permissions!) {
        if (firstIF &&
            (element.id == 10 ||
                element.id == 11 ||
                element.id == 12 ||
                element.id == 13 ||
                element.id == 14 ||
                element.id == 15 ||
                element.id == 16)) {
          tempsList.add(const RoleManagemenet());
          Get.put(RoleManagemenetController());
          firstIF = false;
        }

        if (secondIF && (element.id == 19)) {
          tempsList.add(const UsersManagement());
          Get.put(UsersManagementController());
          secondIF = false;
        }

        if (thirdIF && (element.id == 21 || element.id == 23)) {
          tempsList.add(const ProjectManagementAdmin());
          Get.put(ProjectManagementAdminController());
          thirdIF = false;
        }
        if (forthIF && (element.id == 24 || element.id == 33)) {
          tempsList.add(const DefensesBottomBar());
          Get.put(DefenceManagementController());
          forthIF = false;
        }
      }

      return tempsList;
    }

    List<BottomNavigationBarItem> affichBottomNavBarItems() {
      bool firstIF = true;
      bool secondIF = true;
      bool thirdIF = true;
      bool forthIF = true;

      List<BottomNavigationBarItem> tempsList = [];
      for (Permissions element in userModel.permissions!) {
        if (firstIF &&
            (element.id == 10 ||
                element.id == 11 ||
                element.id == 12 ||
                element.id == 13 ||
                element.id == 14 ||
                element.id == 15 ||
                element.id == 16)) {
          tempsList.add(
            const BottomNavigationBarItem(
              label: "",
              icon: ImageIcon(Svg("assets/icons/shield_tick_icon.svg")),
              activeIcon: ActiveBottomBarIcon(
                widgetIcon: ImageIcon(Svg("assets/icons/shield_tick_icon.svg")),
              ),
            ),
          );
          firstIF = false;
        }

        if (secondIF && (element.id == 19)) {
          tempsList.add(
            const BottomNavigationBarItem(
              label: "",
              icon: ImageIcon(Svg("assets/icons/profile_2user_icon.svg")),
              activeIcon: ActiveBottomBarIcon(
                widgetIcon: ImageIcon(
                  Svg("assets/icons/profile_2user_icon.svg"),
                ),
              ),
            ),
          );
          secondIF = false;
        }

        if (thirdIF && (element.id == 21 || element.id == 23)) {
          tempsList.add(const BottomNavigationBarItem(
            label: "",
            icon: ImageIcon(
              Svg("assets/icons/view_project_icon.svg"),
            ),
            activeIcon: ActiveBottomBarIcon(
              widgetIcon: ImageIcon(
                Svg("assets/icons/view_project_icon.svg"),
              ),
            ),
          ));

          thirdIF = false;
        }
        if (forthIF && (element.id == 24 || element.id == 33)) {
          tempsList.add(const BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.filter_frames_outlined),
            activeIcon: ActiveBottomBarIcon(
              widgetIcon: Icon(Icons.filter_frames_outlined),
            ),
          ));
          forthIF = false;
        }
      }

      return tempsList;
    }

    GlobalKey key1 = GlobalKey();

    List<BottomNavigationBarItem> bottomNavigationBarItemList = [
      const BottomNavigationBarItem(
        label: "",
        icon: ImageIcon(Svg("assets/icons/shield_tick_icon.svg")),
        activeIcon: ActiveBottomBarIcon(
          widgetIcon: ImageIcon(Svg("assets/icons/shield_tick_icon.svg")),
        ),
      ),
      const BottomNavigationBarItem(
        label: "",
        icon: ImageIcon(Svg("assets/icons/profile_2user_icon.svg")),
        activeIcon: ActiveBottomBarIcon(
          widgetIcon: ImageIcon(
            Svg("assets/icons/profile_2user_icon.svg"),
          ),
        ),
      ),
      const BottomNavigationBarItem(
        label: "",
        icon: ImageIcon(
          Svg("assets/icons/view_project_icon.svg"),
        ),
        activeIcon: ActiveBottomBarIcon(
          widgetIcon: ImageIcon(
            Svg("assets/icons/view_project_icon.svg"),
          ),
        ),
      ),
    ];

    List<Widget> bottomNavigationBarScreensList = [
      const RoleManagemenet(),
      const UsersManagement(),
      const ProjectManagementAdmin(),
    ];

    return Scaffold(
        bottomNavigationBar: affichBottomNavBarScreens().length != 1
            ? GetBuilder<HomeScreenController>(builder: (ctx) {
                return BottomNavigationBar(
                  unselectedItemColor: Theme.of(context).primaryColorLight,
                  selectedItemColor: whiteColor,
                  items: affichBottomNavBarItems(),
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  elevation: 0,
                  currentIndex: homeScreenController.currentBottomBarIndex(),
                  onTap: (index) {
                    homeScreenController.switchBetweenScreens(index);
                  },
                );
              })
            : null,
        drawer: Drawer(
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      SizedBox(height: 60, child: LogoStartEase()),
                      SizedBox(
                        width: 3,
                      ),
                      TitleMediumText(text: "StartEase")
                    ],
                  ),
                  IconButton(
                      key: key1,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(creatroute(
                            const HomeScreen(),
                            key1.globalPaintBounds!.center,
                            200.0));
                        Get.put(HomeScreenController());

                        homeScreenController.set();
                      },
                      icon: Get.isDarkMode
                          ? const Icon(Icons.dark_mode, size: 28)
                          : const Icon(Icons.sunny,
                              color: darkBlueColor, size: 28)),
                ],
              ),
            ),
            const SizedBox(height: 100),
            TextButton.icon(
              style: ButtonStyle(
                  iconSize: MaterialStateProperty.all(25),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.only(left: 25)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
                  alignment: Alignment.centerLeft,
                  backgroundColor: MaterialStateProperty.all(transparentColor),
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColorLight)),
              onPressed: () {
                homeScreenController.goToProfil();
              },
              icon:
                  const ImageIcon(Svg("assets/icons/profile_circle_icon.svg")),
              label: GetBuilder<HomeScreenController>(builder: (context) {
                return Text(
                  'Account'.tr,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w300),
                );
              }),
            ),
            TextButton.icon(
              style: ButtonStyle(
                  iconSize: MaterialStateProperty.all(25),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.only(left: 25)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
                  alignment: Alignment.centerLeft,
                  backgroundColor: MaterialStateProperty.all(transparentColor),
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColorLight)),
              onPressed: () {
                Get.defaultDialog(
                    title: "Settings".tr,
                    content: Column(
                      children: [
                        // TextButton.icon(
                        //     onPressed: () {
                        //       Get.back();
                        //       homeScreenController.setDarkTheme();
                        //     },
                        //     icon: Get.isDarkMode
                        //         ? const Icon(Icons.dark_mode, size: 30)
                        //         : const Icon(Icons.light_mode, size: 30),
                        //     label: Text("theme".tr)),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        TextButton.icon(
                            onPressed: () {
                              Get.back();
                              homeScreenController.setLanguage();
                            },
                            icon: const ImageIcon(
                                Svg("assets/icons/language_icon.svg"),
                                size: 30),
                            label: Text("language".tr)),
                      ],
                    ));
              },
              icon: const ImageIcon(Svg("assets/icons/setting_icon.svg")),
              label: GetBuilder<HomeScreenController>(builder: (context) {
                return Text(
                  'Settings'.tr,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w300),
                );
              }),
            ),
            TextButton.icon(
              style: ButtonStyle(
                  iconSize: MaterialStateProperty.all(25),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.only(left: 25)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
                  fixedSize: MaterialStateProperty.all(const Size(1600, 50)),
                  alignment: Alignment.centerLeft,
                  backgroundColor: MaterialStateProperty.all(transparentColor),
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColorLight)),
              onPressed: () {
                homeScreenController.aboutUs();
              },
              icon: const ImageIcon(Svg("assets/icons/info_circle_icon.svg")),
              label: GetBuilder<HomeScreenController>(builder: (context) {
                return Text(
                  'aboutUs'.tr,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w300),
                );
              }),
            ),
            TextButton.icon(
              style: ButtonStyle(
                  iconSize: MaterialStateProperty.all(30),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.only(left: 20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
                  fixedSize: MaterialStateProperty.all(const Size(1600, 50)),
                  alignment: Alignment.centerLeft,
                  backgroundColor: MaterialStateProperty.all(transparentColor),
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColorLight)),
              onPressed: () {
                homeScreenController.signOut();
              },
              icon: const ImageIcon(Svg("assets/icons/logout.svg")),
              label: GetBuilder<HomeScreenController>(builder: (context) {
                return Text(
                  'signOut'.tr,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w300),
                );
              }),
            )
          ]),
        ),
        body: GetBuilder<HomeScreenController>(builder: (context) {
          if (affichBottomNavBarScreens().length == 1) {
            return affichBottomNavBarScreens()[0];
          } else {
            return affichBottomNavBarScreens()[
                homeScreenController.currentBottomBarIndex()];
          }
        }));
  }
}
//////////// to creat telegram like route transition/animation

Route creatroute(var route, Offset offset, var circularRadius) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        double beginRadius = 0;
        double endRadius = MediaQuery.of(context).size.height * 1.2;

        return ClipPath(
          clipper: CircleTransitionClipper(
              offset,
              animation.drive(Tween(begin: beginRadius, end: endRadius)).value,
              circularRadius),
          child: child,
        );
      });
}

//////////// to get positions of a widget on the screen

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final matrix = renderObject?.getTransformTo(null);

    if (matrix != null && renderObject?.paintBounds != null) {
      final rect = MatrixUtils.transformRect(matrix, renderObject!.paintBounds);
      return rect;
    } else {
      return null;
    }
  }
}

class CircleTransitionClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;
  final double circularRadius;

  CircleTransitionClipper(this.center, this.radius, this.circularRadius);
  @override
  getClip(Size size) {
    return Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromCircle(center: center, radius: radius),
          Radius.circular(circularRadius)));
  } //addOval(Rect.fromCircle(center: center, radius: radius));

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
