class CourseDetailRespo {
  String? status;
  List<Data>? data;

  CourseDetailRespo({this.status, this.data});

  CourseDetailRespo.fromJson(Map<String, dynamic> json) {
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
  String? courseName;
  int? noOfDays;
  String? description;
  String? thumbnail;
  String? courseCreator;
  String? courseCreatorImage;
  String? creatorDesignation;
  int? batchId;
  String? batchName;
  String? startDate;
  String? endDate;
  String? lastDate;
  String? introCommentary;
  String? introVideo;
  String? introAudio;
  bool? userEnrolled;
  List<CourseContents>? courseContents;

  Data(
      {this.id,
      this.courseName,
      this.noOfDays,
      this.description,
      this.thumbnail,
      this.courseCreator,
      this.courseCreatorImage,
      this.creatorDesignation,
      this.batchId,
      this.batchName,
      this.startDate,
      this.endDate,
      this.lastDate,
      this.introCommentary,
      this.introVideo,
      this.introAudio,
      this.userEnrolled,
      this.courseContents});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['course_name'];
    noOfDays = json['no_of_days'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    courseCreator = json['course_creator'];
    courseCreatorImage = json['course_creator_image'];
    creatorDesignation = json['creator_designation'];
    batchId = json['batch_id'];
    batchName = json['batch_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    lastDate = json['last_date'];
    introCommentary = json['intro_commentary'];
    introVideo = json['intro_video'];
    introAudio = json['intro_audio'];
    userEnrolled = json['user_enrolled'];
    if (json['course_contents'] != null) {
      courseContents = <CourseContents>[];
      json['course_contents'].forEach((v) {
        courseContents!.add(new CourseContents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_name'] = this.courseName;
    data['no_of_days'] = this.noOfDays;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    data['course_creator'] = this.courseCreator;
    data['course_creator_image'] = this.courseCreatorImage;
    data['creator_designation'] = this.creatorDesignation;
    data['batch_id'] = this.batchId;
    data['batch_name'] = this.batchName;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['last_date'] = this.lastDate;
    data['intro_commentary'] = this.introCommentary;
    data['intro_video'] = this.introVideo;
    data['intro_audio'] = this.introAudio;
    data['user_enrolled'] = this.userEnrolled;
    if (this.courseContents != null) {
      data['course_contents'] =
          this.courseContents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseContents {
  int? dayId;
  int? day;
  int? courseId;
  String? book;
  String? chapter;

  CourseContents(
      {this.dayId, this.day, this.courseId, this.book, this.chapter});

  CourseContents.fromJson(Map<String, dynamic> json) {
    dayId = json['day_id'];
    day = json['day'];
    courseId = json['course_id'];
    book = json['book'];
    chapter = json['chapter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day_id'] = this.dayId;
    data['day'] = this.day;
    data['course_id'] = this.courseId;
    data['book'] = this.book;
    data['chapter'] = this.chapter;
    return data;
  }
}
