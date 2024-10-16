import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/loader_widget.dart';
import 'models/study_details_item_model.dart';
import 'provider/study_details_provider.dart';
import 'sized_icon_button.dart';
import 'widgets/study_details_item_widget.dart';

import 'package:spotify_sdk/models/player_state.dart' as spState;
import 'package:spotify_sdk/spotify_sdk.dart';

class CouseDetailsScreen extends StatefulWidget {
  const CouseDetailsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  StudyDetailsScreenState createState() => StudyDetailsScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudyDetailsProvider(),
      child: CouseDetailsScreen(),
    );
  }
}

class StudyDetailsScreenState extends State<CouseDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      // Extract the two variables
      String course_day_id = args['course_day_id'] as String;
      String userLmsId = args['userLmsId'] as String;
      String day = args['day'] as String;

      Provider.of<StudyDetailsProvider>(context, listen: false)
          .getDayDetails(course_day_id, userLmsId, day);
    });
  }

  _changeStatusBarToLight() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  bool _connected = false;
  late ImageUri? currentTrackImageUri;
  Future<void> showConfirmAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are You Sure'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Completing the course.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyDetailsProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return LoaderWidget();
      }
      return Scaffold(
        backgroundColor: appTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: appTheme.backgroundColor,
          title: Text(
            provider.capitalizeFirstLetter(
                provider.respo_day.data?.courseName ?? ""),
            style: CustomTextStyles.titleLargeManropeHead,
          ),
          titleSpacing: 0,
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: GestureDetector(
                  onTap: () {
                    provider.showConfirmAlert(context).then((val) => {
                          {Navigator.of(context).pop(true)}
                        });
                  },
                  child: Text("COMPLETE")),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ScrollableListTabScroller.defaultComponents(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                headerContainerProps: HeaderContainerProps(height: 50),
                tabBarProps:
                    TabBarProps(dividerColor: Colors.blue.withOpacity(0.0)),
                addRepaintBoundaries: false,
                itemCount: provider.respo_day.data?.courseDayVerse?.length ?? 0,
                tabBuilder: (BuildContext context, int index1, bool active) =>
                    Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: active ? appTheme.teal300 : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 35,
                    // width: 35,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13),
                      child: Center(
                        child: Text(
                          '${provider.respo_day.data?.courseDayVerse?[index1].bookName ?? ""} '
                          '${provider.respo_day.data?.courseDayVerse?[index1].chapterNo ?? ""}: '
                          '${provider.respo_day.data?.courseDayVerse?[index1].verseFromName ?? ""} - '
                          '${provider.respo_day.data?.courseDayVerse?[index1].verseToName ?? ""}',
                          style: TextStyle(
                            fontWeight:
                                active ? FontWeight.bold : FontWeight.normal,
                            color: active ? Colors.white : Colors.black,
                            fontSize: active ? 18 : 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                itemBuilder: (BuildContext context, int index2) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 12),
                      child: AutoSizeText(
                        '${provider.respo_day.data?.courseDayVerse?[index2].bookName ?? ""} '
                        '${provider.respo_day.data?.courseDayVerse?[index2].chapterNo ?? ""}: '
                        '${provider.respo_day.data?.courseDayVerse?[index2].verseFromName ?? ""} - '
                        '${provider.respo_day.data?.courseDayVerse?[index2].verseToName ?? ""}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ContinuousBibleText(context, provider, index2),
                    SizedBox(height: 14.v),
                    index2 + 1 ==
                            provider.respo_day.data?.courseDayVerse?.length
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 24.h),
                                child: Text(
                                  "About the course".tr,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                              SizedBox(height: 11.v),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 325.h,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 24.h),
                                  child: Text(
                                    provider.respo_day.data?.textDescription ??
                                        "",
                                    maxLines: 6,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      height: 1.50,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 12.v),
                              Padding(
                                padding: EdgeInsets.only(left: 24.h),
                                child: Text(
                                  "lbl_video".tr,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                              SizedBox(height: 8.v),
                              // Padding(
                              //   padding: EdgeInsets.only(
                              //     left: 24.h,
                              //     right: 24.h,
                              //   ),
                              //   child: player,
                              // ),
                              SizedBox(height: 8.v),

                              provider.controllerDay != null
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        left: 24.h,
                                        right: 23.h,
                                      ),
                                      child: YoutubePlayer(
                                        controller: provider.controllerDay!,
                                        bottomActions: [
                                          CurrentPosition(),
                                          ProgressBar(isExpanded: true)
                                          // TotalDuration(),
                                        ],
                                        showVideoProgressIndicator: true,
                                        progressIndicatorColor: Colors.amber,
                                        progressColors: const ProgressBarColors(
                                          playedColor: Colors.amber,
                                          handleColor: Colors.amberAccent,
                                        ),
                                        onReady: () {},
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 10,
                              ),

                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(bottom: 2),
                                  itemCount: provider.respo_day.data
                                      ?.courseContentVideoLink?.length,
                                  itemBuilder: (context1, itemIndex) {
                                    var video_link = provider
                                        .respo_day
                                        .data
                                        ?.courseContentVideoLink?[itemIndex]
                                        .videoSpotifyLink;
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 24.h, right: 23.h, bottom: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          provider.loadNext(video_link);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 198, 229, 249),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(0.2 *
                                                  71.h), // 10% curve (0.1 times the width of the container)
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              CustomImageView(
                                                width: 80,
                                                height: 80,
                                                imagePath:
                                                    ImageConstant.imageNotFound,
                                              ),
                                              SizedBox(
                                                  width: SizeUtils.width / 1.5,
                                                  child: Text(
                                                      video_link ?? "Video")),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),

                              // GestureDetector(
                              //   onTap: () {
                              //     NavigatorService.pushNamed(
                              //         AppRoutes.videoPlayerScreen,
                              //         arguments: provider
                              //             .respo.data?.first.introVideo
                              //             .toString());
                              //   },
                              //   child: CustomImageView(
                              //     imagePath:
                              //         null != provider.respo_day.data?.image
                              //             ? provider.respo_day.data?.videoLink
                              //             : ImageConstant.imgImage,
                              //     height: 200.v,
                              //     width: 326.h,
                              //     alignment: Alignment.center,
                              //   ),
                              // ),
                              SizedBox(height: 8.v),
                              Padding(
                                padding: EdgeInsets.only(left: 24.h),
                                child: Text(
                                  "${provider.respo_day.data?.courseName}",
                                  style:
                                      CustomTextStyles.titleSmallBluegray90003,
                                ),
                              ),
                              SizedBox(height: 6.v),
                              Padding(
                                padding: EdgeInsets.only(left: 24.h),
                                child: Text(
                                  "Explaining ${provider.respo_day.data?.courseName}",
                                  style: CustomTextStyles.bodySmallGray700,
                                ),
                              ),
                              SizedBox(height: 15.v),
                              Padding(
                                padding: EdgeInsets.only(left: 24.h),
                                child: Text(
                                  "Audio".tr,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                              SizedBox(height: 8.v),

                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    _buildPlayerStateWidget(),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(),
                                        child: CustomIconButton(
                                          height: 32.adaptSize,
                                          width: 32.adaptSize,
                                          onTap: () {
                                            provider.playAudio(provider
                                                .respo_day
                                                .data
                                                ?.courseContentSpotifyLink
                                                ?.first
                                                .videoSpotifyLink);
                                          },
                                          padding: EdgeInsets.all(7.h),
                                          decoration:
                                              IconButtonStyleHelper.fillGreenA,
                                          child: CustomImageView(
                                            imagePath: provider.isPlaying
                                                ? ImageConstant.imgPlay
                                                : ImageConstant.imgPause,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(bottom: 2),
                                  itemCount: provider.respo_day.data
                                      ?.courseContentSpotifyLink?.length,
                                  itemBuilder: (context1, index2) {
                                    var link = provider
                                        .respo_day
                                        .data
                                        ?.courseContentSpotifyLink?[index2]
                                        .videoSpotifyLink;

                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: 23.h, right: 23.h, bottom: 8),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 1.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 198, 229, 249),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(0.2 *
                                                    71.h), // 10% curve (0.1 times the width of the container)
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomImageView(
                                                    imagePath:
                                                        ImageConstant.spotify,
                                                  ),

                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        provider
                                                            .playAudio(link);
                                                      },
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Spotify Link",
                                                            style: CustomTextStyles
                                                                .labelLargeManropeBluegray9000313,
                                                          ),
                                                          SizedBox(height: 3.v),
                                                          // Text(
                                                          //   "",
                                                          //   style: CustomTextStyles
                                                          //       .bodySmallGray700,
                                                          // )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.only(),
                                                  //   child: CustomIconButton(
                                                  //     height: 32.adaptSize,
                                                  //     width: 32.adaptSize,
                                                  //     onTap: () {
                                                  //       provider
                                                  //           .playAudio(link);
                                                  //     },
                                                  //     padding:
                                                  //         EdgeInsets.all(7.h),
                                                  //     decoration:
                                                  //         IconButtonStyleHelper
                                                  //             .fillGreenA,
                                                  //     child: CustomImageView(
                                                  //       imagePath:
                                                  //           provider.isPlaying
                                                  //               ? ImageConstant
                                                  //                   .imgPlay
                                                  //               : ImageConstant
                                                  //                   .imgPause,
                                                  //     ),
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),

                              // _buildColumnAudio(context, provider),
                              // SizedBox(height: 22.v),
                              // _buildColumnRelated(context),
                              // SizedBox(height: 21.v),
                              // _buildColumnAddNote(context),
                              // SizedBox(height: 17.v),
                              // _buildRowSpacerTwo(context, provider),
                              // SizedBox(height: 24.v),
                              // Padding(
                              //   padding: EdgeInsets.only(left: 24.h),
                              //   child: Text(
                              //     "lbl_previous_notes".tr,
                              //     style: theme.textTheme.titleMedium,
                              //   ),
                              // ),
                              // SizedBox(height: 13.v),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(horizontal: 23.h),
                              //   child: _buildRowEyeOne(
                              //     context,
                              //     monthText: "msg_audio_file_from".tr,
                              //   ),
                              // ),
                              // SizedBox(height: 11.v),
                              // Align(
                              //   alignment: Alignment.center,
                              //   child: Divider(
                              //     color: appTheme.black900.withOpacity(0.08),
                              //     indent: 27.h,
                              //     endIndent: 24.h,
                              //   ),
                              // ),
                              // SizedBox(height: 8.v),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(horizontal: 23.h),
                              //   child: _buildRowEyeOne(
                              //     context,
                              //     monthText: "msg_text_file_from_24".tr,
                              //   ),
                              // ),
                              SizedBox(height: 24.v),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "msg_mark_as_finished".tr,
                                  style: CustomTextStyles.titleSmallWhiteA700,
                                ),
                              )
                            ],
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  /// Section Widget
  Widget _buildStackArrowLeft(
      BuildContext context, StudyDetailsProvider provider) {
    return SizedBox(
      height: 100.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomImageView(
            imagePath: null != provider.respo_day.data?.image
                ? provider.respo_day.data?.image
                : ImageConstant.imgRectangle625,
            height: 400.v,
            fit: BoxFit.cover,
            width: SizeUtils.width,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  Widget ContinuousBibleText(
    BuildContext context,
    StudyDetailsProvider provider,
    int index,
  ) {
    var verses = provider.respo_day.data?.courseDayVerse?[index];
    var statements = verses?.statements;

    if (statements == null) return SizedBox();

    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: RichText(
        softWrap: true,
        text: TextSpan(
          children: statements.asMap().entries.map((entry) {
            int statementIndex = entry.key;
            var statement = entry.value;
            return WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: GestureDetector(
                onTap: () {
                  // Handle tap action here
                  print("Tapped on: ${statement.statementText}");
                  if (provider.isMultipleSelect) {
                    provider.toggleData(statementIndex, verses?.id);
                  }
                },
                onLongPress: () {
                  // Handle long-press action here
                  print("Long-pressed on: ${statement.statementText}");
                  provider.showAlertPopup(context, statement);
                },
                child: Container(
                  // color: statement.color_marking != null
                  //     ? Color(int.parse("0xff${statement.color_marking}"))
                  //     : Colors.transparent,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: statement.color_marking != null
                            ? Colors.white
                            : Colors.black,
                      ),
                      children: [
                        // Verse number
                        WidgetSpan(
                          alignment: PlaceholderAlignment.top,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Text(
                              "${statement.statementNo}",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        if (statement.color_marking != null)
                          TextSpan(
                            recognizer: LongPressGestureRecognizer()
                              ..onLongPress = () {
                                // Handle long-press action here
                                print(
                                    "Long-pressed on: ${statement.statementText}");
                                provider.showAlertPopup(context, statement);
                              },
                            text: statement.statementText ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              backgroundColor: Color(
                                int.parse("0xff${statement.color_marking}"),
                              ),
                              color: Colors.white,
                            ),
                          )
                        else
                          TextSpan(
                            text: statement.statementText ?? "",
                            style: TextStyle(
                              backgroundColor: statement.isSelected
                                  ? Colors.amber
                                  : Colors.white,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        // Add a space after each statement to keep it flowing
                        TextSpan(
                          text: " ",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> setShuffle(bool shuffle) async {
    try {
      await SpotifySdk.setShuffle(
        shuffle: shuffle,
      );
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> toggleShuffle() async {
    try {
      await SpotifySdk.toggleShuffle();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> setPlaybackSpeed(
      PodcastPlaybackSpeed podcastPlaybackSpeed) async {
    try {
      await SpotifySdk.setPodcastPlaybackSpeed(
          podcastPlaybackSpeed: podcastPlaybackSpeed);
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> play() async {
    try {
      await SpotifySdk.play(spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> resume() async {
    try {
      await SpotifySdk.resume();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> skipNext() async {
    try {
      await SpotifySdk.skipNext();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> seekTo() async {
    try {
      await SpotifySdk.seekTo(positionedMilliseconds: 20000);
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> seekToRelative() async {
    try {
      await SpotifySdk.seekToRelativePosition(relativeMilliseconds: 20000);
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> switchToLocalDevice() async {
    try {
      await SpotifySdk.switchToLocalDevice();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> addToLibrary() async {
    try {
      await SpotifySdk.addToLibrary(
          spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  void setStatus(String code, {String? message}) {
    var text = message ?? '';
    print(text);
  }

  Widget _buildPlayerStateWidget() {
    return StreamBuilder<spState.PlayerState>(
      stream: SpotifySdk.subscribePlayerState() as Stream<spState.PlayerState>?,
      builder:
          (BuildContext context, AsyncSnapshot<spState.PlayerState> snapshot) {
        var track = snapshot.data?.track;
        currentTrackImageUri = track?.imageUri;
        var playerState = snapshot.data;
        if (playerState == null || track == null) {
          return Center(
            child: Container(),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18),
              child: SizedBox(
                  height: 200,
                  child: Center(child: spotifyImageWidget(track.imageUri))),
            ),
          ],
        );
      },
    );
  }

  Widget spotifyImageWidget(ImageUri image) {
    return FutureBuilder(
        future: SpotifySdk.getImage(
          imageUri: image,
          dimension: ImageDimension.large,
        ),
        builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.hasData) {
            return Image.memory(snapshot.data!);
          } else if (snapshot.hasError) {
            setStatus(snapshot.error.toString());
            return SizedBox(
              width: ImageDimension.large.value.toDouble(),
              height: ImageDimension.large.value.toDouble(),
              child: const Center(child: Text('Error getting image')),
            );
          } else {
            return SizedBox(
              width: ImageDimension.large.value.toDouble(),
              height: ImageDimension.large.value.toDouble(),
              child: const Center(child: Text('Getting image...')),
            );
          }
        });
  }

  /// Section Widget
  Widget _buildRowDay(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          left: 35.h,
          right: 40.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "lbl_day".tr,
                      style: CustomTextStyles.bodyMediumGray100,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "lbl_01".tr,
                      style: CustomTextStyles.headlineSmallGray100,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.h),
              child: SizedBox(
                height: 49.v,
                child: VerticalDivider(
                  width: 1.h,
                  thickness: 1.v,
                  color: appTheme.whiteA700.withOpacity(0.2),
                  indent: 4.h,
                  endIndent: 7.h,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.h,
                  bottom: 6.v,
                ),
                child: _buildColumngenesis(
                  context,
                  titleText: "lbl_genesis".tr,
                  chapterText: "lbl_chapter_1".tr,
                ),
              ),
            ),
            Spacer(),
            CustomImageView(
              imagePath: ImageConstant.imgCheckmark,
              height: 28.v,
              width: 29.h,
              margin: EdgeInsets.only(top: 22.v),
            )
          ],
        ),
      ),
    );
  }

  // /// Section Widget
  // Widget _buildColumnAudio(
  //     BuildContext context, StudyDetailsProvider provider) {
  //   return Align(
  //     alignment: Alignment.centerRight,
  //     child: Container(
  //       margin: EdgeInsets.only(left: 23.h, right: 23.h),
  //       padding: EdgeInsets.symmetric(horizontal: 1.h),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             "Audio".tr,
  //             style: theme.textTheme.titleMedium,
  //           ),
  //           SizedBox(height: 8.v),
  //           Container(
  //             decoration: BoxDecoration(
  //               color: Color.fromARGB(255, 198, 229, 249),
  //               borderRadius: BorderRadius.all(
  //                 Radius.circular(0.2 *
  //                     71.h), // 10% curve (0.1 times the width of the container)
  //               ),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(12.0),
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "${provider.respo_day.data?.courseName}",
  //                           style: CustomTextStyles
  //                               .labelLargeManropeBluegray9000313,
  //                         ),
  //                         SizedBox(height: 3.v),
  //                         Text(
  //                           "From  ${provider.respo_day.data?.bibleName}",
  //                           style: CustomTextStyles.bodySmallGray700,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(),
  //                     child: CustomIconButton(
  //                       height: 32.adaptSize,
  //                       width: 32.adaptSize,
  //                       onTap: () {
  //                         provider.playAudio(provider
  //                                 .respo_day.data?.courseContentSpotifyLink ??
  //                             "");
  //                       },
  //                       padding: EdgeInsets.all(7.h),
  //                       decoration: IconButtonStyleHelper.fillGreenA,
  //                       child: CustomImageView(
  //                         imagePath: ImageConstant.imgPlay,
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildColumnRelated(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 23.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.h),
              child: Text(
                "msg_related_articles".tr,
                style: theme.textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 5.v),
            SizedBox(
              height: 106.v,
              child: Consumer<StudyDetailsProvider>(
                builder: (context, provider, child) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 6.h,
                      );
                    },
                    itemCount: provider
                        .studyDetailsModelObj.studyDetailsItemList.length,
                    itemBuilder: (context, index) {
                      StudyDetailsItemModel model = provider
                          .studyDetailsModelObj.studyDetailsItemList[index];
                      return StudyDetailsItemWidget(
                        model,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnAddNote(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 23.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.h),
              child: Text(
                "lbl_add_note".tr,
                style: theme.textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 7.v),
            Padding(
              padding: EdgeInsets.only(right: 24.h),
              child: Selector<StudyDetailsProvider, TextEditingController?>(
                selector: (context, provider) => provider.typehereController,
                builder: (context, typehereController, child) {
                  return CustomTextFormField(
                    controller: typehereController,
                    hintText: "lbl_type_here".tr,
                    textInputAction: TextInputAction.done,
                    maxLines: 4,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowSpacerTwo(
      BuildContext context, StudyDetailsProvider provider) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 72.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 30.adaptSize,
                    width: 30.adaptSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Align(
                        //   alignment: Alignment.center,
                        //   child: IconButton(
                        //     onPressed: () {},
                        //     constraints: BoxConstraints(
                        //       minHeight: 30.adaptSize,
                        //       minWidth: 30.adaptSize,
                        //     ),
                        //     padding: EdgeInsets.all(0),
                        //     icon: SizedBox(
                        //       width: 30.adaptSize,
                        //       height: 30.adaptSize,
                        //       child: CustomImageView(
                        //         imagePath: ImageConstant.imageNotFound,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // CustomImageView(
                        //   imagePath: ImageConstant.imgIconMic,
                        //   height: 20.adaptSize,
                        //   width: 20.adaptSize,
                        //   alignment: Alignment.center,
                        // )
                      ],
                    ),
                  ),
                  // CustomIconButton(
                  //   height: 30.adaptSize,
                  //   width: 30.adaptSize,
                  //   // padding: EdgeInsets.all(7.h),
                  //   child: CustomImageView(
                  //     imagePath: ImageConstant.imgGroup44,
                  //   ),
                  // )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(
                top: 5.v,
                bottom: 4.v,
              ),
              child: Text(
                "lbl_post_note".tr,
                style: CustomTextStyles.titleSmallBluegray500,
              ),
            ),
            GestureDetector(
              onTap: () {
                provider.addNotes();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: CustomIconButton(
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  padding: EdgeInsets.all(7.h),
                  decoration: IconButtonStyleHelper.fillGrayTL15,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgIconSend,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildColumngenesis(
    BuildContext context, {
    required String titleText,
    required String chapterText,
  }) {
    return Column(
      children: [
        Text(
          titleText,
          style: theme.textTheme.titleMedium!.copyWith(
            color: appTheme.blueGray90002,
          ),
        ),
        SizedBox(height: 1.v),
        Text(
          chapterText,
          style: CustomTextStyles.bodyMediumGray60001.copyWith(
            color: appTheme.gray60001,
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildRowEyeOne(
    BuildContext context, {
    required String monthText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.v),
          child: Text(
            monthText,
            style: CustomTextStyles.labelLargeManropeBluegray90003.copyWith(
              color: appTheme.blueGray90003.withOpacity(0.76),
            ),
          ),
        ),
        CustomIconButton(
          height: 20.adaptSize,
          width: 20.adaptSize,
          padding: EdgeInsets.all(6.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgEye,
          ),
        )
      ],
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }
}
