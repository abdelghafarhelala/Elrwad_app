class CategoryModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<Data>? data;

  CategoryModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  int? ord;
  String? type;
  int? parentId;
  String? name;
  String? img;
  String? details;

  Data(
      {this.id,
      this.ord,
      this.type,
      this.parentId,
      this.name,
      this.img,
      this.details});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ord = json['ord'];
    type = json['type'];
    parentId = json['parent_id'];
    name = json['name'];
    img = json['img'];
    details = json['details'];
  }
}
