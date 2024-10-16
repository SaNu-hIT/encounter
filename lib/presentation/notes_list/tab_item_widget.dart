import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  TabItemWidget(
    this.text, {
    Key? key,
  }) : super(key: key);
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(100), // Adjust the radius as needed
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Tab(
          child: Text(text),
        ),
      ),
    );
  }
}
