class CourseDayDetailRespo {
  String? status;
  Data? data;

  CourseDayDetailRespo({this.status, this.data});

  CourseDayDetailRespo.fromJson(Map<String, dynamic> json) {
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
  int? courseId;
  int? day;
  String? textDescription;
  dynamic? audioFile;
  String? websiteLink;
  dynamic? image;
  dynamic? documents;
  String? courseName;
  String? bibleName;
  List<CourseDayVerse>? courseDayVerse;
  List<CourseContentVideoLink>? courseContentVideoLink;
  List<CourseContentVideoLink>? courseContentSpotifyLink;

  Data(
      {this.id,
      this.courseId,
      this.day,
      this.textDescription,
      this.audioFile,
      this.websiteLink,
      this.image,
      this.documents,
      this.courseName,
      this.bibleName,
      this.courseDayVerse,
      this.courseContentVideoLink,
      this.courseContentSpotifyLink});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    day = json['day'];
    textDescription = json['text_description'];
    audioFile = json['audio_file'];
    websiteLink = json['website_link'];
    image = json['image'];
    documents = json['documents'];
    courseName = json['course_name'];
    bibleName = json['bible_name'];
    if (json['course_day_verse'] != null) {
      courseDayVerse = <CourseDayVerse>[];
      json['course_day_verse'].forEach((v) {
        courseDayVerse!.add(new CourseDayVerse.fromJson(v));
      });
    }
    if (json['course_content_video_link'] != null) {
      courseContentVideoLink = <CourseContentVideoLink>[];
      json['course_content_video_link'].forEach((v) {
        courseContentVideoLink!.add(new CourseContentVideoLink.fromJson(v));
      });
    }
    if (json['course_content_spotify_link'] != null) {
      courseContentSpotifyLink = <CourseContentVideoLink>[];
      json['course_content_spotify_link'].forEach((v) {
        courseContentSpotifyLink!.add(new CourseContentVideoLink.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['day'] = this.day;
    data['text_description'] = this.textDescription;
    data['audio_file'] = this.audioFile;
    data['website_link'] = this.websiteLink;
    data['image'] = this.image;
    data['documents'] = this.documents;
    data['course_name'] = this.courseName;
    data['bible_name'] = this.bibleName;
    if (this.courseDayVerse != null) {
      data['course_day_verse'] =
          this.courseDayVerse!.map((v) => v.toJson()).toList();
    }
    if (this.courseContentVideoLink != null) {
      data['course_content_video_link'] =
          this.courseContentVideoLink!.map((v) => v.toJson()).toList();
    }
    if (this.courseContentSpotifyLink != null) {
      data['course_content_spotify_link'] =
          this.courseContentSpotifyLink!.map((v) => v.toJson()).toList();
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
  List<Statements>? statements;
  String? testamentName;
  String? bookName;
  String? chapterName;
  int? chapterNo;
  int? verseFromName;
  int? verseToName;

  CourseDayVerse(
      {this.id,
      this.courseContentId,
      this.testament,
      this.book,
      this.chapter,
      this.verseFrom,
      this.verseTo,
      this.statements,
      this.testamentName,
      this.bookName,
      this.chapterName,
      this.chapterNo,
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
    if (json['statements'] != null) {
      statements = <Statements>[];
      json['statements'].forEach((v) {
        statements!.add(new Statements.fromJson(v));
      });
    }
    testamentName = json['testament_name'];
    bookName = json['book_name'];
    chapterName = json['chapter_name'];
    chapterNo = json['chapter_no'];
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
    if (this.statements != null) {
      data['statements'] = this.statements!.map((v) => v.toJson()).toList();
    }
    data['testament_name'] = this.testamentName;
    data['book_name'] = this.bookName;
    data['chapter_name'] = this.chapterName;
    data['chapter_no'] = this.chapterNo;
    data['verse_from_name'] = this.verseFromName;
    data['verse_to_name'] = this.verseToName;
    return data;
  }
}

class Statements {
  dynamic? statementNo;
  String? statementText;
  bool isSelected = false;
  Statements({this.statementNo, this.statementText});

  Statements.fromJson(Map<String, dynamic> json) {
    statementNo = json['statement_no'];
    statementText = json['statement_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statement_no'] = this.statementNo;
    data['statement_text'] = this.statementText;
    return data;
  }
}

class CourseContentVideoLink {
  int? id;
  int? courseContentId;
  int? type;
  String? videoSpotifyLink;
  String? status;
  String? createdAt;
  String? updatedAt;

  CourseContentVideoLink(
      {this.id,
      this.courseContentId,
      this.type,
      this.videoSpotifyLink,
      this.status,
      this.createdAt,
      this.updatedAt});

  CourseContentVideoLink.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseContentId = json['course_content_id'];
    type = json['type'];
    videoSpotifyLink = json['video_spotify_link'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_content_id'] = this.courseContentId;
    data['type'] = this.type;
    data['video_spotify_link'] = this.videoSpotifyLink;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}




// import 'dart:ffi';

// class CourseDayDetailRespo {
//   String? status;
//   List<Null>? metadata;
//   Data? data;

//   CourseDayDetailRespo({this.status, this.metadata, this.data});

//   CourseDayDetailRespo.fromJson(Map<String, dynamic> json) {
//     status = json['status'];

//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;

//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   int? id;
//   int? courseId;
//   int? day;
//   String? textDescription;
//   dynamic? videoLink;
//   dynamic? audioFile;
//   dynamic? spotifyLink;
//   dynamic? websiteLink;
//   dynamic? image;
//   dynamic? documents;
//   String? courseName;
//   String? bibleName;
//   List<CourseDayVerse>? courseDayVerse;

//   Data(
//       {this.id,
//       this.courseId,
//       this.day,
//       this.textDescription,
//       this.videoLink,
//       this.audioFile,
//       this.spotifyLink,
//       this.websiteLink,
//       this.image,
//       this.documents,
//       this.courseName,
//       this.bibleName,
//       this.courseDayVerse});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     courseId = json['course_id'];
//     day = json['day'];
//     textDescription = json['text_description'];
//     videoLink = json['video_link'];
//     audioFile = json['audio_file'];
//     spotifyLink = json['spotify_link'];
//     websiteLink = json['website_link'];
//     image = json['image'];
//     documents = json['documents'];
//     courseName = json['course_name'];
//     bibleName = json['bible_name'];
//     if (json['course_day_verse'] != null) {
//       courseDayVerse = <CourseDayVerse>[];
//       json['course_day_verse'].forEach((v) {
//         courseDayVerse!.add(new CourseDayVerse.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['course_id'] = this.courseId;
//     data['day'] = this.day;
//     data['text_description'] = this.textDescription;
//     data['video_link'] = this.videoLink;
//     data['audio_file'] = this.audioFile;
//     data['spotify_link'] = this.spotifyLink;
//     data['website_link'] = this.websiteLink;
//     data['image'] = this.image;
//     data['documents'] = this.documents;
//     data['course_name'] = this.courseName;
//     data['bible_name'] = this.bibleName;
//     if (this.courseDayVerse != null) {
//       data['course_day_verse'] =
//           this.courseDayVerse!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class CourseDayVerse {
//   int? id;
//   int? courseContentId;
//   int? testament;
//   int? book;
//   int? chapter;
//   int? verseFrom;
//   int? verseTo;
//   List<Statements>? statements;
//   String? testamentName;
//   String? bookName;
//   String? chapterName;
//   int? chapterNo;
//   int? verseFromName;
//   int? verseToName;

//   CourseDayVerse(
//       {this.id,
//       this.courseContentId,
//       this.testament,
//       this.book,
//       this.chapter,
//       this.verseFrom,
//       this.verseTo,
//       this.statements,
//       this.testamentName,
//       this.bookName,
//       this.chapterName,
//       this.chapterNo,
//       this.verseFromName,
//       this.verseToName});

//   CourseDayVerse.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     courseContentId = json['course_content_id'];
//     testament = json['testament'];
//     book = json['book'];
//     chapter = json['chapter'];
//     verseFrom = json['verse_from'];
//     verseTo = json['verse_to'];
//     if (json['statements'] != null) {
//       statements = <Statements>[];
//       json['statements'].forEach((v) {
//         statements!.add(new Statements.fromJson(v));
//       });
//     }
//     testamentName = json['testament_name'];
//     bookName = json['book_name'];
//     chapterName = json['chapter_name'];
//     chapterNo = json['chapter_no'];
//     verseFromName = json['verse_from_name'];
//     verseToName = json['verse_to_name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['course_content_id'] = this.courseContentId;
//     data['testament'] = this.testament;
//     data['book'] = this.book;
//     data['chapter'] = this.chapter;
//     data['verse_from'] = this.verseFrom;
//     data['verse_to'] = this.verseTo;
//     if (this.statements != null) {
//       data['statements'] = this.statements!.map((v) => v.toJson()).toList();
//     }
//     data['testament_name'] = this.testamentName;
//     data['book_name'] = this.bookName;
//     data['chapter_name'] = this.chapterName;
//     data['chapter_no'] = this.chapterNo;
//     data['verse_from_name'] = this.verseFromName;
//     data['verse_to_name'] = this.verseToName;
//     return data;
//   }
// }

// class Statements {
//   String? statementNo;
//   String? statementText;
//   bool isSelected = false;

//   Statements({this.statementNo, this.statementText});

//   Statements.fromJson(Map<String, dynamic> json) {
//     statementNo = json['statement_no'];
//     statementText = json['statement_text'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statement_no'] = this.statementNo;
//     data['statement_text'] = this.statementText;
//     return data;
//   }
// }
