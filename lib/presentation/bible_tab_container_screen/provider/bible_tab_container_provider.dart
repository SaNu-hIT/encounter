import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/bible_tab_container_model.dart';

/// A provider class for the BibleTabContainerScreen.
///
/// This provider manages the state of the BibleTabContainerScreen, including the
/// current bibleTabContainerModelObj
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class BibleTabContainerProvider extends ChangeNotifier {
  BibleTabContainerModel bibleTabContainerModelObj = BibleTabContainerModel();

  bool isSelectedSwitch = false;

  @override
  void dispose() {
    super.dispose();
  }

  void changeSwitchBox(bool value) {
    isSelectedSwitch = value;
    notifyListeners();
  }
}
