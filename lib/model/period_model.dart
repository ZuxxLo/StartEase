class PeriodsModel {
  bool? success;
  String? message;
  Data? data;

  PeriodsModel({this.success, this.message, this.data});

  PeriodsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Period>? periods;

  Data({this.periods});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['periods'] != null) {
      periods = <Period>[];
      json['periods'].forEach((v) {
        periods!.add(new Period.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (periods != null) {
      data['periods'] = periods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Period {
  int? id;
  String? name;
  String? startDate;
  String? endDate;

  Period({this.id, this.name, this.startDate, this.endDate});

  Period.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }

  Map<String, dynamic> toJsonUpdate() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['period'] = id;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}
