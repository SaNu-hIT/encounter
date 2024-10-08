import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
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
class AskQuestionProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  TextEditingController notesController = TextEditingController();
  final AskQuestionsRepo _repo = AskQuestionsRepo();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  Timer? _debounce;

  void searchItem() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 900), () async {
      getGotQuestions();
      // notifyListeners();
    });
  }

  var gq_category = "";
  var gq_subcategory = "";
  GotQuestionModel _respo = GotQuestionModel();
  GotQuestionModel get respo => _respo;

  CategoryDropDown _cat_respo = CategoryDropDown();
  CategoryDropDown get cat_respo => _cat_respo;

  CategoryDropDown _cat_sub_respo = CategoryDropDown();
  CategoryDropDown get cat_sub_respo => _cat_sub_respo;

  List<SelectionPopupModel>? catDropDown = [];
  List<SelectionPopupModel>? catSubDropDown = [];

  askQuestions(BuildContext context) async {
    if (notesController.text != "") {
      loader(true);
      AskQuestionRespo loginRepo =
          await _repo.askQuestion(question: notesController.text);
      loader(false);
      if (loginRepo.status == "success") {
        NavigatorService.goBack();
      } else {
        Fluttertoast.showToast(
            msg: "Update Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        loader(false);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getCategory() async {
    loader(true);
    _cat_respo = await _repo.getCategory();
    catDropDown = _cat_respo.data?.map((data) {
      return SelectionPopupModel(
        id: data.id,
        title: data.name ?? "",
      );
    }).toList();
    loader(false);
    notifyListeners();
  }

  getSubCategory(int? id) async {
    loader(true);
    _respo = GotQuestionModel();
    _cat_sub_respo = await _repo.getSubCategory(id);
    catSubDropDown = _cat_sub_respo.data?.map((data) {
      return SelectionPopupModel(
        id: data.id,
        title: data.name ?? "",
      );
    }).toList();
    loader(false);
    notifyListeners();
  }

  getGotQuestions() async {
    loader(true);
    _respo = await _repo.getQuestions(
        search_word: searchController.text,
        gq_category: gq_category,
        gq_subcategory: gq_subcategory);
    loader(false);
    notifyListeners();
  }

  getAskQuestionsList() async {
    loader(true);
    _respo = await _repo.askQuestions(
        search_word: searchController.text,
        gq_category: gq_category,
        gq_subcategory: gq_subcategory);
    loader(false);
    notifyListeners();
  }






}
