class GotQuestionModel {
  String? status;
  Metadata? metadata;
  List<QuestionData>? data;

  GotQuestionModel({this.status, this.metadata, this.data});

  GotQuestionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    if (json['data'] != null) {
      data = <QuestionData>[];
      json['data'].forEach((v) {
        data!.add(new QuestionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Metadata {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  Null? nextPageUrl;
  Null? prevPageUrl;
  int? from;
  int? to;

  Metadata(
      {this.total,
      this.perPage,
      this.currentPage,
      this.lastPage,
      this.nextPageUrl,
      this.prevPageUrl,
      this.from,
      this.to});

  Metadata.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['next_page_url'] = this.nextPageUrl;
    data['prev_page_url'] = this.prevPageUrl;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}

class QuestionData {
  int? id;
  String? question;
  int? categoryId;
  int? subCategoryId;
  String? answer;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? categoryName;
  String? subCategoryName;

  QuestionData(
      {this.id,
      this.question,
      this.categoryId,
      this.subCategoryId,
      this.answer,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.categoryName,
      this.subCategoryName});

  QuestionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    answer = json['answer'];
    status = json['status'];
    createdAt = json['date_of_question'];
    updatedAt = json['updated_at'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['answer'] = this.answer;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_name'] = this.categoryName;
    data['sub_category_name'] = this.subCategoryName;
    return data;
  }
}
