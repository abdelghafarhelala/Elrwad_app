class ProfileModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Data? data;

  ProfileModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  int? userTypeId;
  int? roleId;
  Null? memberPlan;
  String? name;
  Null? lastName;
  Null? userName;
  String? mobile;
  String? email;
  Null? emailVerifiedAt;
  Null? currentTeamId;
  Null? profilePhotoPath;
  var columnsNeedApprove;
  String? activitationCode;
  String? isConnect;
  Null? lastConnectedAt;
  String? onesignalId;
  int? userBalance;
  String? userLang;
  int? changeUserType;
  String? isActive;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? profilePhotoUrl;
  Null? userDetail;

  Data(
      {this.id,
      this.userTypeId,
      this.roleId,
      this.memberPlan,
      this.name,
      this.lastName,
      this.userName,
      this.mobile,
      this.email,
      this.emailVerifiedAt,
      this.currentTeamId,
      this.profilePhotoPath,
      this.columnsNeedApprove,
      this.activitationCode,
      this.isConnect,
      this.lastConnectedAt,
      this.onesignalId,
      this.userBalance,
      this.userLang,
      this.changeUserType,
      this.isActive,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.profilePhotoUrl,
      this.userDetail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userTypeId = json['user_type_id'];
    roleId = json['role_id'];
    memberPlan = json['member_plan'];
    name = json['name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    mobile = json['mobile'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    columnsNeedApprove = json['columns_need_approve'];
    activitationCode = json['activitation_code'];
    isConnect = json['is_connect'];
    lastConnectedAt = json['last_connected_at'];
    onesignalId = json['onesignal_id'];
    userBalance = json['user_balance'];
    userLang = json['user_lang'];
    changeUserType = json['change_user_type'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhotoUrl = json['profile_photo_url'];
    userDetail = json['user_detail'];
  }
}
