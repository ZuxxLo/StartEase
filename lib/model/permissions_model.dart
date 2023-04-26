class PermissionsModel {
  bool? success;
  String? message;
  Data? data;

  PermissionsModel({this.success, this.message, this.data});

  PermissionsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      // data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Permissions>? permissions;

  Data({this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   if (permissions != null) {
  //     data['permissions'] = permissions!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Permissions {
  int? id;
  String? name;
  bool value = false;

  Permissions({this.id, this.name});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson(Permissions permission) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    // data['id'] = id;
    data['name'] = permission.name;
    return data;
  }
}
