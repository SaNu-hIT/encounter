import 'package:encounter_app/presentation/ask_questions_page/provider/my_notes_provider.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
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
    with AutomaticKeepAliveClientMixin<MyNotesPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MyNotesProvider>(context, listen: false).getMyNotes();
    });
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
    return Consumer<MyNotesProvider>(builder: (context, provider, child) {
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
              "My Notes",
              style: CustomTextStyles.largeManrope24Bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewHierarchy(BuildContext context, MyNotesRespo data) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: data.data?.length ?? 0,
      itemBuilder: (context, index) {
        NotesData? item = data.data?[index];
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
                " Bibile Name : ${item?.bibleName}",
                style: CustomTextStyles.titleSmallBluegray90002,
              ),
              Text(
                " Testament Name : ${item?.testamentName}",
                style: CustomTextStyles.titleSmallBluegray90002,
              ),
              Text(
                " Book Name : ${item?.bookName}",
                style: CustomTextStyles.titleSmallBluegray90002,
              ),
              Text(
                " Chapter Name : ${item?.chapterName}",
                style: CustomTextStyles.titleSmallBluegray90002,
              ),
                 Text(
                "Category : ${item?.category}",
                style: CustomTextStyles.titleSmallBluegray90002,
              ),
              Text(
                "Note : ${item?.note}",
                style: CustomTextStyles.titleSmallBluegray90002,
              ),
            ],
          ),
        );
      },
    );
  }
}
