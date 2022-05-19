class CategoryModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<CategoryData>? data;

  CategoryModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
      });
    }
  }
}

class CategoryData {
  int? id;
  int? ord;
  String? type;
  int? parentId;
  String? name;
  String? img;
  String? details;
  List<Doctors>? doctors;

  CategoryData(
      {this.id,
      this.ord,
      this.type,
      this.parentId,
      this.name,
      this.img,
      this.details,
      this.doctors});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ord = json['ord'];
    type = json['type'];
    parentId = json['parent_id'];
    name = json['name'];
    img = json['img'];
    details = json['details'];
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(new Doctors.fromJson(v));
      });
    }
  }
}

class Doctors {
  int? id;
  String? name;
  String? nameEn;
  int? categoryId;
  String? jobTitle;
  Null? img;
  String? details;
  String? detailsEn;

  Doctors(
      {this.id,
      this.name,
      this.nameEn,
      this.categoryId,
      this.jobTitle,
      this.img,
      this.details,
      this.detailsEn});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    categoryId = json['category_id'];
    jobTitle = json['job_title'];
    img = json['img'];
    details = json['details'];
    detailsEn = json['details_en'];
  }
}
