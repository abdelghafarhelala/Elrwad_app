class SliderModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<Sliders>? data;

  SliderModel({this.result, this.errorMessage, this.errorMessageEn, this.data});

  SliderModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    if (json['data'] != null) {
      data = <Sliders>[];
      json['data'].forEach((v) {
        data!.add(Sliders.fromJson(v));
      });
    }
  }
}

class Sliders {
  int? id;
  int? ord;
  String? type;
  String? name;
  String? img;
  String? urlL;
  int? withId;

  Sliders(
      {this.id,
      this.ord,
      this.type,
      this.name,
      this.img,
      this.urlL,
      this.withId});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ord = json['ord'];
    type = json['type'];
    name = json['name'];
    img = json['img'];
    urlL = json['url_l'];
    withId = json['with_id'];
  }
}
