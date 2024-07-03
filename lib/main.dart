import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startease/middleware/auth_middleware.dart';
import 'package:startease/model/roles_model.dart';
import 'package:startease/utils/create_role_binding.dart';
import 'package:startease/utils/defence_management_binding.dart';
import 'package:startease/utils/home_screen_binding.dart';
import 'package:startease/utils/permissions_management_binding.dart';
import 'package:startease/utils/projects_table_binding.dart';
import 'package:startease/utils/role_management_binding.dart';
import 'package:startease/utils/submit_project_binding.dart';
import 'package:startease/view/add_task.dart';
import 'package:startease/view/change_password.dart';
import 'package:startease/view/create_role.dart';
import 'package:startease/view/defences_admin.dart';
import 'package:startease/view/edit_role.dart';
import 'package:startease/view/home_screen.dart';
import 'package:startease/view/periods_management.dart';
import 'package:startease/view/projects_table.dart';
import 'package:startease/view/view_delibration.dart';
import 'package:startease/view/view_profile_informations.dart';
import 'package:startease/view/view_remarks.dart';

import 'Themes/colors.dart';
import 'Themes/themes.dart';
import 'model/user_model.dart';
import 'services/auth_service.dart';
import 'services/languages.dart';
import 'utils/all_roles_binding.dart';
import 'utils/forgot_password_binding.dart';
import 'utils/login_binding.dart';
import 'utils/periods_management_binding.dart';
import 'utils/profile_page_binding.dart';
import 'utils/project_deposit_binding.dart';
import 'utils/project_management_binding.dart';
import 'utils/sign_up_binding.dart';
import 'utils/users_management_binding.dart';
import 'view/all_roles.dart';
import 'view/all_users.dart';
import 'view/create_new_defense.dart';
import 'view/defences_management.dart';
import 'view/forgot_password.dart';
import 'view/login.dart';
import 'view/permissions_management.dart';
import 'view/profile_page.dart';
import 'view/project_deposit.dart';
import 'view/project_management.dart';
import 'view/role_management.dart';
import 'view/sign_up.dart';
import 'view/student_or_teacher.dart';
import 'view/submit_project.dart';
import 'view/update_phone_number.dart';
import 'view/user_details.dart';
import 'view/users_management.dart';
import 'view/view_comments.dart';
import 'view/view_defense.dart';
import 'view/view_observ.dart';
import 'view/view_project.dart';
import 'view/view_tasks.dart';

