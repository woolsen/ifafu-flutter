import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ifafu/page/about_page.dart';
import 'package:ifafu/page/edit_profile_page.dart';
import 'package:ifafu/page/feedback_page.dart';
import 'package:ifafu/page/login_page.dart';
import 'package:ifafu/page/main_page.dart';
import 'package:ifafu/page/major_timetable_select_page.dart';
import 'package:ifafu/page/post_create_page.dart';
import 'package:ifafu/page/post_detail_page.dart';
import 'package:ifafu/page/post_my_page.dart';
import 'package:ifafu/page/qa_page.dart';
import 'package:ifafu/page/score.dart';
import 'package:ifafu/page/setting_page.dart';
import 'package:ifafu/page/timetable_page.dart';
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/util/sp.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPUtil.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const ClassicHeader(),
      headerTriggerDistance: 80.0,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserProvider()),
        ],
        child: MaterialApp(
          title: 'iFAFU',
          localizationsDelegates: const [
            RefreshLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale("zh", "CH"),
          supportedLocales: const [Locale("zh", "CH")],
          routes: {
            '/': (context) => const MainPage(),
            '/login': (context) => const LoginPage(),
            '/about': (context) => const AboutPage(),
            '/post/my': (context) => const PostMyPage(),
            '/post/create': (context) => const PostCreatePage(),
            '/post/detail': (context) => const PostDetailPage(),
            '/profile/edit': (context) => const EditProfilePage(),
            '/feedback': (context) => const FeedbackPage(),
            '/qa': (context) => const QaPage(),
            '/setting': (context) => const SettingPage(),
            '/timetable': (context) => const TimetablePage(),
            '/timetable/major/select': (context) =>
                const MajorTimetableSelectPage(),
            '/score': (context) => const ScorePage(),
          },
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            physics: const BouncingScrollPhysics(),
          ),
          theme: ThemeData(
            dividerTheme: const DividerThemeData(
              thickness: 0.8,
              space: 0.8,
              color: Color(0xFFE5E5E5),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1A80FE),
              background: Colors.white,
            ),
            useMaterial3: true,
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: 'DingTalk',
              ),
            ),
            listTileTheme: const ListTileThemeData(
              tileColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ),
    );
  }
}
