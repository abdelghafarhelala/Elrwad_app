class MainServicesModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<ServesData>? data;

  MainServicesModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  MainServicesModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    if (json['data'] != null) {
      data = <ServesData>[];
      json['data'].forEach((v) {
        data!.add(ServesData.fromJson(v));
      });
    }
  }
}

class ServesData {
  int? id;
  int? type;
  int? categoryId;
  int? ord;
  String? name;
  String? img;
  String? imgThumbnail;
  String? details;
  String? detailsEn;
  int? numViews;

  ServesData(
      {this.id,
      this.type,
      this.categoryId,
      this.ord,
      this.name,
      this.img,
      this.imgThumbnail,
      this.details,
      this.detailsEn,
      this.numViews});

  ServesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    categoryId = json['category_id'];
    ord = json['ord'];
    name = json['name'];
    img = json['img'];
    imgThumbnail = json['img_thumbnail'];
    details = json['details'];
    detailsEn = json['details_en'];
    numViews = json['num_views'];
  }
}
