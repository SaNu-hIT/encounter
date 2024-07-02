import '../../../core/app_export.dart';

/// This class is used in the [study_details_item_widget] screen.
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class StudyDetailsItemModel {
  StudyDetailsItemModel({this.rectangle, this.id}) {
    rectangle = rectangle ?? ImageConstant.imgRectangle4322106x128;
    id = id ?? "";
  }

  String? rectangle;

  String? id;
}
