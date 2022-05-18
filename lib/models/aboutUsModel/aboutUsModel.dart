class AboutUsModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Data? data;

  AboutUsModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? nameEn;
  String? img;
  String? details;
  String? detailsEn;

  Data(
      {this.id,
      this.name,
      this.nameEn,
      this.img,
      this.details,
      this.detailsEn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    img = json['img'];
    details = json['details'];
    detailsEn = json['details_en'];
  }
}
