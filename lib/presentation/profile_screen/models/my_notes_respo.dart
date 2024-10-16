class MyNotesRespo {
  String? status;
  List<NotesData>? data;

  MyNotesRespo({this.status, this.data});

  MyNotesRespo.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    if (json['data'] != null) {
      data = <NotesData>[];
      json['data'].forEach((v) {
        data!.add(new NotesData.fromJson(v));
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

class NotesData {
  String? category;
  List<ListItem>? list;

  NotesData({this.category, this.list});

  NotesData.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['list'] != null) {
      list = <ListItem>[];
      json['list'].forEach((v) {
        list!.add(new ListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListItem {
  int? id;
  int? userId;
  int? type;
  int? statementId;
  String? data;
  String? verseStatement;
  List<String>? markedData;
  String? bibleName;
  String? testamentName;
  String? bookName;
  String? chapterName;
  int? verseNo;

  ListItem(
      {this.id,
      this.userId,
      this.type,
      this.statementId,
      this.data,
      this.verseStatement,
      this.markedData,
      this.bibleName,
      this.testamentName,
      this.bookName,
      this.chapterName,
      this.verseNo});

  ListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    statementId = json['statement_id'];
    data = json['data'];
    verseStatement = json['verse_statement'];
    markedData = json['marked_data'].cast<String>();
    bibleName = json['bible_name'];
    testamentName = json['testament_name'];
    bookName = json['book_name'];
    chapterName = json['chapter_name'];
    verseNo = json['verse_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['statement_id'] = this.statementId;
    data['data'] = this.data;
    data['verse_statement'] = this.verseStatement;
    data['marked_data'] = this.markedData;
    data['bible_name'] = this.bibleName;
    data['testament_name'] = this.testamentName;
    data['book_name'] = this.bookName;
    data['chapter_name'] = this.chapterName;
    data['verse_no'] = this.verseNo;
    return data;
  }
}
