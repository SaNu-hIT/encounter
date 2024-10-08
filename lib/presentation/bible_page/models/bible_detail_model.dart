class BibleDetailModel {
  String? status;
  List<ChapterData>? data;

  BibleDetailModel({this.status, this.data});

  BibleDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    if (json['data'] != null) {
      data = <ChapterData>[];
      json['data'].forEach((v) {
        data!.add(new ChapterData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChapterData {
  int? chapterId;
  int? chapterNo;
  String? chapterName;
  String? chapterDesc;
  int? bookId;
  int? userId;
  String? dateAdded;
  String? bookName;
  List<Statements>? statements;

  ChapterData(
      {this.chapterId,
      this.chapterNo,
      this.chapterName,
      this.chapterDesc,
      this.bookId,
      this.userId,
      this.dateAdded,
      this.bookName,
      this.statements});

  ChapterData.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapter_id'];
    chapterNo = json['chapter_no'];
    chapterName = json['chapter_name'];
    chapterDesc = json['chapter_desc'];
    bookId = json['book_id'];
    userId = json['user_id'];
    dateAdded = json['date_added'];
    bookName = json['book_name'];
    if (json['statements'] != null) {
      statements = <Statements>[];
      json['statements'].forEach((v) {
        statements!.add(new Statements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_id'] = this.chapterId;
    data['chapter_no'] = this.chapterNo;
    data['chapter_name'] = this.chapterName;
    data['chapter_desc'] = this.chapterDesc;
    data['book_id'] = this.bookId;
    data['user_id'] = this.userId;
    data['date_added'] = this.dateAdded;
    data['book_name'] = this.bookName;
    if (this.statements != null) {
      data['statements'] = this.statements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statements {
  int? statementId;
  String? statementText;

  Statements({this.statementId, this.statementText});

  Statements.fromJson(Map<String, dynamic> json) {
    statementId = json['statement_id'];
    statementText = json['statement_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statement_id'] = this.statementId;
    data['statement_text'] = this.statementText;
    return data;
  }
}
