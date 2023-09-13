import 'package:devera_news_application/page/login/login_page.dart';
import 'package:flutter/material.dart';

import 'splash_widget/ripples_animation.dart';


class SplashPage extends StatefulWidget {
  static const routeName = "/splash-page";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, LoginPage.routeName);
            },
            child: RippleAnimation(),
          ),
        ],
      ),
    );
  }
}
