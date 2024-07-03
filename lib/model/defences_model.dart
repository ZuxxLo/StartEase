import 'package:startease/model/project_model.dart';

class DefencesModel {
  bool? success;
  String? message;
  Data? data;

  DefencesModel({this.success, this.message, this.data});

  DefencesModel.fromJson(Map<String, dynamic> json) {
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
  List<Defences>? defences;

  Data({this.defences});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['defences'] != null) {
      defences = <Defences>[];
      json['defences'].forEach((v) {
        defences!.add(Defences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (defences != null) {
      data['defences'] = defences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Defences {
  int? id;
  ProjectModel? project;
  String? date;
  String? time;
  Establishment? establishment;
  Rooms? room;
  String? otherPlace;
  String? mode;
  String? nature;
  String? reserve;
  Map<String, dynamic>? files;
  int? projectId;
  bool? hasDeliberation;
  Jurys? jurys;

  Defences(
      {this.id,
      this.project,
      this.date,
      this.time,
      this.establishment,
      this.room,
      this.otherPlace,
      this.mode,
      this.nature,
      this.reserve,
      this.files,
      this.projectId,
      this.hasDeliberation,
      this.jurys});

  Defences.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];

    id = json['id'];
    project =
        json['project'] != null ? ProjectModel.fromJson(json['project']) : null;
    date = json['date'];
    time = json['time'];
    establishment = json['establishment'] != null
        ? Establishment.fromJson(json['establishment'])
        : null;
    room = json['room'] != null ? Rooms.fromJson(json['room']) : null;
    otherPlace = json['other_place'];
    mode = json['mode'];
    nature = json['nature'];
    reserve = json['reserve'];
    if (json['files'] != null) {
      files = json['files'];
    }
    hasDeliberation = json['has_deliberation'];
    jurys = json['jurys'] != null ? Jurys.fromJson(json['jurys']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['date'] = date;
    data['time'] = time;

    data['room_id'] = room!.id;
    data['president'] = jurys!.president!.email;

    data['other_place'] = otherPlace;
    data['mode'] = mode;
    data['nature'] = nature;
    List tempList = [];
    for (var i = 0; i < jurys!.examiners!.length; i++) {
      tempList.add(jurys!.examiners![i].email);
    }
    data['examiners'] = tempList;
    data['guest'] = jurys!.guest;

    return data;
  }
}

class Establishment {
  int? id;
  String? name;
  List<Rooms>? rooms;

  Establishment({this.id, this.name, this.rooms});

  Establishment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (rooms != null) {
      data['rooms'] = rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rooms {
  int? id;
  String? name;
  int? establishmentId;
  String? createdAt;
  String? updatedAt;

  Rooms(
      {this.id,
      this.name,
      this.establishmentId,
      this.createdAt,
      this.updatedAt});

  Rooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    establishmentId = json['establishment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['establishment_id'] = establishmentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Jurys {
  List<Examiners>? examiners;
  Examiners? supervisor;
  Examiners? coSupervisor;
  Examiners? president;
  String? guest;

  Jurys(
      {this.examiners,
      this.supervisor,
      this.coSupervisor,
      this.president,
      this.guest});

  Jurys.fromJson(Map<String, dynamic> json) {
    if (json['examiners'] != null) {
      examiners = <Examiners>[];
      json['examiners'].forEach((v) {
        examiners!.add(Examiners.fromJson(v));
      });
    }
    supervisor = json['supervisor'] != null
        ? Examiners.fromJson(json['supervisor'])
        : null;
    coSupervisor = json['co_supervisor'] != null
        ? Examiners.fromJson(json['co_supervisor'])
        : null;
    president = json['president'] != null
        ? Examiners.fromJson(json['president'])
        : null;
    guest = json['guest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (examiners != null) {
      data['examiners'] = examiners!.map((v) => v.toJson()).toList();
    }
    if (supervisor != null) {
      data['supervisor'] = supervisor!.toJson();
    }
    if (coSupervisor != null) {
      data['co_supervisor'] = coSupervisor!.toJson();
    }
    if (president != null) {
      data['president'] = president!.toJson();
    }
    data['guest'] = guest;
    return data;
  }
}

class Examiners {
  String? email;
  String? photoUrl;
  int? id;

  Examiners({this.email, this.photoUrl, this.id});

  Examiners.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    photoUrl = json['photo_url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['photo_url'] = photoUrl;
    data['id'] = id;
    return data;
  }
}

class RoomsNewDefense {
  bool? success;
  String? message;
  Dataa? data;

  RoomsNewDefense({this.success, this.message, this.data});

  RoomsNewDefense.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Dataa.fromJson(json['data']) : null;
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

class Dataa {
  List<Roomss>? rooms;

  Dataa({this.rooms});

  Dataa.fromJson(Map<String, dynamic> json) {
    if (json['rooms'] != null) {
      rooms = <Roomss>[];
      json['rooms'].forEach((v) {
        rooms!.add(Roomss.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rooms != null) {
      data['rooms'] = rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roomss {
  int? id;
  String? name;
  int? establishmentId;
  String? createdAt;
  String? updatedAt;

  Roomss(
      {this.id,
      this.name,
      this.establishmentId,
      this.createdAt,
      this.updatedAt});

  Roomss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    establishmentId = json['establishment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['establishment_id'] = establishmentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
