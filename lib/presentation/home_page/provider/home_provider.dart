import 'package:encounter_app/presentation/home_page/models/home_respo.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../home_repo.dart';
import '../models/explorecommentary_item_model.dart';
import '../models/home_model.dart';
import '../models/viewhierarchy_item_model.dart';

/// A provider class for the HomePage.
///
/// This provider manages the state of the HomePage, including the
/// current homeModelObj
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class HomeProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  final HomeRepo _repo = HomeRepo();
  HomeModel homeModelObj = HomeModel();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  HomeRespo _respo = HomeRespo();
  HomeRespo get respo => _respo;
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  getHome(String? length) async {
    loader(true);
    _respo = await _repo.getHome(length: length ?? "");
    loader(false);
    notifyListeners();
  }
}
