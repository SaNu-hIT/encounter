import 'package:encounter_app/localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/app_export.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/circular_loader.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_search_view.dart';
import 'models/category_dropdown.dart';
import 'models/got_question_model.dart';
import 'provider/ask_question_provider.dart'; // ignore_for_file: must_be_immutable

class GotQuestionsPage extends StatefulWidget {
  const GotQuestionsPage({Key? key})
      : super(
          key: key,
        );

  @override
  AskQuestionsPageState createState() => AskQuestionsPageState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AskQuestionProvider(),
      child: GotQuestionsPage(),
    );
  }
}

class AskQuestionsPageState extends State<GotQuestionsPage>
    with AutomaticKeepAliveClientMixin<GotQuestionsPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AskQuestionProvider>(context, listen: false).getCategory();
      Provider.of<AskQuestionProvider>(context, listen: false)
          .getGotQuestions();
    });
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 164.h,
      leading: AppbarTitle(
        text: "Got Questions",
        margin: EdgeInsets.only(left: 24.h, top: 20.v),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AskQuestionProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: appTheme.gray10001,
        body: SizedBox(
          width: SizeUtils.width,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250.0,
                floating: true,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: _buildStackArrowLeft(context),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 21.h, right: 21.h, top: 20.h),
                          child: CustomSearchView(
                            controller: provider.searchController,
                            hintText: "Search question",
                            onChanged: (value) => {provider.searchItem()},
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                            left: 21.0,
                            right: 21.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: appTheme.whiteA700,
                              border: Border.all(
                                  color: appTheme.black900.withOpacity(0.03)),
                              borderRadius: BorderRadius.circular(
                                10.h,
                              ),
                            ),
                            child: CustomDropDown(
                              hintText: "Select Category",
                              items: provider.catDropDown ?? [],
                              onChanged: (p0) => {
                                provider.gq_category = p0.id.toString(),
                                provider.catSubDropDown = [],
                                Provider.of<AskQuestionProvider>(context,
                                        listen: false)
                                    .getSubCategory(p0.id)
                              },
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      provider.catSubDropDown?.length != 0
                          ? Padding(
                              padding: const EdgeInsets.only(
                                left: 21.0,
                                right: 21.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                  border: Border.all(
                                      color:
                                          appTheme.black900.withOpacity(0.03)),
                                  borderRadius: BorderRadius.circular(
                                    10.h,
                                  ),
                                ),
                                child: CustomDropDown(
                                  hintText: "Select Sub Category",
                                  items: provider.catSubDropDown ?? [],
                                  onChanged: (p0) => {
                                    provider.gq_subcategory = p0.id.toString(),
                                    Provider.of<AskQuestionProvider>(context,
                                            listen: false)
                                        .getGotQuestions()
                                  },
                                ),
                              ))
                          : SizedBox(),
                      SizedBox(
                        height: 20,
                      ),
                      _buildViewHierarchy(context, provider.respo),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Section Widget
  Widget _buildStackArrowLeft(BuildContext context) {
    return SizedBox(
      height: 400.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          CustomImageView(
            imagePath: ImageConstant.got_question_back,
            height: 400.v,
            fit: BoxFit.cover,
            width: SizeUtils.width,
            alignment: Alignment.center,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Got Questions",
              style: CustomTextStyles.largeManrope24Bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewHierarchy(BuildContext context, GotQuestionModel data) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: data.data?.length ?? 0,
      itemBuilder: (context, index) {
        QuestionData? item = data.data?[index];
        return Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24),
          child: Container(
            child: Column(
              children: [
                index == 0
                    ? Divider(
                        thickness: 1,
                        color: appTheme.grayDivider,
                      )
                    : SizedBox(),
                ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    collapsedShape: RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        item?.question ?? "Test name",
                        style: CustomTextStyles.askQuestiontittle,
                      ),
                    ),
                    maintainState: true,
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: EdgeInsets.only(left: 10, bottom: 10),
                    children: [
                      Text(
                        "${item?.answer} ",
                        style: CustomTextStyles.descriptionText,
                      ),
                    ]),
                Divider(
                  thickness: 1,
                  color: appTheme.grayDivider,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
