import 'package:encounter_app/presentation/ask_questions_page/provider/my_notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../notes_list/curved_decoration.dart';
import '../notes_list/tab_item_widget.dart';
import '../profile_screen/models/my_notes_respo.dart';
import 'models/got_question_model.dart';

class MyNotesPage extends StatefulWidget {
  const MyNotesPage({Key? key})
      : super(
          key: key,
        );

  @override
  MyNotesPageState createState() => MyNotesPageState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyNotesProvider(),
      child: MyNotesPage(),
    );
  }
}

class MyNotesPageState extends State<MyNotesPage>
    with AutomaticKeepAliveClientMixin<MyNotesPage>, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  late TabController tabviewController;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MyNotesProvider>(context, listen: false).getMyNotes();
    });
  }

  void _handleTabChange() {
    var index = tabviewController.index;
    print('Current tab index: ${tabviewController.index}');

    // Provider.of<DirectoryListProvider>(context, listen: false)
    //     .getDirectoryByPagination(index, 0);
  }

  @override
  void dispose() {
    tabviewController.removeListener(_handleTabChange);
    tabviewController.dispose();
    super.dispose();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 164.h,
      leading: AppbarTitle(
        text: "My Notes",
        margin: EdgeInsets.only(left: 24.h, top: 20.v),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MyNotesProvider>(builder: (context, provider, child) {
        List<Widget>? tabViewChildren = [];
        List<Widget>? tabItem = [];
        tabItem = provider.respo.data?.map((data) {
          return TabItemWidget(data.category ?? "");
        }).toList();
        tabViewChildren = provider.respo.data?.map((data) {
          return _buildViewHierarchy(
            context,
            data,
          );
        }).toList();

        tabviewController = TabController(
            length: provider.respo.data?.length ?? 0, vsync: this);
        tabviewController.index = provider.position;
        tabviewController.addListener(_handleTabChange);
        print("realod");
        return Column(
          children: [
            SizedBox(height: 40.v),
            Row(
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
                        "My Notes".tr,
                        style: theme.textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
              ],
            ),
            _buildTabview(context, tabItem),
            Expanded(
              child: TabBarView(
                controller: tabviewController,
                children: tabViewChildren ?? [],
              ),
            ),
          ],
        );
      }),
    );
  }

  /// Section Widget
  Widget _buildTabview(
    BuildContext context,
    List<Widget>? tabItem,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 20.h, top: 10, bottom: 10.h),
      child: Container(
        height: 52.v,
        decoration: CurvedDecoration(color: Colors.white),
        child: TabBar(
            controller: tabviewController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: appTheme.whiteA70001,
            unselectedLabelColor: theme.colorScheme.secondaryContainer,
            unselectedLabelStyle: TextStyle(
              fontSize: 14.fSize,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            dividerHeight: 0,
            dividerColor: Colors.transparent,
            indicatorPadding: EdgeInsets.only(
                left: 0.0.h, right: 1.0.h, top: 3.0.h, bottom: 3.0.h),
            indicator: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(
                18.h,
              ),
            ),
            tabs: tabItem ?? []),
      ),
    );
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
              "My Notes",
              style: CustomTextStyles.largeManrope24Bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewHierarchy(BuildContext context, NotesData data) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: data?.list?.length ?? 0,
      itemBuilder: (context, index) {
        ListItem? item = data.list?[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 24.h, vertical: 6),
          padding: EdgeInsets.symmetric(
            horizontal: 11.h,
            vertical: 15.v,
          ),
          decoration: BoxDecoration(
              // color:  Color.fromARGB(255, 143, 187, 226),
              border: Border.all(
                width: 1,
                color: Color.fromARGB(255, 143, 187, 226),
              ),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " ${item?.bookName} ${item?.verseNo}  : ${item?.statementId} ",
                style: CustomTextStyles.titleSmallBluegray90002,
              ),
              data.category == "Highlghts"
                  ? HtmlWidget(
                      '<span style="background-color: #${item?.data};">${item?.verseStatement ?? ""}</span>',
                      textStyle: TextStyle(
                        color: Colors.white, // Optional text color
                      ),
                    )
                  : HtmlWidget(item?.verseStatement ?? ""),
              SizedBox(
                height: 10,
              ),
              data.category == "Bookmarks"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // Align items to the start of the row
                      children: (item?.markedData ?? [])
                          .map<Widget>((bookmark) => Padding(
                                padding: const EdgeInsets.only(
                                    right:
                                        8.0), // Add some spacing between items
                                child: Text(
                                  bookmark,
                                  style: TextStyle(
                                      fontSize:
                                          16), // Adjust font size if needed
                                ),
                              ))
                          .toList(),
                    )
                  : SizedBox(),
              data.category == "Notes"
                  ? Text(
                      " ${item?.data}",
                      style: CustomTextStyles.titleSmallBluegray90002,
                    )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
