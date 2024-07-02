class LoginModel {
  String? status;
  List<Null>? metadata;
  Data? data;

  LoginModel({this.status, this.metadata, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    // if (json['metadata'] != null) {
    //   metadata = <Null>[];
    //   json['metadata'].forEach((v) {
    //     metadata!.add(new Null.fromJson(v));
    //   });
    // }
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    // if (this.metadata != null ) {
    //   data['metadata'] = this.metadata!.map((v) => v?.toJson()).toList();
    // }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? messsage;

  Data({this.messsage});

  Data.fromJson(Map<String, dynamic> json) {
    messsage = json['messsage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messsage'] = this.messsage;
    return data;
  }
}
