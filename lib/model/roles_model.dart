import 'package:startease/model/permissions_model.dart';

class RolesModel {
  bool? success;
  String? message;
  Data? data;

  RolesModel({this.success, this.message, this.data});

  RolesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Roles>? roles;

  Data({this.roles});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
  }
}

enum RolesType { defaultType, customType }

class Roles {
  int? id;
  String? name;
  int? usersCount;
  RolesType? type;

  List<Permissions>? permissions;
  bool? value;

  Roles({this.id, this.name, this.usersCount, this.permissions});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    usersCount = json['users_count'];
    if (json['type'] == "default") {
      type = RolesType.defaultType;
    } else if (json['type'] == "custom") {
      type = RolesType.customType;
    }
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(name, List<Permissions>? permissions) {
    final Map<String, dynamic> data = <String, dynamic>{};
    List<String> tempList = [];

    data['name'] = name;
    data['permissions'] = [];
    permissions?.forEach((element) {
      if (element.value == true) {
        tempList.add(element.id.toString());
      }
    });
    data['permissions'] = tempList;
    return data;
  }

  Map<String, dynamic> toJsonUpdate(int id, List<Permissions>? permissions) {
    final Map<String, dynamic> data = <String, dynamic>{};
    List tempList = [];

    data["role"] = id;
    data['permissions'] = [];
    permissions?.forEach((element) {
      if (element.value == true) {
        tempList.add(element.id);
      }
    });
    data['permissions'] = tempList;

    return data;
  }
}
