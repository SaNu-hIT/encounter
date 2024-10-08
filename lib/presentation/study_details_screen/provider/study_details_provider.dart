import 'package:encounter_app/presentation/study_details_screen/repo/course_detail_repo.dart';
import 'package:encounter_app/presentation/study_details_screen/models/course_detail_respo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../core/app_export.dart';
import '../custom_item_sheet.dart';
import '../models/common_respo.dart';
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
class StudyDetailsProvider extends ChangeNotifier {
  TextEditingController typehereController = TextEditingController();
  StudyDetailsModel studyDetailsModelObj = StudyDetailsModel();
  final CourseDetailRepo _repo = CourseDetailRepo();
  // final player = AudioPlayer();
  bool _isLoading = false;
  bool isMultipleSelect = false;
  List<bool> selected = [true, false, false];

  bool get isLoading => _isLoading;
  CourseDetailRespo _respo = CourseDetailRespo();
  CourseDetailRespo get respo => _respo;
  CommonResponse _common_respo = CommonResponse();
  CommonResponse get common_respo => _common_respo;

  EnrollResponse _en_respo = EnrollResponse();
  EnrollResponse get en_respo => _en_respo;

  CourseDayDetailRespo _respo_day = CourseDayDetailRespo();
  CourseDayDetailRespo get respo_day => _respo_day;
  List<YoutubePlayerController> controllerList = [];
  YoutubePlayerController? controller;
  YoutubePlayerController? controllerDay;

  @override
  void dispose() {
    super.dispose();
    typehereController.dispose();
  }

