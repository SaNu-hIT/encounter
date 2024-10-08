import 'package:encounter_app/presentation/study_details_screen/models/course_day_details.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../study_details_screen/repo/course_detail_repo.dart';

class NoteProvider with ChangeNotifier {
  String _title = '';
  String _note = '';
  final noteController = TextEditingController();
  String get title => _title;
  String get note => _note;
  final CourseDetailRepo _repo = CourseDetailRepo();
  void updateTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  List<bool> selected = [true, false, false];

 
  void updateSelection(int index) {
    
    // Ensure only one option is selected at a time
    for (int i = 0; i < selected.length; i++) {
      selected[i] = i == index;
    }
    notifyListeners(); // Notify listeners to update the UI
  }

  submitNote(Statements? statements, CourseDayVerse? verses) async {
    loader(true);
    var loginRepo = await _repo.addNotes(
        testament_id: verses?.testament.toString() ?? "",
        book_id: verses?.book.toString() ?? "",
        chapter_id: verses?.chapter.toString() ?? "",
        verse_id: statements?.statementNo.toString() ?? "",
        note: noteController.text);
    loader(false);
    if (loginRepo.status == "success") {
    } else {
      // Fluttertoast.showToast(
      //     msg: loginRepo.data?.messsage ?? "",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      loader(false);
    }
  }


  // submitNote(Statements? statements, CourseDayVerse? verses) async {
  //   loader(true);
  //   var loginRepo = await _repo.addNotes(
  //       testament_id: verses?.testament.toString() ?? "",
  //       book_id: verses?.book.toString() ?? "",
  //       chapter_id: verses?.chapter.toString() ?? "",
  //       verse_id: statements?.statementNo.toString() ?? "",
  //       note: noteController.text);
  //   loader(false);
  //   if (loginRepo.status == "success") {
  //   } else {
  //     // Fluttertoast.showToast(
  //     //     msg: loginRepo.data?.messsage ?? "",
  //     //     toastLength: Toast.LENGTH_SHORT,
  //     //     gravity: ToastGravity.BOTTOM,
  //     //     timeInSecForIosWeb: 1,
  //     //     backgroundColor: Colors.red,
  //     //     textColor: Colors.white,
  //     //     fontSize: 16.0);
  //     loader(false);
  //   }
  // }


}

