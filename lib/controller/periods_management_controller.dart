import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:startease/model/period_model.dart';

import '../backend/crud.dart';
import '../backend/link_api.dart';
import '../main.dart';

class PeriodsManagementController extends GetxController {
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  String? startDate;
  String? endDate;

  Period? selectedPeriod;
  List<Period> periodsList = [];

  inputStartDate(DateTime value) {
    startDate = dateFormat.format(value);
    selectedPeriod?.startDate = dateFormat.format(value);

    update();
  }

  inputEndDate(DateTime value) {
    endDate = dateFormat.format(value);
    selectedPeriod?.endDate = dateFormat.format(value);
    update();
  }

  void inputPeriodValue(Period? period) {
    selectedPeriod = period;
    update();
  }

  loadPeriods() async {
    periodsList.clear();
    var response = await Crud.getRequest(periodsLink);
    if (response != null && response["success"] == true) {
      periodsList = PeriodsModel.fromJson(response).data!.periods!;
    }

    periodsList.forEach((element) {
      print("${element.name} + ${element.id}");
    });

    update();
  }

  confirm() async {
    if (await MainFunctions.checkInternetConnection()) {
      var response =
          await Crud.putRequest(periodsLink, selectedPeriod!.toJsonUpdate());
      if (response != null && response["success"] == true) {
        MainFunctions.successSnackBar("periodUpdated".tr);
      } else {
        MainFunctions.somethingWentWrongSnackBar(response["message"]);
      }
    }
  }

  @override
  void onInit() {
    loadPeriods();
    super.onInit();
  }
}
