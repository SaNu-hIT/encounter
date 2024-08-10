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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => {NavigatorService.goBack()},
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CustomImageView(
                                imagePath: ImageConstant.back,
                              ),
                            ),
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
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: () {
            NavigatorService.pushNamed(
              AppRoutes.ask_question_form,
            ).then(Provider.of<AskQuestionProvider>(context, listen: false)
                .getAskQuestionsList());
          },
        ),
      );
      
    });
  }

  Widget _buildViewHierarchy(BuildContext context, GotQuestionModel data) {
    return ListView.builder(
      physics: ScrollPhysics(),
      itemCount: data.data?.length ?? 0,
      itemBuilder: (context, index) {
        QuestionData? item = data.data?[index];

        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Container(
            // decoration: BoxDecoration(
            //     border: Border.all(
            //         width: 1, color: Color.fromARGB(255, 207, 223, 236)),
            //     borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                ExpansionTile(
                    trailing: Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: SizeUtils.width - 150,
                                child: Text(
                                  item?.question ?? "Test name",
                                  style:
                                      CustomTextStyles.titleSmallBluegray90002,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    maintainState: true,
                    expandedAlignment: Alignment.centerLeft,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "${item?.answer} ",
                          style: CustomTextStyles.titleSmallBluegray90002,
                        ),
                      ),
                    ]),
                Divider(
                  thickness: 2,
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
