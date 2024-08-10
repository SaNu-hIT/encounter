import '../../../core/app_export.dart';
import '../../../core/utils/image_constant.dart';

/// This class is used in the [viewhierarchy_item_widget] screen.
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ViewhierarchyItemModel {
  ViewhierarchyItemModel({this.image, this.text1, this.text2, this.id}) {
    image = image ?? ImageConstant.imgRectangle4323;
    text1 = text1 ?? "Day 5: Genesis 5:21 ";
    text2 = text2 ?? "Fr. Joseph Vadakkan";
    id = id ?? "";
  }

  String? image;

  String? text1;

  String? text2;

  String? id;
}
