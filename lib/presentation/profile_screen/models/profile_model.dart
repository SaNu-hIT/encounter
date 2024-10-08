class ProfileResponse {
  String? status;
  List<Null>? metadata;
  Data? data;

  ProfileResponse({this.status, this.metadata, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  dynamic? lastName;
  String? gender;
  dynamic? age;
  dynamic? location;
  dynamic? image;
  dynamic? deviceType;
  dynamic? ip;
  dynamic? deviceId;
  dynamic? refreshToken;
  dynamic? appUsage;
  dynamic? browser;
  String? lastAccessed;
  String? email;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic? deletedAt;
  String? userName;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.gender,
      this.age,
      this.location,
      this.image,
      this.deviceType,
      this.ip,
      this.deviceId,
      this.refreshToken,
      this.appUsage,
      this.browser,
      this.lastAccessed,
      this.email,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.userName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    age = json['age'];
    location = json['location'];
    image = json['image'];
    deviceType = json['device_type'];
    ip = json['ip'];
    deviceId = json['device_id'];
    refreshToken = json['refresh_token'];
    appUsage = json['app_usage'];
    browser = json['browser'];
    lastAccessed = json['last_accessed'];
    email = json['email'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['location'] = this.location;
    data['image'] = this.image;
    data['device_type'] = this.deviceType;
    data['ip'] = this.ip;
    data['device_id'] = this.deviceId;
    data['refresh_token'] = this.refreshToken;
    data['app_usage'] = this.appUsage;
    data['browser'] = this.browser;
    data['last_accessed'] = this.lastAccessed;
    data['email'] = this.email;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['user_name'] = this.userName;
    return data;
  }
}