UserModel userModel = UserModel(
    id: 7777777777,
    username: "error",
    email: "error",
    phoneNumber: "error",
    photoUrl: "http://localhost:8000/images/users/default.png",
    isEnabled: 1,
    token: "error",
    roles: [Roles(id: -1, name: "error")],
    permissions: [],
    personType: 'error',
    person: null);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  MainFunctions.sharredPrefs = await SharedPreferences.getInstance();

  MainFunctions.getBoolisInternetConnected();
  userModel.roles = [];
  await MainFunctions.initialFetchLoggedin();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('fr')],
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        locale: Languages.initLang(),
        translations: Languages(),
        title: 'StartEase',
        theme: Themes.getThemeMode(),
        getPages: [
          GetPage(
            name: "/SignUp",
            page: () => const SignUp(),
            binding: SignUpBinding(),
          ),
          GetPage(
            name: "/StudentOrTeacher",
            page: () => const StudentOrTeacher(),
            binding: SignUpBinding(),
          ),
          GetPage(
              name: "/Login",
              page: () => const Login(),
              binding: LoginBinding(),
              middlewares: [AuthMiddleware()]),
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
          GetPage(
            name: "/ChangePassword",
            page: () => const ChangePassword(),
          ),
          GetPage(
            name: "/UpdatePhoneNumber",
            page: () => const UpdatePhoneNumber(),
          ),
          GetPage(
            name: "/ViewProfileInformations",
            page: () => const ViewProfileInformations(),
          ),
          GetPage(
              name: "/CreateRole",
              page: () => const CreateRole(),
              binding: CreateRoleBinding()),
          GetPage(
              name: "/RoleManagemenet",
              page: () => const RoleManagemenet(),
              binding: RoleManagemenetBinding()),
          GetPage(
              name: "/AllRoles",
              page: () => const AllRoles(),
              binding: AllRolesBinding()),
          GetPage(
            name: "/EditRole",
            page: () => const EditRole(),
          ),
          GetPage(
              name: "/PermissionsManagement",
              page: () => const PermissionsManagement(),
              binding: PermissionsManagementBinding()),
          GetPage(
              name: "/UsersManagement",
              page: () => const UsersManagement(),
              binding: UsersManagementBinding()),
          GetPage(
            name: "/AllUsers",
            page: () => const AllUsers(),
          ),
          GetPage(
            name: "/UserDetails",
            page: () => const UserDetails(),
          ),
          GetPage(
              name: "/HomeScreen",
              page: () => const HomeScreen(),
              binding: HomeScreenBinding()),
          GetPage(
              name: "/ProjectManagement",
              page: () => const ProjectManagement(),
              binding: ProjectManagementBinding()),
          GetPage(
              name: "/PeriodsManagement",
              page: () => const PeriodsManagement(),
              binding: PeriodsManagementBinding()),
          GetPage(
            name: "/ViewRemarks",
            page: () => const ViewRemarks(),
          ),
          GetPage(
            name: "/ViewComments",
            page: () => const ViewComments(),
          ),
          GetPage(
            name: "/ViewObserv",
            page: () => const ViewObserv(),
          ),
          GetPage(
            name: "/ViewTasks",
            page: () => const ViewTasks(),
          ),
          GetPage(
            name: "/AddTask",
            page: () => const AddTask(),
          ),
          GetPage(
            name: "/ViewProject",
            page: () => const ViewProject(),
          ),
          GetPage(
              name: "/SubmitProject",
              page: () => const SubmitProject(),
              binding: SubmitProjectBinding()),
          GetPage(
              name: "/ProjectsTable",
              page: () => const ProjectsTable(),
              binding: ProjectsTableBinding()),
          GetPage(
              name: "/ProjectDeposit",
              page: () => const ProjectDeposit(),
              binding: ProjectDepositBinding()),
          GetPage(
              name: "/DefenceManagement",
              page: () => const DefenceManagement(),
              binding: DefenceManagementBinding()),
          GetPage(
            name: "/ViewDefense",
            page: () => const ViewDefense(),
          ),
          GetPage(
            name: "/ViewDelibration",
            page: () => const ViewDelibration(),
          ),
          GetPage(
            name: "/DefencesAdmin",
            page: () => const DefencesAdmin(),
          ),
          GetPage(
            name: "/CreateNewDefense",
            page: () => const CreateNewDefense(),
          ),
        ],
        initialRoute: "/Login");
  }
}

///
///This class is used for all repetitive functions and variables that are used throughout the code.
class MainFunctions {
  static File? pickedImage;
  static SharedPreferences? sharredPrefs;
  static getBoolisInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isInternetConnected = true;
      } else {
        isInternetConnected = false;
      }
    } on SocketException catch (_) {
      isInternetConnected = false;
    }
  }

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
            snackPosition: SnackPosition.BOTTOM,
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
  static bool isInternetConnected = false;
  static vt() async {
    await checkInternetConnection().then((value) {});
  }

  static somethingWentWrongSnackBar([String? errorText]) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
          duration: const Duration(seconds: 5),
          message: errorText ?? "somethingWentWrong".tr,
          showProgressIndicator: true,
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(
            Icons.report_problem,
            color: redColor,
          ));
    }
  }

  static successSnackBar(String text) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
          isDismissible: false,
          duration: const Duration(seconds: 3),
          message: text,
          backgroundColor: greenColor,
          showProgressIndicator: true,
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(
            Icons.done,
            color: whiteColor,
          ));
    }
  }

  static Color generatePresizedColor(int namelength) {
    return profilColors[((namelength - 3) % 8).floor()];
  }

  static Future initialFetchLoggedin() async {
    await Get.putAsync(() => AuthService().toKeepSignIn());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
