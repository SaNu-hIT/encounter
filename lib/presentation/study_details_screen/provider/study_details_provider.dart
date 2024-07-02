import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
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

  @override
  void dispose() {
    super.dispose();
    typehereController.dispose();
  }
}
