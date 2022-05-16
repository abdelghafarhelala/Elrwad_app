class BookingModel {
  bool? success;
  int? status;
  String? results;

  BookingModel({this.success, this.status, this.results});

  BookingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    results = json['results'];
  }
}
