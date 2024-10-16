import 'package:encounter_app/presentation/notes_list/curved_decoration.dart';
import 'package:flutter/material.dart';

import '../../theme/theme_helper.dart';

class TabBodyWidget extends StatelessWidget {
  TabBodyWidget(
    this.tabItemDir,
    this.tabviewController, {
    Key? key,
  }) : super(key: key);
  List<Widget>? tabItemDir;
  TabController? tabviewController;
  @override
  Widget build(BuildContext context) {
    if (tabItemDir == null || tabviewController == null) {
      return SizedBox();
    }
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 0),
      child: Container(
        height: 52,
        decoration: CurvedDecoration(color: Colors.white),
        child: TabBar(
            controller: tabviewController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: appTheme.whiteA70001,
            dividerColor: Colors.transparent,
            labelStyle: TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            dividerHeight: 0,
            unselectedLabelColor: theme.colorScheme.secondaryContainer,
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            indicatorPadding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            indicator: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(
                50,
              ),
            ),
            tabs: tabItemDir ?? []),
      ),
    );
  }
}
