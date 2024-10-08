import '../../../core/app_export.dart';
import '../../../core/utils/image_constant.dart';
import '../../../widgets/custom_bottom_bar.dart';
import 'explorecommentary_item_model.dart';
import 'viewhierarchy_item_model.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class HomeModel {
  List<ExplorecommentaryItemModel> explorecommentaryItemList = [
    ExplorecommentaryItemModel(
        dynamicImage: ImageConstant.imgMusic,
        dynamicText: "Explore \nCommentary",
        id: BottomBarEnum.Home),
    ExplorecommentaryItemModel(
        dynamicImage: ImageConstant.imgNotes,
        dynamicText: "Recent\nNotes",
        id: BottomBarEnum.Notes),
    ExplorecommentaryItemModel(
        dynamicImage: ImageConstant.imgBible,
        dynamicText: "Explore \nBible",
        id: BottomBarEnum.Bible)
  ];

  //  Provider.of<HomeContainerProvider>(context, listen: false)
  //               .selectTab(BottomBarEnum.Study);

  List<ViewhierarchyItemModel> viewhierarchyItemList = [
    ViewhierarchyItemModel(
        image: ImageConstant.imgRectangle4323,
        text1: "Day 5: Genesis 5:21 ",
        text2: "Fr. Joseph Vadakkan"),
    ViewhierarchyItemModel(
        image: ImageConstant.imgRectangle4323186x186,
        text1: "Day 8: Leviticus 2:14",
        text2: "Fr. Joseph Vadakkan")
  ];
}
