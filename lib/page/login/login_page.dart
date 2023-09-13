import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';
import '../home/home_page.dart';
import 'widget/land.dart';
import 'widget/rounded_text_field.dart';
import 'widget/size_config.dart';
import 'widget/sun.dart';
import 'widget/tabs.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login-page";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isFullSun = false;

  //bool isDayMood = true;
  Duration _duration = Duration(seconds: 1);
  int index = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isFullSun = true;
      });
    });
  }

  // void changeMood(int activeTabNum) {
  //   if (activeTabNum == 0) {
  //     setState(() {
  //       isDayMood = true;
  //     });
  //     Future.delayed(Duration(milliseconds: 300), () {
  //       setState(() {
  //         isFullSun = true;
  //       });
  //     });
  //   } else {
  //     setState(() {
  //       isFullSun = false;
  //     });
  //     Future.delayed(Duration(milliseconds: 300), () {
  //       setState(() {
  //         isDayMood = false;
  //       });
  //     });
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var currentTheme = themeProvider.getDarkTheme;
    List<Color> lightBgColors = [
      Color(0xFF8C2480),
      Color(0xFFCE587D),
      Color(0xFFFF9485),
      if (isFullSun) Color(0xFFFF9D80),
    ];
    var darkBgColors = [
      Color(0xFF0D1441),
      Color(0xFF283584),
      Color(0xFF376AB2),
    ];
    SizeConfig.init(context);
    return Scaffold(
      body: AnimatedContainer(
        duration: _duration,
        curve: Curves.easeInOut,
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: themeProvider.getDarkTheme ?  darkBgColors:lightBgColors ,
          ),
        ),
        child: Stack(
          children: [
            Sun(duration: _duration, isFullSun: isFullSun),
            const Land(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpacing(of: 50),
                    IconButton(
                      onPressed: () {
                        if (themeProvider.getDarkTheme) {
                          setState(() {
                            isFullSun = true;
                          });
                          Future.delayed(const Duration(milliseconds: 200), () {
                            //setState(() {
                            themeProvider.setDarkTheme = false;
                            //});
                          });
                        } else {
                          //setState(() {
                          themeProvider.setDarkTheme = true;
                          //});
                          Future.delayed(const Duration(milliseconds: 200), () {
                            setState(() {
                              isFullSun = false;
                            });
                          });
                        }
                      },
                      icon: Icon(themeProvider.getDarkTheme ?  Icons.dark_mode_rounded : Icons.light_mode_rounded),
                    ),
                    Text(
                      "Good Morning",
                      style: Theme.of(context).textTheme.headline3?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const VerticalSpacing(of: 10),
                    const Text(
                      "Enter your Informations below",
                      style: TextStyle(color: Colors.white),
                    ),
                    const VerticalSpacing(of: 50),
                    const RoundedTextField(
                      initialValue: "ourdemo@email.com",
                      hintText: "Email",
                    ),
                    const VerticalSpacing(),
                    const RoundedTextField(
                      initialValue: "XXXXXXX",
                      hintText: "Password",
                    ),
                    const SizedBox(height: 16,),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, HomePage.routeName);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
