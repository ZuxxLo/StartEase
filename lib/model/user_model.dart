import 'package:startease/model/roles_model.dart';

class UserModel {
  late int id;
  late String username;
  late String email;
  late String firstName;
  late String lastName;
  late String? phoneNumber;
  late String birthday;
  late String birthPlace;
  late String? photoUrl;
  late int isEnabled;
  late List<Roles>? roles;

  late String? token;

  UserModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.birthday,
      required this.birthPlace,
      required this.photoUrl,
      required this.isEnabled,
      required this.roles,
      required this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["data"]["user"]['id'];
    username = json["data"]["user"]['username'];
    email = json["data"]["user"]['email'];
    firstName = json["data"]["user"]['first_name'];
    lastName = json["data"]["user"]['last_name'];
    phoneNumber = json["data"]["user"]['phone_number'];
    birthday = json["data"]["user"]['birthday'];
    birthPlace = json["data"]["user"]['birth_place'];
    photoUrl = (json["data"]["user"]['photo_url']); //substring(21)
    isEnabled = json["data"]["user"]['is_enabled'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(  Roles.fromJson(v));
      });
    }
    token = json["data"]["token"];
  }
  UserModel.fromJsonS(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    birthday = json['birthday'];
    birthPlace = json['birth_place'];
    photoUrl = (json['photo_url']); //substring(21)
    isEnabled = json['is_enabled'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(  Roles.fromJson(v));
      });
    }
    // token = json["data"]["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['birthday'] = birthday;
    data['birth_place'] = birthPlace;
    data['photo_url'] = photoUrl;
    data['is_enabled'] = isEnabled;
    return data;
  }
}
