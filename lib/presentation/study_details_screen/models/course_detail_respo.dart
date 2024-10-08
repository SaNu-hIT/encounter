class CourseDetailRespo {
  String? status;

  List<Data>? data;

  CourseDetailRespo({this.status,  this.data});

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
  String? creatorImage;
  String? creatorDesignation;
  String? introVideo;
  String? introAudio;
  String? introVideoThumb;
  int? batchId;
  String? batchName;
  String? startDate;
  String? endDate;
  String? lastDate;
  String? courseStartStatus;
  String? lastUpdatedData;
  int? completionPercentage;
  bool? userEnrolled;
  dynamic userLmsId;
  List<CourseContent>? courseContent;

  Data(
      {this.id,
      this.courseName,
      this.noOfDays,
      this.description,
      this.thumbnail,
      this.courseCreator,
      this.creatorImage,
      this.creatorDesignation,
      this.introVideo,
      this.introAudio,
      this.introVideoThumb,
      this.batchId,
      this.batchName,
      this.startDate,
      this.endDate,
      this.lastDate,
      this.courseStartStatus,
      this.lastUpdatedData,
      this.completionPercentage,
      this.userEnrolled,
      this.userLmsId,
      this.courseContent});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['course_name'];
    noOfDays = json['no_of_days'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    courseCreator = json['course_creator'];
    creatorImage = json['creator_image'];
    creatorDesignation = json['creator_designation'];
    introVideo = json['intro_video'];
    introAudio = json['intro_audio'];
    introVideoThumb = json['intro_video_thumb'];
    batchId = json['batch_id'];
    batchName = json['batch_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    lastDate = json['last_date'];
    courseStartStatus = json['course_start_status'];
    lastUpdatedData = json['last_updated_data'];
    completionPercentage = json['completion_percentage'];
    userEnrolled = json['user_enrolled'];
    userLmsId = json['user_lms_id'];
    if (json['course_content'] != null) {
      courseContent = <CourseContent>[];
      json['course_content'].forEach((v) {
        courseContent!.add(new CourseContent.fromJson(v));
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
    data['creator_image'] = this.creatorImage;
    data['creator_designation'] = this.creatorDesignation;
    data['intro_video'] = this.introVideo;
    data['intro_audio'] = this.introAudio;
    data['intro_video_thumb'] = this.introVideoThumb;
    data['batch_id'] = this.batchId;
    data['batch_name'] = this.batchName;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['last_date'] = this.lastDate;
    data['course_start_status'] = this.courseStartStatus;
    data['last_updated_data'] = this.lastUpdatedData;
    data['completion_percentage'] = this.completionPercentage;
    data['user_enrolled'] = this.userEnrolled;
    data['user_lms_id'] = this.userLmsId;
    if (this.courseContent != null) {
      data['course_content'] =
          this.courseContent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseContent {
  int? day;
  int? courseContentId;
  int? courseId;
  List<String>? details;
  bool? readStatus;

  CourseContent(
      {this.day,
      this.courseContentId,
      this.courseId,
      this.details,
      this.readStatus});

  CourseContent.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    courseContentId = json['course_content_id'];
    courseId = json['course_id'];
    details = json['details'].cast<String>();
    readStatus = json['read_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['course_content_id'] = this.courseContentId;
    data['course_id'] = this.courseId;
    data['details'] = this.details;
    data['read_status'] = this.readStatus;
    return data;
  }
}
