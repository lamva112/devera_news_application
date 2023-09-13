import 'package:devera_news_application/page/explore/explore_page.dart';
import 'package:devera_news_application/page/weather/weather_screen.dart';
import 'package:devera_news_application/provider/news_provider.dart';
import 'package:devera_news_application/provider/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../Utility/current_permission.dart';
import '../book_mark/bookmarks_page.dart';
import '../home_tab/home_tab_page.dart';
import '../settings/setting_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home-page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  late Position _currentPosition;
  final bottomBarIcons = [IconlyLight.home, IconlyLight.discovery, Icons.sunny_snowing, IconlyLight.setting];

  List<String> bottomBarTitles = ["Home", "Trending", "Weather", "Setting"];

  List<Widget> tabScreens = [];

  @override
  void didChangeDependencies() {
    tabScreens.addAll([
      const HomeTabPage(),
      const ExplorePage(),
      const WeatherPage(),
      const SettingsScreen(),
    ]);
    //_getCurrentPosition();
    super.didChangeDependencies();
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position? position) {
          print("lat:${position?.latitude}");
          print("long:${position?.longitude}");
          if(position != null){
            context.read<WeatherProvider>().updatePosition(position);
            context.read<WeatherProvider>().getCurrentWeatherResponse(position);
          }
    }).catchError((e) {
      debugPrint(e);
    });
  }





  @override
  void initState() {
    _getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: tabScreens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index != currentIndex) {
            setState(() {
              currentIndex = index;
            });
          }
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.lightBlue,
        selectedLabelStyle: Theme.of(context).textTheme.caption?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.lightBlue,
            ),
        unselectedLabelStyle: Theme.of(context).textTheme.caption?.copyWith(
              fontWeight: FontWeight.w500,
            ),
        //unselectedItemColor: Colors.grey,
        items: List.generate(
          bottomBarIcons.length,
          (index) => BottomNavigationBarItem(
              icon: Icon(bottomBarIcons[index]),
              label: bottomBarTitles[index],
              activeIcon: Icon(
                bottomBarIcons[index],
                color: Colors.lightBlue,
              )),
        ),
      ),
    );
  }
}
