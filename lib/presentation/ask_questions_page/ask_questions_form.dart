import 'package:encounter_app/localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/app_export.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../theme/custom_button_style.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/circular_loader.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button1.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_search_view.dart';
import '../../widgets/custom_text_form_field_login.dart';
import 'models/got_question_model.dart';
import 'provider/ask_question_provider.dart'; // ignore_for_file: must_be_immutable

class AskQuestionsFormPage extends StatefulWidget {
  const AskQuestionsFormPage({Key? key})
      : super(
          key: key,
        );

  @override
  AskQuestionsPageState createState() => AskQuestionsPageState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AskQuestionProvider(),
      child: AskQuestionsFormPage(),
    );
  }
}

class AskQuestionsPageState extends State<AskQuestionsFormPage>
    with AutomaticKeepAliveClientMixin<AskQuestionsFormPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
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
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Selector<AskQuestionProvider, TextEditingController?>(
                    selector: (
                      context,
                      provider,
                    ) =>
                        provider.notesController,
                    builder: (context, notesController, child) {
                      return Container(
                        decoration: BoxDecoration(
                          color: appTheme.whiteA700,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(
                            2.h,
                          ),
                        ),
                        child: TextFormField(
                          maxLines: 6,
                          keyboardType: TextInputType.multiline,
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          controller: notesController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: "Ask"),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 15.v),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: CustomElevatedButton1(
                    text: "Submit Question",
                    onPressed: () {
                      Provider.of<AskQuestionProvider>(context, listen: false)
                          .addNotes(context);
                    },
                    buttonStyle: CustomButtonStyles.outlineBlueGrayC,
                  ),
                )
              ],
            ),
          ),
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
