import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:encounter_app/presentation/bible_page/models/bible_detail_model.dart';
import 'package:encounter_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:popover/popover.dart';
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
                        Spacer(),
                        Row(
                          children: [
                            provider.getSelectedBibleTextCount() != 0
                                ? Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          provider.unselectAll();
                                        },
                                        child: Text(
                                          "Unselect All ",
                                          style: CustomTextStyles
                                              .titleMediumSemiBold,
                                        ),
                                      ),
                                      // Text(
                                      //   provider
                                      //           .getSelectedBibleTextCount()
                                      //           .toString() +
                                      //       " Verses  " +
                                      //       "",
                                      //   style: CustomTextStyles
                                      //       .titleMediumSemiBold,
                                      // ),
                                    ],
                                  )
                                : SizedBox(),
                          ],
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
                  headerContainerProps: HeaderContainerProps(
                    height: 50,
                  ),
                  tabBarProps: TabBarProps(
                    dividerColor: Colors.blue.withOpacity(0),
                  ),
                  addRepaintBoundaries: false,
                  itemCount: provider.bibleDetailRespo.data?.length ?? 0,
                  tabBuilder: (BuildContext context, int index, bool active) =>
                      Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: active ? appTheme.teal300 : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 35,
                      width: 35,
                      child: Center(
                        child: Text(
                          provider.bibleDetailRespo.data![index].chapterNo
                                  .toString() ??
                              "",
                          style: !active
                              ? TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 20)
                              : TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                        ),
                      ),
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
                      // ListBibile(context, provider, index),
                      ContinuousBibleText(context, provider, index)
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
  Widget ListBibile(
    BuildContext context,
    BibleProvider provider,
    int index,
  ) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 10),
      itemCount: provider.bibleDetailRespo.data?[index].statements?.length,
      itemBuilder: (context, statementIndex) {
        var verses = provider.bibleDetailRespo.data?[index];
        var statements = verses?.statements;
        return Column(
          children: [
            CupertinoContextMenu.builder(
              actions: [
                provider.isMultipleSelect
                    ? CupertinoContextMenuAction(
                        child: Text("Unselect all"),
                        trailingIcon: CupertinoIcons.arrow_clockwise,
                        onPressed: () {
                          provider.unselectAll();
                          provider.isMultipleSelect = false;
                          Navigator.pop(context);
                        },
                      )
                    : CupertinoContextMenuAction(
                        child: Text("Select Multiple"),
                        trailingIcon: CupertinoIcons.check_mark,
                        onPressed: () {
                          provider.toggleData(
                              statementIndex, verses?.chapterId);
                          provider.isMultipleSelect = true;
                          Navigator.pop(context);
                        },
                      ),
                CupertinoContextMenuAction(
                  child: Text("Copy"),
                  trailingIcon: CupertinoIcons.heart,
                  onPressed: () {
                    provider.isMultipleSelect = false;
                    Clipboard.setData(
                      ClipboardData(
                        text: statements?[statementIndex].statementText ?? "",
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
                CupertinoContextMenuAction(
                  child: Text("Add Note"),
                  trailingIcon: CupertinoIcons.add_circled,
                  onPressed: () {
                    if (!provider.isMultipleSelect) {
                      provider.toggleData(statementIndex, verses?.chapterId);
                    }
                    provider.isMultipleSelect = false;
                    // provider.showAddNotesAlert(context);

                    Navigator.pop(context);
                    provider.showCustomBottomSheet(
                        context, provider.getSelectedBibleTextIds());

                    // showDialog(
                    //   context: context,
                    //   builder: (context) => AddNotesPage(),
                    // );
                  },
                ),
                CupertinoContextMenuAction(
                  child: Text("Share"),
                  trailingIcon: CupertinoIcons.share,
                  onPressed: () {
                    Navigator.pop(context);
                    provider.isMultipleSelect = false;
                    shareToWhatsAppText(
                        statements?[statementIndex].statementNo.toString() ??
                            "",
                        statements?[statementIndex].statementText ?? "",
                        "");
                  },
                )
              ],
              builder: (BuildContext context, Animation<double> animation) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: statements![statementIndex].isSelected
                          ? Colors.grey.withOpacity(0.3)
                          : Colors.white,
                      // border: Border.all(
                      //     color: appTheme.black900
                      //         .withOpacity(0.03)),
                      // borderRadius: BorderRadius.circular(
                      //   10.h,
                      // ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                provider.bibleDetailRespo.data?[index]
                                        .statements?[statementIndex].statementNo
                                        .toString() ??
                                    "",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                                minFontSize: 7,
                                maxLines: 1,
                              ),
                              // Container(
                              //   height: 33,
                              //   width: 33,
                              //   decoration: provider
                              //               .bibleDetailRespo
                              //               .data?[index]
                              //               .statements?[
                              //                   statementIndex]
                              //               .statementNo !=
                              //           0
                              //       ? BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           color: Colors.blue,
                              //         )
                              //       : BoxDecoration(),
                              //   alignment: Alignment.center,
                              //   child: provider
                              //               .bibleDetailRespo
                              //               .data?[index]
                              //               .statements?[
                              //                   statementIndex]
                              //               .statementNo !=
                              //           0
                              //       ? AutoSizeText(
                              //           provider
                              //                   .bibleDetailRespo
                              //                   .data?[index]
                              //                   .statements?[
                              //                       statementIndex]
                              //                   .statementNo
                              //                   .toString() ??
                              //               "",
                              //           style: TextStyle(
                              //               color: Colors.white,
                              //               fontSize: 12),
                              //           minFontSize: 7,
                              //           maxLines: 1,
                              //         )
                              //       : SizedBox(),
                              // ),
                              SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: SizeUtils.width / 1.3,
                                child: GestureDetector(
                                  onTap: () {
                                    if (provider.isMultipleSelect) {
                                      provider.toggleData(
                                          statementIndex, verses?.chapterId);
                                    }
                                    print("sadadasdas");
                                  },
                                  child: statements?[statementIndex]
                                              .color_marking !=
                                          null
                                      ? HtmlWidget(
                                          '<span style="background-color: #${statements?[statementIndex].color_marking};">${statements?[statementIndex].statementText ?? ""}</span>',
                                          textStyle: TextStyle(
                                            color: Colors
                                                .white, // Optional text color
                                          ),
                                        )
                                      : HtmlWidget(
                                          statements?[statementIndex]
                                                  .statementText ??
                                              "",
                                          textStyle: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              statements?[statementIndex].note_marking != null
                                  ? GestureDetector(
                                      onTap: () {
                                        // Show a dialog with the note_marking text
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Note'),
                                              content: Text(
                                                  statements?[statementIndex]
                                                          .note_marking ??
                                                      ''),
                                              actions: [
                                                TextButton(
                                                  child: Text('Close'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: CustomImageView(
                                          width: 20,
                                          height: 20,
                                          imagePath: ImageConstant.comments,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 2,
                              ),
                              statements[statementIndex].bookmarkMarking != null
                                  ? GestureDetector(
                                      onTap: () {
                                        // Show a dialog with the note_marking text
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Tags'),
                                              content: Container(
                                                  width: double
                                                      .maxFinite, // Ensures the container takes up available width

                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start, // Align items to the start of the row
                                                    children: (statements?[
                                                                    statementIndex]
                                                                ?.bookmarkMarking ??
                                                            [])
                                                        .map<Widget>(
                                                            (bookmark) =>
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              8.0), // Add some spacing between items
                                                                  child: Text(
                                                                    bookmark?.tagName ??
                                                                        "", // Display the tagName or an empty string
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16), // Adjust font size if needed
                                                                  ),
                                                                ))
                                                        .toList(),
                                                  )
                                                  // ListView(
                                                  //   shrinkWrap: true,
                                                  //   children: (statements?[
                                                  //                   statementIndex]
                                                  //               ?.bookmarkMarking ??
                                                  //           [])
                                                  //       .map<Widget>(
                                                  //           (bookmark) =>
                                                  //               Text(bookmark?.tagName ??
                                                  //                   ""))
                                                  //       .toList(),
                                                  // ),
                                                  ),
                                              actions: [
                                                TextButton(
                                                  child: Text('Close'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: CustomImageView(
                                          width: 20,
                                          height: 20,
                                          imagePath: ImageConstant.attachment,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget ContinuousBibleText(
    BuildContext context,
    BibleProvider provider,
    int index,
  ) {
    var verses = provider.bibleDetailRespo.data?[index];
    var statements = verses?.statements;

    if (statements == null) return SizedBox();

    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 18, right: 18, top: 8),
      child: RichText(
        softWrap: true,
        text: TextSpan(
          children: statements.asMap().entries.map((entry) {
            int statementIndex = entry.key;
            var statement = entry.value;

            return WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: GestureDetector(
                onTap: () {
                  // Handle tap action here
                  print("Tapped on: ${statement.statementText}");
                  if (provider.isMultipleSelect) {
                    provider.toggleData(statementIndex, verses?.chapterId);
                  }
                },
                onLongPress: () {
                  // Handle long-press action here
                  print("Long-pressed on: ${statement.statementText}");
                  provider.showAlertPopup(context, statement);
                },
                child: Container(
                  // color: statement.color_marking != null
                  //     ? Color(int.parse("0xff${statement.color_marking}"))
                  //     : Colors.transparent,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: statement.color_marking != null
                            ? Colors.white
                            : Colors.black,
                      ),
                      children: [
                        // Verse number
                        WidgetSpan(
                          alignment: PlaceholderAlignment.top,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Text(
                              "${statement.statementNo}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        if (statement.color_marking != null)
                          TextSpan(
                            recognizer: LongPressGestureRecognizer()
                              ..onLongPress = () {
                                // Handle long-press action here
                                print(
                                    "Long-pressed on: ${statement.statementText}");
                                provider.showAlertPopup(context, statement);
                              },
                            text: statement.statementText ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              backgroundColor: Color(
                                int.parse("0xff${statement.color_marking}"),
                              ),
                              color: Colors.white,
                            ),
                          )
                        else
                          TextSpan(
                            text: statement.statementText ?? "",
                            style: TextStyle(
                              backgroundColor: statement.isSelected
                                  ? Colors.amber
                                  : Colors.white,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        // Add a space after each statement to keep it flowing
                        TextSpan(
                          text: " ",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Widget ListWrapBible(
  //   BuildContext context,
  //   BibleProvider provider,
  //   int index,
  // ) {
  //   var verses = provider.bibleDetailRespo.data?[index];
  //   var statements = verses?.statements;

  //   return Wrap(
  //     spacing: 10.0, // Adjust spacing between items
  //     runSpacing: 10.0, // Adjust spacing between lines
  //     children: List.generate(
  //       statements?.length ?? 0,
  //       (statementIndex) {
  //         return Column(
  //           children: [
  //             CupertinoContextMenu.builder(
  //               actions: [
  //                 provider.isMultipleSelect
  //                     ? CupertinoContextMenuAction(
  //                         child: Text("Unselect all"),
  //                         trailingIcon: CupertinoIcons.arrow_clockwise,
  //                         onPressed: () {
  //                           provider.unselectAll();
  //                           provider.isMultipleSelect = false;
  //                           Navigator.pop(context);
  //                         },
  //                       )
  //                     : CupertinoContextMenuAction(
  //                         child: Text("Select Multiple"),
  //                         trailingIcon: CupertinoIcons.check_mark,
  //                         onPressed: () {
  //                           provider.toggleData(
  //                               statementIndex, verses?.chapterId);
  //                           provider.isMultipleSelect = true;
  //                           Navigator.pop(context);
  //                         },
  //                       ),
  //                 CupertinoContextMenuAction(
  //                   child: Text("Copy"),
  //                   trailingIcon: CupertinoIcons.heart,
  //                   onPressed: () {
  //                     provider.isMultipleSelect = false;
  //                     Clipboard.setData(
  //                       ClipboardData(
  //                         text: statements?[statementIndex].statementText ?? "",
  //                       ),
  //                     );
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //                 CupertinoContextMenuAction(
  //                   child: Text("Add Note"),
  //                   trailingIcon: CupertinoIcons.add_circled,
  //                   onPressed: () {
  //                     if (!provider.isMultipleSelect) {
  //                       provider.toggleData(statementIndex, verses?.chapterId);
  //                     }
  //                     provider.isMultipleSelect = false;
  //                     Navigator.pop(context);
  //                     provider.showCustomBottomSheet(
  //                         context, provider.getSelectedBibleTextIds());
  //                   },
  //                 ),
  //                 CupertinoContextMenuAction(
  //                   child: Text("Share"),
  //                   trailingIcon: CupertinoIcons.share,
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                     provider.isMultipleSelect = false;
  //                     shareToWhatsAppText(
  //                         statements?[statementIndex].statementNo.toString() ??
  //                             "",
  //                         statements?[statementIndex].statementText ?? "",
  //                         "");
  //                   },
  //                 )
  //               ],
  //               builder: (BuildContext context, Animation<double> animation) {
  //                 return Padding(
  //                   padding:
  //                       const EdgeInsets.only(left: 8.0, right: 8.0, top: 4),
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       color: statements![statementIndex].isSelected
  //                           ? Colors.grey.withOpacity(0.3)
  //                           : Colors.white,
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Stack(
  //                         children: [
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               AutoSizeText(
  //                                 statements[statementIndex]
  //                                         .statementNo
  //                                         .toString() ??
  //                                     "",
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 12),
  //                                 minFontSize: 7,
  //                                 maxLines: 1,
  //                               ),
  //                               SizedBox(width: 8),
  //                               SizedBox(
  //                                 width: SizeUtils.width / 1.3,
  //                                 child: GestureDetector(
  //                                   onTap: () {
  //                                     if (provider.isMultipleSelect) {
  //                                       provider.toggleData(
  //                                           statementIndex, verses?.chapterId);
  //                                     }
  //                                   },
  //                                   child: statements[statementIndex]
  //                                               .color_marking !=
  //                                           null
  //                                       ? HtmlWidget(
  //                                           '<span style="background-color: #${statements[statementIndex].color_marking};">${statements[statementIndex].statementText ?? ""}</span>',
  //                                           textStyle: TextStyle(
  //                                             color: Colors.white,
  //                                           ),
  //                                         )
  //                                       : HtmlWidget(
  //                                           statements[statementIndex]
  //                                                   .statementText ??
  //                                               "",
  //                                           textStyle: TextStyle(
  //                                               decoration: TextDecoration.none,
  //                                               fontSize: 16,
  //                                               color: Colors.black),
  //                                         ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           Column(
  //                             children: [
  //                               statements[statementIndex].note_marking != null
  //                                   ? GestureDetector(
  //                                       onTap: () {
  //                                         showDialog(
  //                                           context: context,
  //                                           builder: (BuildContext context) {
  //                                             return AlertDialog(
  //                                               title: Text('Note'),
  //                                               content: Text(
  //                                                   statements[statementIndex]
  //                                                           .note_marking ??
  //                                                       ''),
  //                                               actions: [
  //                                                 TextButton(
  //                                                   child: Text('Close'),
  //                                                   onPressed: () {
  //                                                     Navigator.of(context)
  //                                                         .pop();
  //                                                   },
  //                                                 ),
  //                                               ],
  //                                             );
  //                                           },
  //                                         );
  //                                       },
  //                                       child: Align(
  //                                         alignment: Alignment.topRight,
  //                                         child: CustomImageView(
  //                                           width: 20,
  //                                           height: 20,
  //                                           imagePath: ImageConstant.comments,
  //                                         ),
  //                                       ),
  //                                     )
  //                                   : SizedBox(),
  //                               SizedBox(height: 2),
  //                               statements[statementIndex].bookmarkMarking !=
  //                                       null
  //                                   ? GestureDetector(
  //                                       onTap: () {
  //                                         showDialog(
  //                                           context: context,
  //                                           builder: (BuildContext context) {
  //                                             return AlertDialog(
  //                                               title: Text('Tags'),
  //                                               content: Container(
  //                                                   width: double.maxFinite,
  //                                                   child: Row(
  //                                                     mainAxisAlignment:
  //                                                         MainAxisAlignment
  //                                                             .start,
  //                                                     children: (statements[
  //                                                                     statementIndex]
  //                                                                 ?.bookmarkMarking ??
  //                                                             [])
  //                                                         .map<Widget>(
  //                                                             (bookmark) =>
  //                                                                 Padding(
  //                                                                   padding: const EdgeInsets
  //                                                                       .only(
  //                                                                       right:
  //                                                                           8.0),
  //                                                                   child: Text(
  //                                                                     bookmark?.tagName ??
  //                                                                         "",
  //                                                                     style: TextStyle(
  //                                                                         fontSize:
  //                                                                             16),
  //                                                                   ),
  //                                                                 ))
  //                                                         .toList(),
  //                                                   )),
  //                                               actions: [
  //                                                 TextButton(
  //                                                   child: Text('Close'),
  //                                                   onPressed: () {
  //                                                     Navigator.of(context)
  //                                                         .pop();
  //                                                   },
  //                                                 ),
  //                                               ],
  //                                             );
  //                                           },
  //                                         );
  //                                       },
  //                                       child: Align(
  //                                         alignment: Alignment.bottomRight,
  //                                         child: CustomImageView(
  //                                           width: 20,
  //                                           height: 20,
  //                                           imagePath: ImageConstant.attachment,
  //                                         ),
  //                                       ),
  //                                     )
  //                                   : SizedBox(),
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

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
