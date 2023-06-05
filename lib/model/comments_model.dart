import 'package:startease/model/user_model.dart';

class CommentsModel {
  bool? success;
  String? message;
  Data? data;

  CommentsModel({this.success, this.message, this.data});

  CommentsModel.fromJson(Map<String, dynamic> json) {
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
  List<Comments>? comments;

  Data({this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  int? id;
  String? content;
  UserModel? user;
  List<Replies>? replies;
  String? createdAt;
  String? updatedAt;

  Comments(
      {this.id,
      this.content,
      this.user,
      this.replies,
      this.createdAt,
      this.updatedAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    user = json['user'] != null
        ? new UserModel.fromJsonComments(json['user'])
        : null;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  Map<String, dynamic> postCommentToJson(String projectID) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project_id'] = projectID;
    data['content'] = content;

    return data;
  }

  Map<String, dynamic> putCommentToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
     data['content'] = content;

    return data;
  }
}

class Replies {
  int? id;
  String? content;
  UserModel? user;
  List<Replies>? replies;
  String? createdAt;
  String? updatedAt;

  Replies(
      {this.id,
      this.content,
      this.user,
      this.replies,
      this.createdAt,
      this.updatedAt});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    user = json['user'] != null
        ? new UserModel.fromJsonComments(json['user'])
        : null;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        // replies!.add(new Null.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.replies != null) {
      //  data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  Map<String, dynamic> postReplyToJson(String projectID) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parent_id'] = projectID;
    data['content'] = content;

    return data;
  }

 
}
