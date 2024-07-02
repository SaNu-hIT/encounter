import 'package:flutter/material.dart';
import '../core/app_export.dart'; // ignore: must_be_immutable

class CustomPhoneNumber extends StatelessWidget {
  const CustomPhoneNumber({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Opacity(
              opacity: 0.2,
              child: Container(
                height: 1.v,
                width: 256.h,
                margin: EdgeInsets.only(
                  left: 13.h,
                  top: 28.v,
                  bottom: 29.v,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            )
          ],
        ),
        Container(
          height: 1.v,
          width: 272.h,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        )
      ],
    );
  }
}
