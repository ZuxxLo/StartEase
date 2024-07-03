import 'package:get/get.dart';
import 'package:startease/model/tasks_model.dart';
import 'package:startease/model/user_model.dart';

import 'comments_model.dart';
import 'remark_model.dart';

class ProjectsModel {
  bool? success;
  String? message;
  Data? data;

  ProjectsModel({this.success, this.message, this.data});

  ProjectsModel.fromJson(Map<String, dynamic> json) {
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
  ProjectModel? project;
  List<ProjectModel>? projects;

  Data({this.project, this.projects});

  Data.fromJson(Map<String, dynamic> json) {
    print("**************************************");
    print(json['project']);
    print("**************************************");

    if (json['projects'] != null) {
      projects = <ProjectModel>[];

      json['projects'].forEach((v) {
        projects!.add(ProjectModel.fromJson(v));
      });
    } else if (json['project'] != null && json['projects'] == null) {
      projects = <ProjectModel>[];

      projects!.add(ProjectModel.fromJson(json['project']));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project'] = project;
    if (projects != null) {
      data['projects'] = projects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

enum ProjectType { diplomaStartUp, diplomaPatent }

class ProjectModel {
  int? id;
  String? type;
  String? trademarkName;
  String? scientificName;
  String? resume;
  String? status;
  Establishment? establishment;
  UserModel? projectHolder;
  UserModel? supervisor;
  UserModel? coSupervisor;
  List<UserModel>? members;
  List<Remark>? remakrs;
  List<Comments>? comments;
  List<Tasks>? tasks;
  int? defenceId;
  Map<dynamic, dynamic>? files;
  Map? progress;
  bool? isAuthorizedDefence;

  ProjectModel(
      {this.id,
      this.type,
      this.trademarkName,
      this.scientificName,
      this.resume,
      this.status,
      this.establishment,
      this.defenceId,
      this.projectHolder,
      this.supervisor,
      this.coSupervisor,
      this.members,
      this.remakrs,
      this.comments,
      this.tasks,
      this.files,
      this.progress,
      this.isAuthorizedDefence});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    trademarkName = json['trademark_name'];
    scientificName = json['scientific_name'];
    resume = json['resume'];
    status = json['status'];
    defenceId = json["defence_id"];
    establishment = json['establishment'] != null
        ? Establishment.fromJson(json['establishment'])
        : null;
    projectHolder = json['project_holder'] != null
        ? UserModel.fromJsonS(json['project_holder'])
        : null;
    supervisor = json['supervisor'] != null
        ? UserModel.fromJsonS(json['supervisor'])
        : null;
    coSupervisor = json['co_supervisor'] != null
        ? UserModel.fromJsonS(json['co_supervisor'])
        : null;
    if (json['members'] != null) {
      members = <UserModel>[];
      json['members'].forEach((v) {
        members!.add(UserModel.fromJsonS(v));
      });
    }
    if (json['remakrs'] != null) {
      remakrs = <Remark>[];
      json['remakrs'].forEach((v) {
        remakrs!.add(Remark.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = json['files'];
    }
    if (json['files'] != null) {
     }

    isAuthorizedDefence = json['is_authorized_defence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (type == "diplomaStartUp".tr) {
      data['type'] = "Un diplôme-Une startup";
    } else if (type == "diplomaPatent".tr) {
      data['type'] = "Un diplôme-Un Brevet";
    }
    data['trademark_name'] = trademarkName;
    data['scientific_name'] = scientificName;
    data['resume'] = resume;
    if (status != null) {
      data['status'] = status;
    }
    if (establishment != null) {
      data['establishment'] = establishment!.toJson();
    }
    if (projectHolder != null) {
      data['project_holder'] = projectHolder!.toJson();
    }
    if (supervisor != null) {
      data['supervisor'] = supervisor!.email;
    }
    if (coSupervisor != null) {
      data['co_supervisor'] = coSupervisor!.email;
    }
    if (members != null) {
      data['members'] = members!.map((v) => v.email).toList();
    }

    if (remakrs != null) {
      data['remakrs'] = remakrs!.map((v) => v.toJson()).toList();
    }
    if (files != null) {
      data['files'] = files!;
    }
    if (progress != null) {
      data['progress'] = progress!;
    }
    if (isAuthorizedDefence != null) {
      data['isAuthorizedDefence'] = isAuthorizedDefence!;
    }
    return data;
  }

  Map<String, dynamic> updateStatustoJson(String? newStatus) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project'] = id.toString();

    if (newStatus?.toLowerCase() == "validated".tr.toLowerCase()) {
      data['status'] = "accepted";
    } else if (newStatus?.toLowerCase() == "pending".tr.toLowerCase()) {
      data['status'] = "pending";
    } else if (newStatus?.toLowerCase() == "refused".tr.toLowerCase()) {
      data['status'] = "refused";
    } else if (newStatus?.toLowerCase() == "recourse".tr.toLowerCase()) {
      data['status'] = "recourse";
    } else if (newStatus?.toLowerCase() ==
        "recourse_validated".tr.toLowerCase()) {
      data['status'] = "validated after recourse";
    } else if (newStatus?.toLowerCase() ==
        "recourse_refused".tr.toLowerCase()) {
      data['status'] = "refused after recourse";
    } else {
      data['status'] = "error";
    }
    print(newStatus);
    print(data['status']);
    return data;
  }

  Map<String, dynamic> putProjectToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['trademark_name'] = trademarkName;
    data['scientific_name'] = scientificName;
    data['resume'] = resume;
    data['supervisor'] = supervisor;
    data['co_supervisor'] = coSupervisor;
    data['members'] = members;
    data['files_types'] = [];

    return data;
  }
}
