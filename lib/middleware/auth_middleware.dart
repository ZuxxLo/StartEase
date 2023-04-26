import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../main.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;
  @override
  RouteSettings? redirect(String? route) {

    
    if (MainFunctions.sharredPrefs?.getString("authToken") != null) {
      return const RouteSettings(name: "/HomeScreen");
    } else {
      return null;
    }
  }
}
