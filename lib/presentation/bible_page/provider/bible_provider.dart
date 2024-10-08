import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../models/bible_detail_model.dart';
import '../models/bible_model.dart';
import '../repo/login_repo.dart';

/// A provider class for the BiblePage.
///
/// This provider manages the state of the BiblePage, including the
/// current bibleModelObj
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class BibleProvider extends ChangeNotifier {
  @override
  void dispose() {
    super.dispose();
  }

  bool _isSelectedOldTestament = true;
  bool _isSelectedNewTestament = false;

  bool get isSelectedOldTestament => _isSelectedOldTestament;
  bool get isSelectedNewTestament => _isSelectedNewTestament;

  void selectOldTestament() {
    _isSelectedOldTestament = true;
    _isSelectedNewTestament = false;
    testament_id = "1";
    notifyListeners();
    getBibleList();
  }

  void selectNewTestament() {
    _isSelectedOldTestament = false;
    _isSelectedNewTestament = true;
    testament_id = "2";
    notifyListeners();
    getBibleList();
  }

  final BibleRepo _repo = BibleRepo();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  var testament_id = "1";
  BibleDetailModel _bibleDetailRespo = BibleDetailModel();
  BibleListModel _bibleRespo = BibleListModel();
  BibleDetailModel get bibleDetailRespo => _bibleDetailRespo;
  BibleListModel get bibleRespo => _bibleRespo;
  getBibleList() async {
    loader(true);

    _bibleRespo = await _repo.getBibleList(testament_id: testament_id);
    loader(false);

    notifyListeners();
  }

  getBibleChapter(String book_id) async {
    loader(true);

    _bibleDetailRespo = await _repo.getBibleChapter(book_id: book_id);
    loader(false);

    notifyListeners();
  }
}
