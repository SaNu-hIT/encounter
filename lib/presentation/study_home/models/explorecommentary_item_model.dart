import '../../../core/utils/image_constant.dart';

/// This class is used in the [explorecommentary_item_widget] screen.
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ExplorecommentaryItemModel {
  ExplorecommentaryItemModel({this.dynamicImage, this.dynamicText, this.id}) {
    dynamicImage = dynamicImage ?? ImageConstant.imgMusic;
    dynamicText = dynamicText ?? "Explore \nCommentary";
    id = id ?? "";
  }

  String? dynamicImage;

  String? dynamicText;

  String? id;
}
