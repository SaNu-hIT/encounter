import 'package:encounter_app/presentation/ask_questions_page/my_notes_page.dart';
import 'package:encounter_app/presentation/login_register_screen/register_screen.dart';
import 'package:encounter_app/presentation/profile_screen/edit_profile.dart';
import 'package:encounter_app/presentation/verify_email_screen/verify_email_screen.dart';
import 'package:flutter/material.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/ask_questions_page/ask_questions_form.dart';
import '../presentation/ask_questions_page/ask_questions_page.dart';
import '../presentation/ask_questions_page/got_questions_page.dart';
import '../presentation/bible_page/bible_details_screen.dart';
import '../presentation/home_container_screen/home_container_screen.dart';
import '../presentation/login_register_screen/login_screen.dart';
import '../presentation/onboarding_screen/onboarding_screen.dart';
import '../presentation/profile_screen/profile_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/study_details_screen/cource_full_screen.dart';
import '../presentation/study_details_screen/course_details_screen.dart';
import '../presentation/study_details_screen/study_details_screen.dart';
import '../presentation/study_details_screen/video_player.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String homeContainerScreen = '/home_container_screen';

  static const String onboardScreen = '/on_board_screen';

  static const String homePage = '/home_page';

  static const String verifyEmailScreen = '/verify_email_screen';

  static const String studyDetailsScreen = '/study_details_screen';
  static const String studyDayScreen = '/study_day_screen';

  static const String biblePage = '/bible_page';

  static const String bibleTabContainerScreen = '/bible_tab_container_screen';

  static const String profileScreen = '/profile_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';
  static const String onboardingScreen = '/onboarding_screen';

  static const String loginScreen = '/login_screen';
  static const String registerScreen = '/register_screen';
  static const String got_questions = '/got_questions';
  static const String ask_questions = '/ask_questions';
  static const String ask_question_form = '/ask_question_form';
  static const String bibleDetailScreen = '/bibleDetailScreen';
  static const String courseFullScreen = '/CourseFullScreen';
  static const String videoPlayerScreen = '/VideoPlayerScreen';
  static const String editProfile = '/editProfile';
  static const String my_notes = '/my_notes';

  static Map<String, WidgetBuilder> get routes => {
        splashScreen: SplashScreen.builder,
        videoPlayerScreen: VideoPlayerScreen.builder,
        homeContainerScreen: HomeContainerScreen.builder,
        courseFullScreen: CourseFullScreen.builder,
        studyDetailsScreen: StudyDetailsScreen.builder,
        verifyEmailScreen: VerifyEmailScreen.builder,
        profileScreen: ProfileScreen.builder,
        appNavigationScreen: AppNavigationScreen.builder,
        initialRoute: SplashScreen.builder,
        onboardingScreen: OnboardingScreen.builder,
        loginScreen: LoginScreen.builder,
        registerScreen: RegisterScreen.builder,
        onboardScreen: OnboardingScreen.builder,
        got_questions: GotQuestionsPage.builder,
        ask_questions: AskQuestionsPage.builder,
        ask_question_form: AskQuestionsFormPage.builder,
        studyDayScreen: CouseDetailsScreen.builder,
        editProfile: EditProfileScreen.builder,
        bibleDetailScreen: BibleDetailsScreen.builder,
        my_notes: MyNotesPage.builder
      };
}
