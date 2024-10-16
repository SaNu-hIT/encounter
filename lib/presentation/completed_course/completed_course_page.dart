import 'package:encounter_app/presentation/completed_course/provider/completed_provider.dart';
import 'package:encounter_app/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package

import '../../core/app_export.dart';
import '../../core/utils/size_utils.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../home_page/models/home_respo.dart';
import '../home_page/widgets/viewhierarchy_item_widget.dart';

class CompletedCoursePage extends StatefulWidget {
  const CompletedCoursePage({Key? key})
      : super(
          key: key,
        );

  @override
  CompletedCourseState createState() => CompletedCourseState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CompletedProvider(),
      child: CompletedCoursePage(),
    );
  }
}

class CompletedCourseState extends State<CompletedCoursePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CompletedProvider>(context, listen: false)
          .getCompletedCourse("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CompletedProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return LoaderWidget();
      }

      return Scaffold(
        backgroundColor: appTheme.gray10001,
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 14),
                ],
              ),
              Expanded(
                child: _buildViewHierarchy(context, provider),
              ),
            ],
          ),
        ),
      );
    });
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 16,
          ),
          AppbarLeadingIconbutton(
              imagePath: ImageConstant.imgArrowLeft,
              margin: EdgeInsets.only(left: 1.h, right: 1.h),
              onTap: () {
                onTapArrowLeft(context);
              }),
          SizedBox(
            width: 16,
          ),
          AppbarTitle(
            text: "Completed",
            margin: EdgeInsets.only(
              left: 2.h,
            ),
          ),
        ],
      ),
      leadingWidth: 184.h,
    );
  }

  Widget _buildViewHierarchy(BuildContext context, CompletedProvider provider) {
    return GridView.builder(
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio:
            0.73, // Adjust the aspect ratio of grid items as needed
        crossAxisSpacing: 10.0, // Adjust the spacing between columns
        mainAxisSpacing: 10.0, // Adjust the spacing between rows
      ),
      itemCount: provider.respo.data?.length ?? 0,
      itemBuilder: (context, index) {
        BibileList model = BibileList();
        model.id = provider.respo.data?[index].batchId;
        model.image = provider.respo.data?[index].image;
        model.data1 = provider.respo.data?[index].data1;
        model.data2 = provider.respo.data?[index].data2;
        model.data3 = provider.respo.data?[index].data3;
        model.data4 = provider.respo.data?[index].data4;

        return CourseListWidget(
          model,
        );
      },
    );
  }
}

/// Navigates to the previous screen.
onTapArrowLeft(BuildContext context) {
  NavigatorService.goBack();
}
