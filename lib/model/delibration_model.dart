class DelibrationsModel {
  bool? success;
  String? message;
  Data? data;

  DelibrationsModel({this.success, this.message, this.data});

  DelibrationsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
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
        ? new Deliberation.fromJson(json['deliberation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deliberation != null) {
      data['deliberation'] = this.deliberation!.toJson();
    }
    return data;
  }
}

class Deliberation {
  int? id;
  Project? project;
  List<Members>? members;
  Null? reserves;

  Deliberation({this.id, this.project, this.members, this.reserves});

  Deliberation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    project =
        json['project'] != null ? new Project.fromJson(json['project']) : null;
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
    reserves = json['reserves'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    data['reserves'] = this.reserves;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trademark_name'] = this.trademarkName;
    data['scientific_name'] = this.scientificName;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['photo_url'] = this.photoUrl;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mark'] = this.mark;
    data['mention'] = this.mention;
    data['appreciation'] = this.appreciation;
    data['diploma_url'] = this.diplomaUrl;
    return data;
  }
}