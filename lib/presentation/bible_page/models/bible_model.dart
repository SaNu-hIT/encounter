class BibleListModel {
  String? status;
  List<Null>? metadata;
  List<BibileData>? data;

  BibleListModel({this.status, this.metadata, this.data});

  BibleListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    if (json['data'] != null) {
      data = <BibileData>[];
      json['data'].forEach((v) {
        data!.add(new BibileData.fromJson(v));
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

class BibileData {
  int? bookId;
  dynamic bookName;
  dynamic totalChapters;
  List<Chapters>? chapters;
  bool isExpanded = false;

  BibileData({this.bookId, this.bookName, this.totalChapters, this.chapters});

  BibileData.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    bookName = json['book_name'];
    totalChapters = json['total_chapters'];
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['book_name'] = this.bookName;
    data['total_chapters'] = this.totalChapters;
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapters {
  dynamic? chapterId;
  dynamic? chapterNumber;
  List<Statements>? statements;

  Chapters({this.chapterId, this.chapterNumber, this.statements});

  Chapters.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapter_id'];
    chapterNumber = json['chapter_number'];
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
    data['chapter_number'] = this.chapterNumber;
    if (this.statements != null) {
      data['statements'] = this.statements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statements {
  dynamic? statementId;
  dynamic? statementNo;
  dynamic? statementHeading;
  dynamic? statementText;

  bool isExpanded = false;
  Statements(
      {this.statementId,
      this.statementNo,
      this.statementHeading,
      this.statementText});

  Statements.fromJson(Map<String, dynamic> json) {
    statementId = json['statement_id'];
    statementNo = json['statement_no'];
    statementHeading = json['statement_heading'];
    statementText = json['statement_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statement_id'] = this.statementId;
    data['statement_no'] = this.statementNo;
    data['statement_heading'] = this.statementHeading;
    data['statement_text'] = this.statementText;
    return data;
  }
}
