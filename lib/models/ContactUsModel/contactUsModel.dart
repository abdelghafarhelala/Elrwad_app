class contactUsModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;

  contactUsModel({this.result, this.errorMessage, this.errorMessageEn});

  contactUsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
  }
}
