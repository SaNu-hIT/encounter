import 'package:encounter_app/presentation/study_details_screen/repo/course_detail_repo.dart';
import 'package:encounter_app/presentation/study_details_screen/models/course_detail_respo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../core/app_export.dart';
import '../models/course_day_details.dart';
import '../models/enroll_respo.dart';
import '../models/study_details_item_model.dart';
import '../models/study_details_model.dart';

/// A provider class for the StudyDetailsScreen.
///
/// This provider manages the state of the StudyDetailsScreen, including the
/// current studyDetailsModelObj
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class VideoPlayerProvider extends ChangeNotifier {
  final CourseDetailRepo _repo = CourseDetailRepo();
  // final player = AudioPlayer();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  YoutubePlayerController controller = YoutubePlayerController(
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
  }

  String course_id = "";
  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }



  Future<void> playAudio() async {
    // if (null != respo.data!.first.introAudio)
    // await player.play(UrlSource(respo.data!.first.introAudio!));
  }

  Future<void> _play() async {
    // await player.resume();
  }

  Future<void> _pause() async {
    // await player.pause();
  }

  Future<void> _stop() async {
    // await player.stop();
  }


}
