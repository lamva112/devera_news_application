import 'package:devera_news_application/page/explore/explore_page.dart';
import 'package:devera_news_application/page/login/login_page.dart';
import 'package:devera_news_application/provider/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'page/blog_detail/blog_detail_page.dart';
import 'page/book_mark/bookmarks_page.dart';
import 'page/book_mark_detail/book_mark_detail.dart';
import 'page/theme/dark_mode_page.dart';
import 'page/home/home_page.dart';
import 'page/home_tab/home_tab_page.dart';
import 'page/splash/splash_page.dart';
import 'provider/bookmarks_provider.dart';
import 'provider/news_provider.dart';
import 'provider/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Need it to access the theme Provider
  ThemeProvider themeChangeProvider = ThemeProvider();


  @override
  void didChangeDependencies() {
    getCurrentAppTheme();
    super.didChangeDependencies();
  }

  //Fetch the current theme
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          //Notify about theme changes
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookmarksProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(),
        ),
      ],
      child:
          //Notify about theme changes
          Consumer<ThemeProvider>(builder: (context, themeChangeProvider, ch) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News app',
          theme: Styles.themeData(themeChangeProvider.getDarkTheme, context),
          home: const SplashPage(),
          routes: {
            //NewsDetailsScreen.routeName: (ctx) => const NewsDetailsScreen(),
            NewsDetailsPage.routeName: (ctx) => const NewsDetailsPage(),
            HomeTabPage.routeName: (context)=> const HomeTabPage(),
            ExplorePage.routeName: (context)=> const ExplorePage(),
            BookmarkPage.routeName: (context)=> const BookmarkPage(),
            DarkModePage.routeName: (context) => const DarkModePage(),
            SplashPage.routeName: (context) => const SplashPage(),
            HomePage.routeName: (context) => const HomePage(),
            LoginPage.routeName: (context) => const LoginPage(),
            BookmarkDetailPage.routeName: (context) => const BookmarkDetailPage(),
          },
        );
      }),
    );
  }
}


