import 'package:encounter_app/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/circular_loader.dart';
import '../../widgets/custom_image_view.dart';
import 'models/bible_model.dart';
import 'provider/bible_provider.dart'; // ignore_for_file: must_be_immutable

class BiblePage extends StatefulWidget {
  const BiblePage({Key? key})
      : super(
          key: key,
        );

  @override
  BiblePageState createState() => BiblePageState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BibleProvider(),
      child: BiblePage(),
    );
  }
}

class BiblePageState extends State<BiblePage>
    with AutomaticKeepAliveClientMixin<BiblePage> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BibleProvider>(context, listen: false).getBibleList();
    });
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 164.h,
      leading: AppbarTitle(
        text: "Bible",
        margin: EdgeInsets.only(left: 24.h, top: 10.v),
      ),
      actions: [
        // AppbarTrailingImage(
        //     imagePath: ImageConstant.imgShare11,
        //     onTap: () => {
        //           // shareToWhatsApp(model.subject ?? "",
        //           //     model.messageBody ?? "", model.image ?? "")
        //         },
        //     margin: EdgeInsets.only(left: 5.h, top: 17.v, right: 38.h))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BibleProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return LoaderWidget();
        }
        return Scaffold(
          backgroundColor: appTheme.gray10001,
          appBar: _buildAppBar(context),
          body: Stack(
            children: [
              SizedBox(
                width: SizeUtils.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xFFECF4FB),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<BibleProvider>(context,
                                        listen: false)
                                    .selectOldTestament();
                              },
                              child: Container(
                                width: SizeUtils.width / 3,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: provider.isSelectedOldTestament
                                        ? Color(0xFF236EB1)
                                        : Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: provider.isSelectedOldTestament
                                          ? Color(0xFF236EB1)
                                          : Colors.white,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                // color: value ? Colors.blue : Colors.grey,
                                child: Center(
                                  child: Text(
                                    "Old Testament",
                                    style: TextStyle(
                                      color: provider.isSelectedOldTestament
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Manrope',
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Provider.of<BibleProvider>(context,
                                        listen: false)
                                    .selectNewTestament();

                                // model.selectNewTestament();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: SizeUtils.width / 3,
                                decoration: BoxDecoration(
                                    color: provider.isSelectedNewTestament
                                        ? Color(0xFF236EB1)
                                        : Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: provider.isSelectedNewTestament
                                          ? Color(0xFF236EB1)
                                          : Colors.white,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Center(
                                  child: Text(
                                    "New Testament",
                                    style: TextStyle(
                                      color: provider.isSelectedNewTestament
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Manrope',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Selector<BibleProvider, BibleListModel>(
                        selector: (context, provider) => provider.bibleRespo,
                        builder: (context, value, child) {
                          return _buildViewHierarchy(context, value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildViewHierarchy(BuildContext context, BibleListModel data) {
    return ListView.builder(
      physics: ScrollPhysics(),
      itemCount: data.data?.length ?? 0,
      itemBuilder: (context, index) {
        BibileData? item = data.data?[index];
        return GestureDetector(
          onTap: () {
            NavigatorService.pushNamed(AppRoutes.bibleDetailScreen,
                arguments: item?.bookId.toString());
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24.h),
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: appTheme.borderColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, top: 6.0, bottom: 6.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        CustomImageView(
                          imagePath: item?.book_image ??
                              ImageConstant.imgRectangle4323,
                          height: 54.adaptSize,
                          width: 54.adaptSize,
                          // width: 156.adaptSize,
                          radius: BorderRadius.circular(
                            7.h,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item?.bookName ?? "Test name",
                            style: CustomTextStyles.titleSmallBluegray90002,
                          ),
                          Text(
                            "${item?.totalChapters} Chapters ",
                            style: CustomTextStyles.titleSmallBluegray90002,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    CustomImageView(
                      imagePath: ImageConstant.imgVector,
                      height: 10.v,
                      width: 10.h,
                      margin: EdgeInsets.fromLTRB(7.h, 22.v, 22.h, 22.v),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildViewHierarchy1(BuildContext context, BibleListModel data) {
    return ListView.builder(
      physics: ScrollPhysics(),
      itemCount: data.data?.length ?? 0,
      itemBuilder: (context, index) {
        BibileData? item = data.data?[index];

        return Padding(
          padding: const EdgeInsets.all(.0),
          child: Container(
            decoration: BoxDecoration(
                color: appTheme.whiteA700,
                border: Border.all(
                    width: 0.3, color: Color.fromARGB(255, 207, 223, 236)),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ExpansionTile(
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
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgRectangle4323,
                            height: 44,
                            width: 44,
                            // width: 156.adaptSize,
                            radius: BorderRadius.circular(
                              7.h,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item?.bookName ?? "Test name",
                              style: CustomTextStyles.titleSmallBluegray90002,
                            ),
                            Text(
                              "${item?.totalChapters} Chapters ",
                              style: CustomTextStyles.titleSmallBluegray90002,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                maintainState: true,
                expandedAlignment: Alignment.center,
                children:
                    List<Widget>.generate(item?.chapters?.length ?? 0, (index) {
                  var chapters = item?.chapters?[index];
                  int statemnets_count = chapters?.statements?.length ?? 0;
                  int item_count = chapters?.statements?.length ?? 0;
                  if (statemnets_count > 2) {
                    statemnets_count = 1;
                  }
                  return Column(
                    children: [
                      Wrap(
                        children:
                            List<Widget>.generate(statemnets_count, (index) {
                          var statement = chapters?.statements?[index];
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(statement?.statementText ?? ""),
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                })),
          ),
        );
      },
    );
  }
}

 





     // Column(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Expanded(child: _buildViewHierarchy(context)),
                //     // // Padding(
                //     //   padding: EdgeInsets.only(left: 1.h),
                //     //   child: Column(
                //     //     children: [
                //     //       Padding(
                //     //         padding: EdgeInsets.only(
                //     //           left: 22.h,
                //     //           right: 23.h,
                //     //         ),
                //     //         child: Selector<BibleProvider, BibleModel?>(
                //     //           selector: (context, provider) =>
                //     //               provider.bibleModelObj,
                //     //           builder: (context, bibleModelObj, child) {
                //     //             return CustomDropDown(
                //     //               hintText: "lbl_genesis".tr,
                //     //               items: bibleModelObj?.dropdownItemList ?? [],
                //     //             );
                //     //           },
                //     //         ),
                //     //       ),
                //     //       SizedBox(height: 34.v),
                //     //       // _buildChaptersCounterRowFourteen(context),
                //     //       SizedBox(height: 29.v),
                //     //       Align(
                //     //         alignment: Alignment.centerLeft,
                //     //         child: Padding(
                //     //           padding: EdgeInsets.only(left: 22.h),
                //     //           child: Text(
                //     //             "lbl_genesis_19".tr,
                //     //             style: theme.textTheme.titleLarge,
                //     //           ),
                //     //         ),
                //     //       ),
                //     //       SizedBox(height: 9.v),
                //     //       Align(
                //     //         alignment: Alignment.centerLeft,
                //     //         child: Padding(
                //     //           padding: EdgeInsets.only(left: 22.h),
                //     //           child: Text(
                //     //             "msg_the_destruction".tr,
                //     //             style: CustomTextStyles.titleSmallBluegray90002,
                //     //           ),
                //     //         ),
                //     //       ),
                //     //       SizedBox(height: 17.v),
                //     //       Container(
                //     //         width: 327.h,
                //     //         margin: EdgeInsets.only(
                //     //           left: 21.h,
                //     //           right: 23.h,
                //     //         ),
                //     //         child: Text(
                //     //           "msg_the_two_angels_arrived".tr,
                //     //           maxLines: 21,
                //     //           overflow: TextOverflow.ellipsis,
                //     //           style: CustomTextStyles.bodyMedium13.copyWith(
                //     //             height: 1.50,
                //     //           ),
                //     //         ),
                //     //       ),
                //     //       Text(
                //     //         "lbl_show_more".tr,
                //     //         style: CustomTextStyles.titleMediumBluegray500,
                //     //       ),
                //     //       SizedBox(height: 3.v),
                //     //       CustomImageView(
                //     //         imagePath: ImageConstant.imgPolygon5,
                //     //         height: 8.v,
                //     //         width: 14.h,
                //     //       ),
                //     //       SizedBox(height: 27.v),
                //     //       Padding(
                //     //         padding: EdgeInsets.only(
                //     //           left: 22.h,
                //     //           right: 23.h,
                //     //         ),
                //     //         child: Selector<BibleProvider, BibleModel?>(
                //     //           selector: (context, provider) =>
                //     //               provider.bibleModelObj,
                //     //           builder: (context, bibleModelObj, child) {
                //     //             return CustomDropDown(
                //     //               hintText: "lbl_exodus".tr,
                //     //               items: bibleModelObj?.dropdownItemList1 ?? [],
                //     //             );
                //     //           },
                //     //         ),
                //     //       ),
                //     //       SizedBox(height: 16.v),
                //     //       Padding(
                //     //         padding: EdgeInsets.only(
                //     //           left: 22.h,
                //     //           right: 23.h,
                //     //         ),
                //     //         child: Selector<BibleProvider, BibleModel?>(
                //     //           selector: (context, provider) =>
                //     //               provider.bibleModelObj,
                //     //           builder: (context, bibleModelObj, child) {
                //     //             return CustomDropDown(
                //     //               hintText: "lbl_leviticus".tr,
                //     //               items: bibleModelObj?.dropdownItemList2 ?? [],
                //     //             );
                //     //           },
                //     //         ),
                //     //       )
                //     //     ],
                //     //   ),
                //     // )
                //   ],
                // ),
          