class SocialLinksModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<SocialMedia>? socialMedia;
  Settings? settings;

  SocialLinksModel(
      {this.result,
      this.errorMessage,
      this.errorMessageEn,
      this.socialMedia,
      this.settings});

  SocialLinksModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    if (json['social_media'] != null) {
      socialMedia = <SocialMedia>[];
      json['social_media'].forEach((v) {
        socialMedia!.add(new SocialMedia.fromJson(v));
      });
    }
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }
}

class SocialMedia {
  int? id;
  String? name;
  String? img;
  String? urlLink;

  SocialMedia({this.id, this.name, this.img, this.urlLink});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    urlLink = json['url_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['url_link'] = this.urlLink;
    return data;
  }
}

class Settings {
  int? id;
  String? name;
  String? nameEn;
  Null? country;
  String? img;
  Null? file;
  String? tel;
  String? mobile;
  String? email;
  Null? googleMap;
  Null? latitude;
  Null? longitude;
  Null? emailServer;
  String? address;
  String? addressEn;

  Settings(
      {this.id,
      this.name,
      this.nameEn,
      this.country,
      this.img,
      this.file,
      this.tel,
      this.mobile,
      this.email,
      this.googleMap,
      this.latitude,
      this.longitude,
      this.emailServer,
      this.address,
      this.addressEn});

  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    country = json['country'];
    img = json['img'];
    file = json['file'];
    tel = json['tel'];
    mobile = json['mobile'];
    email = json['email'];
    googleMap = json['google_map'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    emailServer = json['email_server'];
    address = json['address'];
    addressEn = json['address_en'];
  }
}