  String course_id = "";
  String userLmsId = "";
  String day_id = "";
  String dayId = "";
  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  getDetails(String course_id) async {
    this.course_id = course_id;
    _respo = CourseDetailRespo();
    loader(true);
    _respo = await _repo.getCourseDetail(course_id: course_id);
    var videoId =
        YoutubePlayer.convertUrlToId(_respo.data?.first.introVideo ?? "");
    print("videoId{$videoId}");

    controller = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        hideControls: false,
        showLiveFullscreenButton: true,
      ),
    );

    // controller.load(videoId ?? "");
    // controller
    //     .loadRequest(Uri.parse('https://www.youtube.com/watch?v=N1EAsWECEKU'));
    loader(false);
    notifyListeners();
  }

  getFullCourse(String course_id) async {
    this.course_id = course_id;
    loader(true);
    _respo = await _repo.getFullCourse(course_id: course_id);
    loader(false);
    notifyListeners();
  }

  Future<bool?> showConfirmAlert(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context1) {
        return AlertDialog(
          title: const Text('Confirm Course Completion'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Are you sure you want to mark this course as completed? Once confirmed, your progress will be finalized, and you will no longer be able to make changes to your submissions or activities. Please double-check that all required tasks are finished before proceeding.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context1).pop(false);
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context1).pop(true);
                markAsComplete().then((val) => {
                      if (val == true) {Navigator.of(context).pop()}
                    });
              },
            ),
          ],
        );
      },
    );
  }

  markAsComplete() async {
    if (dayId != "" && userLmsId != "") {
      loader(true);
      _common_respo =
          await _repo.markAsComplete(user_lms_id: userLmsId, day: dayId);
      loader(false);

      notifyListeners();
    }
  }

  getDayDetails(String day_id, String userLmsId, String day) async {
    this.dayId = day;
    this.userLmsId = userLmsId;
    loader(true);
    _respo_day = await _repo.getCourseDayDetail(day_id: day_id);
    var videoId = YoutubePlayer.convertUrlToId(
        _respo_day.data?.courseContentVideoLink?.first.videoSpotifyLink ?? "");

    controllerDay = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        hideControls: false,
        showLiveFullscreenButton: true,
      ),
    );
    loader(false);
    notifyListeners();
  }

  setValue(String day_id, String userLmsId, String day) async {
    this.dayId = day;
    this.userLmsId = userLmsId;
    this.day_id = day_id;
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
  Future<bool?> showEnrollAlert(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context1) {
        return AlertDialog(
          title: const Text('Confirm Enrollment'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Are you sure you want to enroll in this course? By confirming, you will be added to the course, and you will have access to all materials and activities. Please ensure you have reviewed the course details and are ready to commit before proceeding.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context1).pop(false);
              },
            ),
            TextButton(
              child: const Text('Enroll'),
              onPressed: () {
                Navigator.of(context1).pop(true);
                enrollCourse().then((val) => {getDetails(course_id)});
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> enrollCourse() async {
    try {
      // Await the API call and get the response
      _en_respo = await _repo.enrollCourse(
          batch_id: respo.data?.first.batchId.toString() ?? "");

      // // Check if the response was successful and update state accordingly
      // if (_en_respo != null && _en_respo.status == 'success') {
      //   // Handle any additional logic if needed based on the successful response
      //   getDetails(course_id);
      // } else {
      //   // Handle the case where the response indicates failure or is null
      //   // You might want to display an error message or take other actions
      // }

      // Notify listeners to refresh the UI with the updated state
      notifyListeners();
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print("Error enrolling course: $e");
      // Optionally, notify listeners if the UI needs to reflect error states
      notifyListeners();
    }
  }

  void navigateToDetail(String courseContentId, String day, String? userLmsId) {
    NavigatorService.pushNamed(
      AppRoutes.studyDayScreen,
      arguments: {
        'course_day_id': courseContentId,
        'day': day,
        'userLmsId': userLmsId,
      },
    ).then((val) => getDetails(course_id));
  }

  Future<void> addNotes() async {
    Fluttertoast.showToast(
        msg: "Coming soon",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 209, 150, 146),
        textColor: Colors.white,
        fontSize: 16.0);

    // loader(true);
    // _respo_day = await _repo.addNotes(note: day_id);
    // var videoId =
    //     YoutubePlayer.convertUrlToId(_respo_day.data?.videoLink ?? "");
    // controllerDetail.load(videoId ?? "3Qw3M7ibgaM");
  }

  // Handle the close button press
  void _closeNote() {}
  final int _maxWords = 300;

  // Function to count words in the text
  int _countWords(String text) {
    if (text.isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  final _noteController = TextEditingController();
  Future<bool?> showAddNotesAlert(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context1) {
        return AlertDialog(
          title: Text("Add Notes"), // Title of the dialog
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title or statement text
                // Text(widget.statements?.statementText ?? ""),
                SizedBox(height: 20),
                // Note input field
                TextField(
                  controller: _noteController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    labelText: 'Note',
                    hintText: 'Enter your note (max $_maxWords words)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (_countWords(value) > _maxWords) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Note cannot exceed $_maxWords words'),
                      ));
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            // Close button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Close'),
              ),
            ),
            // Submit button
            ElevatedButton(
              onPressed: () {
                // Ensure submit is wrapped properly with a lambda
                // provider.submitNote(widget.statements, widget.verses);
                _closeNote();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Submit'),
              ),
            ),
          ],
        );
      },
    );
  }

  void toggleData(int statementIndex, int? id) {
    if (id == null) return;

    CourseDayVerse? courseDayVerseItem =
        _respo_day.data?.courseDayVerse?.firstWhere(
      (verse) => verse.id == id,
    );

    if (courseDayVerseItem != null) {
      if (statementIndex >= 0 &&
          statementIndex < courseDayVerseItem.statements!.length) {
        Statements statement = courseDayVerseItem.statements![statementIndex];
        statement.isSelected = !statement.isSelected;

        // Notify listeners to update the UI after toggling the data
        notifyListeners();
      } else {
        print("Invalid statement index.");
      }
    } else {
      print("CourseDayVerse with id $id not found.");
    }
  }

  void unselectAll() {
    // Check if there are any CourseDayVerse items
    if (_respo_day.data?.courseDayVerse != null) {
      // Iterate through each CourseDayVerse
      for (var courseDayVerseItem in _respo_day.data!.courseDayVerse!) {
        // Iterate through each statement in the CourseDayVerse and unselect it
        for (var statement in courseDayVerseItem.statements!) {
          statement.isSelected = false;
        }
      }

      // Notify listeners to update the UI after unselecting all statements
      notifyListeners();
    } else {
      print("No CourseDayVerse items found.");
    }
  }

  void showCustomBottomSheet(
      BuildContext context, StudyDetailsProvider provider) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          provider: provider,
        );
      },
    );
  }

  void updateSelection(int index) {
    // Ensure only one option is selected at a time
    for (int i = 0; i < selected.length; i++) {
      selected[i] = i == index;
    }
    notifyListeners(); // Notify listeners to update the UI
  }

  void submitNote(BuildContext context) {
    Navigator.pop(context);
  }

  void loadNext(String? video_link) {
    var videoId = YoutubePlayer.convertUrlToId(
        _respo_day.data?.courseContentVideoLink?.first.videoSpotifyLink ?? "");
    controllerDay?.load(videoId ?? "");
  }
}
