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
import 'models/got_question_model.dart';
import 'provider/ask_question_provider.dart'; // ignore_for_file: must_be_immutable

class AskQuestionsPage extends StatefulWidget {
  const AskQuestionsPage({Key? key})
      : super(
          key: key,
        );

  @override
  AskQuestionsPageState createState() => AskQuestionsPageState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AskQuestionProvider(),
      child: AskQuestionsPage(),
    );
  }
}

class AskQuestionsPageState extends State<AskQuestionsPage>
    with AutomaticKeepAliveClientMixin<AskQuestionsPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AskQuestionProvider>(context, listen: false)
          .getAskQuestionsList();
    });
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 164.h,
      leading: AppbarTitle(
        text: "Ask Questions",
        margin: EdgeInsets.only(left: 24.h, top: 20.v),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AskQuestionProvider>(builder: (context, provider, child) {
      return Scaffold(
          backgroundColor: appTheme.gray10001,
          body: SafeArea(
            child: SizedBox(
              width: SizeUtils.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => {NavigatorService.goBack()},
                              child: CustomImageView(
                                imagePath: ImageConstant.back,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Asked Questions",
                              style: CustomTextStyles.titleMediumSemiBold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: _buildViewHierarchy(context, provider.respo)),
                ],
              ),
            ),
          ),
          floatingActionButton: GestureDetector(
            onTap: () {
              NavigatorService.pushNamed(
                AppRoutes.ask_question_form,
              ).then((val) => provider.getAskQuestionsList());
            },
            child: SvgPicture.asset(
              ImageConstant
                  .askButton, // This should be the path to your SVG file
              fit: BoxFit.cover, // Ensure the image fills the button
            ),
          )

          //    FloatingActionButton(
          //     onPressed: () {
          //       NavigatorService.pushNamed(
          //         AppRoutes.ask_question_form,
          //       ).then((val) => provider.getAskQuestionsList());
          //     },
          //     child: SvgPicture.asset(
          //       ImageConstant.askButton, // This should be the path to your SVG file
          //       fit: BoxFit.cover, // Ensure the image fills the button
          //     ),
          //     backgroundColor:
          //         Colors.transparent, // Make the background color transparent
          //   ),
          );
    });
  }

  Widget _buildViewHierarchy(BuildContext context, GotQuestionModel data) {
    return ListView.builder(
      physics: ScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: data.data?.length ?? 0,
      itemBuilder: (context, index) {
        QuestionData? item = data.data?[index];

        return Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24),
          child: Container(
            child: Column(
              children: [
                Divider(
                  thickness: 3,
                  color: appTheme.grayDivider,
                ),
                SizedBox(
                  height: 8,
                ),
                ExpansionTile(
                    trailing: Icon(Icons.add, color: appTheme.blue1A),
                    collapsedShape: RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    tilePadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: SizeUtils.width - 150,
                                child: Text(
                                  item?.question ?? "Test name",
                                  style: CustomTextStyles.askQuestiontittle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    maintainState: false,
                    expandedAlignment: Alignment.topLeft,
                    children: [
                      item?.answer == null
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, bottom: 12),
                              child: Row(
                                children: [
                                  Text(
                                    "Pending",
                                    style: CustomTextStyles
                                        .titleSmallBluegrayYellow,
                                  ),
                                  Spacer(),
                                  Text(
                                    "${item?.createdAt} ",
                                    style: CustomTextStyles
                                        .titleSmallBluegray90002,
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Text(
                                    "${item?.answer} ",
                                    style: CustomTextStyles
                                        .titleSmallBluegray90002,
                                  ),
                                  Spacer(),
                                  Text(
                                    "${item?.createdAt} ",
                                    style: CustomTextStyles
                                        .titleSmallBluegray90002,
                                  ),
                                ],
                              ),
                            ),
                    ]),
              ],
            ),
          ),
        );
      },
    );
  }
}
