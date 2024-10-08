import 'package:encounter_app/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import 'provider/video_player_provider.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VideoPlayerProvider(),
      child: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
        //color set to transperent or set your own color
        ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String videoId = ModalRoute.of(context)!.settings.arguments as String;
    });
  }

  _changeStatusBarToLight() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    return Consumer<VideoPlayerProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return LoaderWidget();
      }
      controller.loadRequest(Uri.parse(
          'https://www.youtube.com/embed/bLrd5poEbJY?autoplay=1&controls=0'));
      return Scaffold(
        backgroundColor: appTheme.black900,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 50),
              child: AppbarLeadingIconbutton(
                  imagePath: ImageConstant.imgArrowLeft,
                  margin: EdgeInsets.only(left: 1.h, right: 1.h),
                  onTap: () {
                    // provider.controller.dispose();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    });
                  }),
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(
                    left: 2.h,
                    right: 2.h,
                  ),
                  child: SizedBox(
                    height: 400,
                    child: WebViewWidget(
                      controller: controller,
                    ),
                  )),
            ),
          ],
        ),
      );
    });
  }

  ///
}
