import 'package:encounter_app/presentation/study_details_screen/models/course_detail_respo.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/course_day_details.dart';
import '../models/enroll_respo.dart';
import '../models/study_details_model.dart';
import '../repo/course_detail_repo.dart';

/// A provider class for the StudyDetailsScreen.
///
/// This provider manages the state of the StudyDetailsScreen, including the
/// current studyDetailsModelObj
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class FullCourseProvider extends ChangeNotifier {
  TextEditingController typehereController = TextEditingController();
  StudyDetailsModel studyDetailsModelObj = StudyDetailsModel();
  final CourseDetailRepo _repo = CourseDetailRepo();
  // final player = AudioPlayer();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  CourseDetailRespo _respo = CourseDetailRespo();
  CourseDetailRespo get respo => _respo;

  EnrollResponse _en_respo = EnrollResponse();
  EnrollResponse get en_respo => _en_respo;

  CourseDayDetailRespo _respo_day = CourseDayDetailRespo();
  CourseDayDetailRespo get respo_day => _respo_day;

  YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: '3Qw3M7ibgaM',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
      showLiveFullscreenButton: false,
    ),
  );
  YoutubePlayerController controllerDetail = YoutubePlayerController(
    initialVideoId: '3Qw3M7ibgaM',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
      showLiveFullscreenButton: false,
    ),
  );

  @override
  void dispose() {
    super.dispose();
    typehereController.dispose();
  }

  String course_id = "";
  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  getFullCourse(String course_id) async {
    this.course_id = course_id;
    print("course_id{$course_id}");
    loader(true);
    _respo = await _repo.getFullCourse(course_id: course_id);
    loader(false);
    notifyListeners();
  }
}
