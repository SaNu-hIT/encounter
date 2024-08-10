class CourseDayDetailRespo {
  String? status;
  List<Data>? data;

  CourseDayDetailRespo({this.status,  this.data});

  CourseDayDetailRespo.fromJson(Map<String, dynamic> json) {
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
  int? courseId;
  int? day;
  String? textDescription;
  String? videoLink;
  dynamic? audioFile;
  String? spotifyLink;
  String? websiteLink;
  String? image;
  dynamic? documents;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? courseName;
  String? bibleName;
  List<CourseDayVerse>? courseDayVerse;

  Data(
      {this.id,
      this.courseId,
      this.day,
      this.textDescription,
      this.videoLink,
      this.audioFile,
      this.spotifyLink,
      this.websiteLink,
      this.image,
      this.documents,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.courseName,
      this.bibleName,
      this.courseDayVerse});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    day = json['day'];
    textDescription = json['text_description'];
    videoLink = json['video_link'];
    audioFile = json['audio_file'];
    spotifyLink = json['spotify_link'];
    websiteLink = json['website_link'];
    image = json['image'];
    documents = json['documents'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseName = json['course_name'];
    bibleName = json['bible_name'];
    if (json['course_day_verse'] != null) {
      courseDayVerse = <CourseDayVerse>[];
      json['course_day_verse'].forEach((v) {
        courseDayVerse!.add(new CourseDayVerse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['day'] = this.day;
    data['text_description'] = this.textDescription;
    data['video_link'] = this.videoLink;
    data['audio_file'] = this.audioFile;
    data['spotify_link'] = this.spotifyLink;
    data['website_link'] = this.websiteLink;
    data['image'] = this.image;
    data['documents'] = this.documents;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['course_name'] = this.courseName;
    data['bible_name'] = this.bibleName;
    if (this.courseDayVerse != null) {
      data['course_day_verse'] =
          this.courseDayVerse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseDayVerse {
  int? id;
  int? courseContentId;
  int? testament;
  int? book;
  int? chapter;
  int? verseFrom;
  int? verseTo;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? testamentName;
  String? bookName;
  String? chapterName;
  String? verseFromName;
  String? verseToName;

  CourseDayVerse(
      {this.id,
      this.courseContentId,
      this.testament,
      this.book,
      this.chapter,
      this.verseFrom,
      this.verseTo,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.testamentName,
      this.bookName,
      this.chapterName,
      this.verseFromName,
      this.verseToName});

  CourseDayVerse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseContentId = json['course_content_id'];
    testament = json['testament'];
    book = json['book'];
    chapter = json['chapter'];
    verseFrom = json['verse_from'];
    verseTo = json['verse_to'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    testamentName = json['testament_name'];
    bookName = json['book_name'];
    chapterName = json['chapter_name'];
    verseFromName = json['verse_from_name'];
    verseToName = json['verse_to_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_content_id'] = this.courseContentId;
    data['testament'] = this.testament;
    data['book'] = this.book;
    data['chapter'] = this.chapter;
    data['verse_from'] = this.verseFrom;
    data['verse_to'] = this.verseTo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['testament_name'] = this.testamentName;
    data['book_name'] = this.bookName;
    data['chapter_name'] = this.chapterName;
    data['verse_from_name'] = this.verseFromName;
    data['verse_to_name'] = this.verseToName;
    return data;
  }
}
