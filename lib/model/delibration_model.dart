class DelibrationsModel {
  bool? success;
  String? message;
  Data? data;

  DelibrationsModel({this.success, this.message, this.data});

  DelibrationsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Deliberation? deliberation;

  Data({this.deliberation});

  Data.fromJson(Map<String, dynamic> json) {
    deliberation = json['deliberation'] != null
        ? Deliberation.fromJson(json['deliberation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deliberation != null) {
      data['deliberation'] = deliberation!.toJson();
    }
    return data;
  }
}

class Deliberation {
  int? id;
  Project? project;
  List<Members>? members;
  String? reserves;

  Deliberation({this.id, this.project, this.members, this.reserves});

  Deliberation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
    reserves = json['reserves'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    data['reserves'] = reserves;
    return data;
  }
}

class Project {
  String? trademarkName;
  String? scientificName;

  Project({this.trademarkName, this.scientificName});

  Project.fromJson(Map<String, dynamic> json) {
    trademarkName = json['trademark_name'];
    scientificName = json['scientific_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trademark_name'] = trademarkName;
    data['scientific_name'] = scientificName;
    return data;
  }
}

class Members {
  int? id;
  String? email;
  String? photoUrl;
  String? firstName;
  String? lastName;
  String? mark;
  String? mention;
  String? appreciation;
  String? diplomaUrl;

  Members(
      {this.id,
      this.email,
      this.photoUrl,
      this.firstName,
      this.lastName,
      this.mark,
      this.mention,
      this.appreciation,
      this.diplomaUrl});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    photoUrl = json['photo_url'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mark = json['mark'];
    mention = json['mention'];
    appreciation = json['appreciation'];
    diplomaUrl = json['diploma_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['photo_url'] = photoUrl;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mark'] = mark;
    data['mention'] = mention;
    data['appreciation'] = appreciation;
    data['diploma_url'] = diplomaUrl;
    return data;
  }
}