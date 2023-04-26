import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:startease/view/role_management.dart';
import 'package:startease/view/users_management.dart';

import '../Themes/colors.dart';
import '../controller/home_screen_controller.dart';
import 'widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController homeScreenController = Get.find();
 

    List<BottomNavigationBarItem> bottomNavigationBarItemList = [
      const BottomNavigationBarItem(
        label: "",
        icon: Icon(
          Icons.settings,
        ),
        activeIcon: ActiveBottomBarIcon(
          widgetIcon: Icon(Icons.settings),
        ),
      ),
      const BottomNavigationBarItem(
        label: "",
        icon: ProfileCircleIcon(),
        activeIcon: ActiveBottomBarIcon(
          widgetIcon: ProfileCircleIcon(),
        ),
      ),
    ];

    const List<Widget> bottomNavigationBarScreensList = [
      RoleManagemenet(),
      UsersManagement()
    ];

    return Scaffold(
      bottomNavigationBar: GetBuilder<HomeScreenController>(builder: (ctx) {
        return BottomNavigationBar(
          unselectedItemColor: Theme.of(context).primaryColorLight,
          selectedItemColor: whiteColor,
          items: bottomNavigationBarItemList,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          currentIndex: homeScreenController.currentBottomBarIndex(),
          onTap: (index) {
            homeScreenController.switchBetweenScreens(index);
          },
        );
      }),
      drawer: Drawer(
        child: ListView(children: [
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            tileColor: transparentColor,
            shape: const RoundedRectangleBorder(),
            leading:
                Get.isDarkMode ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode),
            title: GetBuilder<HomeScreenController>(builder: (context) {
              return Text('theme'.tr);
            }),
            onTap: () {
              homeScreenController.setDarkTheme();
            },
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            tileColor: transparentColor,
            shape: const RoundedRectangleBorder(),
            leading: const Icon(Icons.language),
            title: GetBuilder<HomeScreenController>(builder: (context) {
              return Text('language'.tr);
            }),
            onTap: () {
              homeScreenController.setLanguage();
            },
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            tileColor: transparentColor,
            shape: const RoundedRectangleBorder(),
            leading: const Icon(Icons.person_pin_outlined),
            title: GetBuilder<HomeScreenController>(builder: (context) {
              return Text('Account'.tr);
            }),
            onTap: () {
              homeScreenController.goToProfil();
            },
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            tileColor: transparentColor,
            shape: const RoundedRectangleBorder(),
            leading: const Icon(Icons.info_outline),
            title: GetBuilder<HomeScreenController>(builder: (context) {
              return Text('aboutUs'.tr);
            }),
            onTap: () {
              homeScreenController.aboutUs();
            },
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            tileColor: transparentColor,
            shape: const RoundedRectangleBorder(),
            leading: const Icon(Icons.exit_to_app),
            title: GetBuilder<HomeScreenController>(builder: (context) {
              return Text('signOut'.tr);
            }),
            onTap: () {
              homeScreenController.signOut();
            },
          ),
        ]),
      ),
      body: GetBuilder<HomeScreenController>(builder: (context) {
        return bottomNavigationBarScreensList[
            homeScreenController.currentBottomBarIndex()];
      }),
    );
  }
}
