import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import 'size_config.dart';

class Sun extends StatelessWidget {
  final Duration duration;
  final bool isFullSun;
  const Sun({super.key, required this.duration, required this.isFullSun});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      curve: Curves.easeInOut,
      left: getProportionateScreenWidth(55),
      bottom: getProportionateScreenWidth(isFullSun ? 25 : -55),
      child: LottieBuilder.asset("assets/icon/4804-weather-sunny.json"
          ,fit: BoxFit.cover,
      ),
    //   child: SvgPicture.asset("assets/icon/Sun.svg"),
    // );
    );
  }
}