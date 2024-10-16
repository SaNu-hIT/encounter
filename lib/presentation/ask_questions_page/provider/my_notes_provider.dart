import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../profile_screen/models/my_notes_respo.dart';
import '../models/ask_question_respo.dart';
import '../models/category_dropdown.dart';
import '../models/got_question_model.dart';
import '../repo/ask_questions_repo.dart';

/// A provider class for the BiblePage.
///
/// This provider manages the state of the BiblePage, including the
/// current bibleModelObj
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class MyNotesProvider extends ChangeNotifier {
  final AskQuestionsRepo _repo = AskQuestionsRepo();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  int position = 0;
  int tab_length = 0;

  @override
  void dispose() {
    super.dispose();
  }

  MyNotesRespo _respo = MyNotesRespo();
  MyNotesRespo get respo => _respo;

  getMyNotes() async {
    loader(true);
    _respo = await _repo.getNotes();
    loader(false);
    notifyListeners();
  }
}
