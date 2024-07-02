import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/home_container_model.dart';

/// A provider class for the HomeContainerScreen.
///
/// This provider manages the state of the HomeContainerScreen, including the
/// current homeContainerModelObj
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class HomeContainerProvider extends ChangeNotifier {
  HomeContainerModel homeContainerModelObj = HomeContainerModel();

  @override
  void dispose() {
    super.dispose();
  }
}
