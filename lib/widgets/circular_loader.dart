import 'package:flutter/material.dart';

class CircularLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Center(
        //   child: Image.asset(
        //     logo,
        //     height: 35,
        //   ),
        // ),
        const Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
