import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/page/edit_profile_page.dart';
import 'package:ifafu/page/login_page.dart';
import 'package:ifafu/page/main_page.dart';
import 'package:ifafu/page/my_post_page.dart';
import 'package:ifafu/page/post_detail_page.dart';
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/util/sp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPUtil.instance.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'iFAFU',
        routes: {
          '/': (context) => const MainPage(),
          '/login': (context) => const LoginPage(),
          '/user/posts': (context) => const MyPostPage(),
          '/post/detail': (context) => const PostDetailPage(),
          '/profile/edit': (context) => const EditProfilePage(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF5F5F5),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontFamily: 'DingTalk',
            ),
          ),
        ),
      ),
    );
  }
}
