class AskQuestionRespo {
  String? status;
  List<Null>? metadata;
  Data? data;

  AskQuestionRespo({this.status, this.metadata, this.data});

  AskQuestionRespo.fromJson(Map<String, dynamic> json) {
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
