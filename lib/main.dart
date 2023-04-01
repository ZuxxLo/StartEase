import 'dart:async';
 import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Themes/colors.dart';
import 'Themes/themes.dart';
import 'model/user_model.dart';
import 'services/languages.dart';
import 'utils/forgot_password_binding.dart';
import 'utils/login_binding.dart';
import 'utils/profile_page_binding.dart';
import 'view/forgot_password.dart';
import 'view/login.dart';
import 'view/profile_page.dart';

UserModel userModel = UserModel(
    userID: "1",
    userUserName: "Zuxxlord",
    userFirstName: "Mohammed Nassim",
    userLastName: "Fellah",
    userEmail: "mn.fellah@esi-sba.dz",
    userPassword: "12345678",
    userPhoneNumber: "0778202192",
    userImageURL:
        "https://instagram.forn3-1.fna.fbcdn.net/v/t51.2885-19/322931595_982162009333658_7929326252684146824_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.forn3-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=7nWt_pPAmngAX__8URi&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfDVts1z01X3FjKFXuKWAA18NjxfccvZ0MZMAxn8U_viYA&oe=6426FB87&_nc_sid=8fd12b",
    userBirthday: "20/02/2002",
    userBirthplace: "Sidi Lakhdar - Mostaganem");
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MainFunctions.sharredPrefs = await SharedPreferences.getInstance();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        locale: Languages.initLang(),
        translations: Languages(),
        title: 'Flutter Demo',
        theme: Themes.getThemeMode(),
        getPages: [
          GetPage( 
              name: "/SignIn",
              page: () => const SignIn(),
              binding: LoginBinding()),
          GetPage(
            name: "/ForgotPassword",
            page: () => const ForgotPassword(),
            binding: ForgotPasswordBinding(),
          ),
          GetPage(
            name: "/ProfilePage",
            page: () => const ProfilePage(),
            binding: ProfilePageBinding(),
          ),
        ],
        initialRoute: "/SignIn");
  }
}

///
///This class is used for all repetitive functions and variables that are used throughout the code.
class MainFunctions {
  static SharedPreferences? sharredPrefs;

  ///
  ///Check whether there is internet connection or not , it will display a snackbar message.
  static Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Get.closeCurrentSnackbar();

        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      Get.defaultPopGesture;
      if (!Get.isSnackbarOpen) {
        Get.rawSnackbar(
            duration: const Duration(seconds: 5),
            message: "noConnection".tr,
            showProgressIndicator: true,
            snackPosition: SnackPosition.TOP,
            icon: const Icon(
              Icons.report_problem,
              color: redColor,
            ));
      }

      return false;
    }
  }

  ///

  ///
  ///
  static late RxBool isInternetConnected;
  static vt() async {
    await checkInternetConnection().then((value) {
      isInternetConnected = value.obs;
    });
  }

  static getBoolisInternetConnected() async {
    print("nonononnononono canceeeleled");

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Get.closeCurrentSnackbar();
        isInternetConnected = RxBool(true);
      } else {
        isInternetConnected = RxBool(false);
      }
    } on SocketException catch (_) {
      Get.defaultPopGesture;
      isInternetConnected = false.obs;
      if (!Get.isSnackbarOpen) {
        Get.rawSnackbar(
            duration: const Duration(seconds: 6),
            message: "noConnection".tr,
            showProgressIndicator: true,
            snackPosition: SnackPosition.TOP,
            icon: const Icon(
              Icons.report_problem,
              color: Colors.red,
            ));
      }
    }
  }

  static somethingWentWrongSnackBar([String? errorText]) {
 
    Get.rawSnackbar(
        duration: const Duration(seconds: 5),
        message: errorText == null
            ? "somethingWentWrong".tr
            : "somethingWentWrong".tr + '\n' + errorText,
        showProgressIndicator: true,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(
          Icons.report_problem,
          color: redColor,
        ));
  }
}
