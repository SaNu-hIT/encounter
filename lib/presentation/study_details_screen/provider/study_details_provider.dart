import 'package:audioplayers/audioplayers.dart';
import 'package:encounter_app/presentation/study_details_screen/course_detail_repo.dart';
import 'package:encounter_app/presentation/study_details_screen/models/course_detail_respo.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/course_day_details.dart';
import '../models/study_details_item_model.dart';
import '../models/study_details_model.dart';

/// A provider class for the StudyDetailsScreen.
///
/// This provider manages the state of the StudyDetailsScreen, including the
/// current studyDetailsModelObj
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class StudyDetailsProvider extends ChangeNotifier {
  TextEditingController typehereController = TextEditingController();
  StudyDetailsModel studyDetailsModelObj = StudyDetailsModel();
  final CourseDetailRepo _repo = CourseDetailRepo();
  final player = AudioPlayer();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  CourseDetailRespo _respo = CourseDetailRespo();
  CourseDetailRespo get respo => _respo;
  CourseDayDetailRespo _respo_day = CourseDayDetailRespo();
  CourseDayDetailRespo get respo_day => _respo_day;
  @override
  void dispose() {
    super.dispose();
    typehereController.dispose();
  }

  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  getDetails(String course_id) async {
    loader(true);
    _respo = await _repo.getCourseDetail(course_id: course_id);
    loader(false);
    notifyListeners();
  }

  getDayDetails(String day_id) async {
    loader(true);
    _respo_day = await _repo.getCourseDayDetail(day_id: day_id);
    loader(false);
    notifyListeners();
  }

  Future<void> playAudio() async {
    if (null != respo.data!.first.introAudio)
      await player.play(UrlSource(respo.data!.first.introAudio!));
  }

  Future<void> _play() async {
    await player.resume();
  }

  Future<void> _pause() async {
    await player.pause();
  }

  Future<void> _stop() async {
    await player.stop();
  }
}
