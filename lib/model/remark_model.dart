import 'package:startease/model/user_model.dart';

class Remark {
  int? id;
  String? content;
  UserModel? user;
  var createdAt;
  var updatedAt;

  Remark({this.id, this.content, this.user, this.createdAt, this.updatedAt});

  Remark.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    user = json['user'] != null ? UserModel.fromJsonS(json['user']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  Map<String, dynamic> postRemarkToJson(String projectID) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project_id'] = projectID;
    data['content'] = content;

    return data;
  }

  Map<String, dynamic> putRemarkToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;

    return data;
  }
}
