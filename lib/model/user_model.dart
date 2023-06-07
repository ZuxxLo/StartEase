import 'package:startease/model/roles_model.dart';

import 'permissions_model.dart';

class UserModel {
  int? id;
  String? username;
  String? email;
  String? phoneNumber;
  String? photoUrl;
  String? personType;
  Person? person = Person();
  bool? isProjectMember;
  late int? isEnabled;
  late List<Roles>? roles;
  late List<Permissions>? permissions;

  late String? token;

  UserModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.phoneNumber,
      required this.photoUrl,
      required this.personType,
      required this.isEnabled,
      required this.roles,
      required this.permissions,
      required this.person,
      required this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["data"]["user"]['id'];
    username = json["data"]["user"]['username'];
    email = json["data"]["user"]['email'];
    person = json["data"]["user"]['person'] != null
        ? Person.fromJson(json["data"]["user"]['person'])
        : null;
    phoneNumber = json["data"]["user"]['phone_number'];
    photoUrl = (json["data"]["user"]['photo_url']); //substring(21)
    personType = json["data"]["user"]['person_type'];
    isEnabled = json["data"]["user"]['is_enabled'];
    if (json["data"]["user"]['roles'] != null) {
      roles = <Roles>[];
      json["data"]["user"]['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    } else {
      roles = [];
    }
    if (json["data"]["user"]['permissions'] != null) {
      permissions = <Permissions>[];
      json["data"]["user"]['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    } else {
      permissions = [];
    }
    isProjectMember = json["data"]["user"]["is_project_member"];
    token = json["data"]["token"];
  }
  UserModel.fromJsonS(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    photoUrl = (json['photo_url']); //substring(21)
    personType = json['person_type'];
    person = json['person'] != null ? Person.fromJson(json['person']) : null;
    isEnabled = json['is_enabled'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    } else {
      roles = [];
    }
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    } else {
      permissions = [];
    }
    // token = json["data"]["token"];
  }

  UserModel.fromJsonComments(Map<String, dynamic> json) {
    id = json['id'];

    photoUrl = (json['photo_url']); //substring(21)

    person = json['person'] != null ? Person.fromJson(json['person']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['photo_url'] = photoUrl;
    data['is_enabled'] = isEnabled;
    return data;
  }
}

class Grade {
  int? id;
  String? name;
  String? type;

  Grade({this.id, this.name, this.type});

  Grade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class Person {
  int? id;
  String? firstName;
  String? lastName;
  Establishment? establishment = Establishment();
  Grade? grade;
  Grade? speciality;
  String? matricule;
  String? birthday;
  String? birthPlace;
  String? numInscription;
  Establishment? filiere;

  Person(
      {this.id,
      this.firstName,
      this.lastName,
      this.establishment,
      this.grade,
      this.speciality,
      this.matricule,
      this.birthday,
      this.birthPlace,
      this.numInscription,
      this.filiere});

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    establishment = json['establishment'] != null
        ? new Establishment.fromJson(json['establishment'])
        : null;
    grade = json['grade'] != null ? new Grade.fromJson(json['grade']) : null;
    speciality = json['speciality'] != null
        ? new Grade.fromJson(json['speciality'])
        : null;
    matricule = json['matricule'];
    birthday = json['birthday'];
    birthPlace = json['birth_place'];
    numInscription = json['num_inscription'];
    filiere = json['filiere'] != null
        ? new Establishment.fromJson(json['filiere'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    if (this.establishment != null) {
      data['establishment'] = this.establishment!.toJson();
    }
    if (this.grade != null) {
      data['grade'] = this.grade!.toJson();
    }
    if (this.speciality != null) {
      data['speciality'] = this.speciality!.toJson();
    }
    data['matricule'] = this.matricule;
    data['birthday'] = this.birthday;
    data['birth_place'] = this.birthPlace;
    data['num_inscription'] = this.numInscription;
    if (this.filiere != null) {
      data['filiere'] = this.filiere!.toJson();
    }
    return data;
  }
}

class Establishment {
  int? id;
  String? name;

  Establishment({this.id, this.name});

  Establishment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
