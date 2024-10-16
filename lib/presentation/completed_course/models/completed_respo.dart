class CompletedRespo {
  String? status;
  List<Data>? data;

  CompletedRespo({this.status, this.data});

  CompletedRespo.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? data1;
  String? data2;
  String? image;
  int? batchId;
  String? data3;
  String? startDate;
  int? noOfDays;
  int? userLmsId;
  String? data4;
  String? data5;

  Data(
      {this.id,
      this.data1,
      this.data2,
      this.image,
      this.batchId,
      this.data3,
      this.startDate,
      this.noOfDays,
      this.userLmsId,
      this.data4,
      this.data5});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data1 = json['data1'];
    data2 = json['data2'];
    image = json['image'];
    batchId = json['batch_id'];
    data3 = json['data3'];
    startDate = json['start_date'];
    noOfDays = json['no_of_days'];
    userLmsId = json['user_lms_id'];
    data4 = json['data4'];
    data5 = json['data5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data1'] = this.data1;
    data['data2'] = this.data2;
    data['image'] = this.image;
    data['batch_id'] = this.batchId;
    data['data3'] = this.data3;
    data['start_date'] = this.startDate;
    data['no_of_days'] = this.noOfDays;
    data['user_lms_id'] = this.userLmsId;
    data['data4'] = this.data4;
    data['data5'] = this.data5;
    return data;
  }
}
