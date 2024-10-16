import 'package:flutter/material.dart';

import '../../home_page/home_repo.dart';
import '../../home_page/models/home_model.dart';
import '../../home_page/models/home_respo.dart';
import '../models/completed_respo.dart';

/// A provider class for the HomePage.
///
/// This provider manages the state of the HomePage, including the
/// current homeModelObj
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class CompletedProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  final HomeRepo _repo = HomeRepo();
  HomeModel homeModelObj = HomeModel();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  CompletedRespo _respo = CompletedRespo();
  CompletedRespo get respo => _respo;
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  getCompletedCourse(String? length) async {
    loader(true);
    _respo = await _repo.getCompletedCourse(length: length ?? "");
    loader(false);
    notifyListeners();
  }
}
