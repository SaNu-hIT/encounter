import 'package:encounter_app/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package

import '../../core/app_export.dart';
import '../../core/utils/size_utils.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../home_page/models/home_respo.dart';
import '../home_page/provider/home_provider.dart';
import '../home_page/widgets/viewhierarchy_item_widget.dart';

class StudyHomePage extends StatefulWidget {
  const StudyHomePage({Key? key})
      : super(
          key: key,
        );

  @override
  HomePageState createState() => HomePageState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: StudyHomePage(),
    );
  }
}

class HomePageState extends State<StudyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).getHome("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
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
                  Text(
                    "Bible Study",
                    style: TextStyle(
                      fontSize: 16, // Example font size
                      color: appTheme.black900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Stay Rooted in God’s Word",
                    style: TextStyle(
                      fontSize: 12, // Example font size
                      color: appTheme.black900,
                    ),
                  ),
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
      leadingWidth: 164.h,
      leading: AppbarTitle(
        text: "Study",
        margin: EdgeInsets.only(left: 24.h, top: 10.v),
      ),
    );
  }

  Widget _buildViewHierarchy(BuildContext context, HomeProvider provider) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = (screenWidth - 60) / 2;
    return GridView.builder(
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: itemWidth / (itemWidth + 70),
        // childAspectRatio:
        //     0.78, // Adjust the aspect ratio of grid items as needed
        crossAxisSpacing: 10.0, // Adjust the spacing between columns
        mainAxisSpacing: 10.0, // Adjust the spacing between rows
      ),
      itemCount: provider.respo.data?.first.list?.length ?? 0,
      itemBuilder: (context, index) {
        BibileList model = provider.respo.data!.first.list![index];
        return CourseListWidget(
          model,
        );
      },
    );
  }
}
