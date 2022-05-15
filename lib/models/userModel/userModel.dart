class UserModel {
  bool? result;
  Success? success;
  Data? data;
  String? error_message;

  UserModel({this.result, this.error_message, this.success, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    error_message = json['error_message'];
    success =
        json['success'] != null ? Success.fromJson(json['success']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Success {
  String? token;

  Success({this.token});

  Success.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? mobile;
  String? activitationCode;

  Data({this.id, this.name, this.mobile, this.activitationCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    activitationCode = json['activitation_code'];
  }
}
