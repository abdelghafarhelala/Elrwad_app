class DoctorsModel {
  bool? success;
  int? status;
  List<Results>? results;

  DoctorsModel({this.success, this.status, this.results});

  DoctorsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }
}

class Results {
  int? id;
  String? name;
  String? nameEn;
  int? categoryId;
  String? jobTitle;
  String? appointments;
  String? adress;
  String? img;
  String? details;

  Results(
      {this.id,
      this.name,
      this.nameEn,
      this.categoryId,
      this.jobTitle,
      this.appointments,
      this.adress,
      this.img,
      this.details});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    categoryId = json['category_id'];
    jobTitle = json['job_title'];
    appointments = json['appointments'];
    adress = json['adress'];
    img = json['img'];
    details = json['details'];
  }
}
