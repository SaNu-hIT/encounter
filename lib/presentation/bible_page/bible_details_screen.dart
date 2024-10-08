import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:encounter_app/presentation/bible_page/models/bible_detail_model.dart';
import 'package:encounter_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/loader_widget.dart';
import 'provider/bible_provider.dart';

class BibleDetailsScreen extends StatefulWidget {
  const BibleDetailsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  StudyDetailsScreenState createState() => StudyDetailsScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BibleProvider(),
      child: BibleDetailsScreen(),
    );
  }
}

class StudyDetailsScreenState extends State<BibleDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String book_id = ModalRoute.of(context)!.settings.arguments as String;
      Provider.of<BibleProvider>(context, listen: false)
          .getBibleChapter(book_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BibleProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return LoaderWidget();
      }
      return Scaffold(
        backgroundColor: appTheme.backgroundColor,
        body: SafeArea(
          child: Column(
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
                          provider.bibleDetailRespo.data?.first.bookName ?? "",
                          style: CustomTextStyles.titleMediumSemiBold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ScrollableListTabScroller.defaultComponents(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  headerContainerProps: HeaderContainerProps(height: 50),
                  tabBarProps:
                      TabBarProps(dividerColor: Colors.blue.withOpacity(0.3)),
                  addRepaintBoundaries: false,
                  itemCount: provider.bibleDetailRespo.data?.length ?? 0,
                  tabBuilder: (BuildContext context, int index, bool active) =>
                      Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: Text(
                      provider.bibleDetailRespo.data![index].chapterName ?? "",
                      style: !active
                          ? TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 16)
                          : TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 18),
                    ),
                  ),
                  itemBuilder: (BuildContext context, int index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 12),
                        child: AutoSizeText(
                          provider.bibleDetailRespo.data?[index].chapterName ??
                              "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 10),
                        itemCount: provider
                            .bibleDetailRespo.data?[index].statements?.length,
                        itemBuilder: (context, statementIndex) {
                          return ListTile(
                            leading: Container(
                              height: 33,
                              width: 33,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                (statementIndex + 1).toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                minFontSize: 7,
                                maxLines: 1,
                              ),
                            ),
                            title: GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: provider
                                            .bibleDetailRespo
                                            .data?[index]
                                            .statements?[statementIndex]
                                            .statementText ??
                                        "",
                                  ),
                                );
                              },
                              onLongPress: () {
                                shareToWhatsAppText(
                                    "Bibile Verses",
                                    provider
                                            .bibleDetailRespo
                                            .data?[index]
                                            .statements?[statementIndex]
                                            .statementText ??
                                        "",
                                    "");
                              },
                              child: HtmlWidget(provider
                                      .bibleDetailRespo
                                      .data?[index]
                                      .statements?[statementIndex]
                                      .statementText ??
                                  ""),
                            ),
                          );
                        },
                      ),
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
        alignment: Alignment.topCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle625,
            height: 400.v,
            fit: BoxFit.cover,
            width: SizeUtils.width,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget buildVerses(BuildContext context, BibleProvider provider) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.h, right: 24.h),
          child: Row(
            children: [
              Text(
                "Verses ".tr,
                style: theme.textTheme.titleMedium,
              ),
              Spacer(),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }

  _buildRowDayOne(BuildContext context, ChapterData model) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: SizeUtils.width / 1.6,
              child: Container(
                color: appTheme.amber300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Chapater :${model.chapterNo}"),
                    Text("Chapater Name :${model.chapterName}"),
                  ],
                ),
              )),
        )
      ],
    );
  }
}
