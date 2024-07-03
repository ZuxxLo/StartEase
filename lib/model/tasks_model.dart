class TasksModel {
  bool? success;
  String? message;
  Data? data;

  TasksModel({this.success, this.message, this.data});

  TasksModel.fromJson(Map<String, dynamic> json) {
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
  List<Tasks>? tasks;

  Data({this.tasks});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
  int? id;
  String? title;
  String? description;
  String? deadline;
  String? status;
  String? submissionDate;
  String? submissionDescription;
  String? completedDate;
  Map<String, dynamic>? resources;
  int? projectId;
  String? createdAt;
  String? updatedAt;

  Tasks(
      {this.id,
      this.title,
      this.description,
      this.deadline,
      this.status,
      this.submissionDate,
      this.submissionDescription,
      this.completedDate,
      this.resources,
      this.projectId,
      this.createdAt,
      this.updatedAt});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    deadline = json['deadline'];
    status = json['status'];
    submissionDate = json['submission_date'];
    submissionDescription = json['submission_description'];
    completedDate = json['completed_date'];
    resources = json['resources'] != null ? (json['resources']) : null;
    projectId = json['project_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['deadline'] = deadline;
    data['status'] = status;
    data['submission_date'] = submissionDate;
    data['submission_description'] = submissionDescription;
    data['completed_date'] = completedDate;
    if (resources != null) {
      data['resources'] = resources;
    }
    data['project_id'] = projectId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  Map<String, dynamic> postTaskToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['deadline'] = deadline;
    data['resources'] = resources!.keys.toList();

    return data;
  }

  Map<String, dynamic> putTaskToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
     data['title'] = title;
    data['description'] = description;
    data['deadline'] = deadline;
    data['resources'] = resources!.keys.toList();

    return data;
  }
}
