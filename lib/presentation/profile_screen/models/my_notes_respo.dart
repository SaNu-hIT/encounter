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
  int? id;
  int? userId;
  int? bibleId;
  int? testamentId;
  int? bookId;
  int? chapterId;
  int? verseId;
  String? note;
  String? category;
  String? subCategory;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? userName;
  String? bibleName;
  String? testamentName;
  String? bookName;
  String? chapterName;
  int? verseNo;

  NotesData(
      {this.id,
      this.userId,
      this.bibleId,
      this.testamentId,
      this.bookId,
      this.chapterId,
      this.verseId,
      this.note,
      this.category,
      this.subCategory,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userName,
      this.bibleName,
      this.testamentName,
      this.bookName,
      this.chapterName,
      this.verseNo});

  NotesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bibleId = json['bible_id'];
    testamentId = json['testament_id'];
    bookId = json['book_id'];
    chapterId = json['chapter_id'];
    verseId = json['verse_id'];
    note = json['note'];
    category = json['category'];
    subCategory = json['sub_category'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userName = json['user_name'];
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
    data['bible_id'] = this.bibleId;
    data['testament_id'] = this.testamentId;
    data['book_id'] = this.bookId;
    data['chapter_id'] = this.chapterId;
    data['verse_id'] = this.verseId;
    data['note'] = this.note;
    data['category'] = this.category;
    data['sub_category'] = this.subCategory;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_name'] = this.userName;
    data['bible_name'] = this.bibleName;
    data['testament_name'] = this.testamentName;
    data['book_name'] = this.bookName;
    data['chapter_name'] = this.chapterName;
    data['verse_no'] = this.verseNo;
    return data;
  }
}
