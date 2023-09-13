import 'package:devera_news_application/page/weather/weather_card.dart';
import 'package:devera_news_application/provider/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../models/weather/current_weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
        //future: Provider.of<WeatherProvider>(context).fetchWeatherResponse(),
        builder: (context, weatherProvider, _) {
      int sunset = weatherProvider.getWeatherResponse?.sys?.sunset ?? 0;
      int sunrise = weatherProvider.getWeatherResponse?.sys?.sunrise ?? 0;
      var response = weatherProvider.getWeatherResponse;
      return SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Text(response?.name ?? "Ho Chi Minh", style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 52)),
          ),
          LottieBuilder.asset(
            getWeatherIcon(response?.weather?[0].description ?? '', sunrise, sunset),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 5),
            child: Text('${response?.main?.temp?.round()}°C', style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 58)),
          ),
          Center(
              child: Text('${response?.weather?[0].description}',
                  style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 44), textAlign: TextAlign.center)),
          const SizedBox(height: 22),
          Row(children: [
            Expanded(
              child: Card(
                margin: const EdgeInsets.all(8),
                shape: CardTheme.of(context).shape,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Humidity', style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 8),
                      Text('${response?.main?.humidity}%', style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                margin: const EdgeInsets.all(8),
                shape: CardTheme.of(context).shape,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Pressure', style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 8),
                      Text('${response?.main?.pressure?.round()} hPa',
                          style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            )
          ]),
          Row(children: [
            WeatherCard(
              title: 'Feels like',
              label: '${response?.main?.feelsLike?.round()}°C',
            ),
            const WeatherCard(
              title: 'AQI',
              label: '25',
            ),
          ]),
          Row(
            children: [
              WeatherCard(
                title: 'Winds (${response?.wind?.deg})',
                label: '${response?.wind?.speed?.round()} km/h',
              ),
              WeatherCard(
                title: 'Cloudiness',
                label: '${response?.clouds?.all?.round()}%',
              ),
            ],
          ),
          Row(
            children: [
              WeatherCard(
                title: 'Sunrise',
                label: DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(sunrise * 1000)),
              ),
              WeatherCard(
                title: 'Sunset',
                label: DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(sunset * 1000)),
              ),
            ],
          )
        ]),
      );
    });
  }

  // Widget getWeatherIcon(String description) {
  //   DateTime now = DateTime.now();
  //   bool isDaytime =
  //       now.isAfter(DateTime.fromMillisecondsSinceEpoch(sunrise! * 1000)) && now.isBefore(DateTime.fromMillisecondsSinceEpoch(sunset! * 1000));
  //
  //   if (description.contains('Heavy Intensity Rain')) {
  //     return const BoxedIcon(WeatherIcons.rain_wind, size: 127);
  //   } else if (description.contains('Moderate Rain')) {
  //     return const BoxedIcon(WeatherIcons.rain, size: 127);
  //   } else if (description.contains('Light Rain') || description.contains('Drizzle') || description.contains('Showers')) {
  //     return const BoxedIcon(WeatherIcons.showers, size: 127);
  //   } else if (description.contains('Cloud') || description.contains('overcast Clouds') || description.contains('Scattered Clouds')) {
  //     return BoxedIcon(isDaytime ? WeatherIcons.day_cloudy : WeatherIcons.night_alt_cloudy, size: 127);
  //   } else if (description.contains('Wind')) {
  //     return const BoxedIcon(WeatherIcons.strong_wind, size: 127);
  //   } else if (description.contains('Snow')) {
  //     return const BoxedIcon(WeatherIcons.snow, size: 127);
  //   } else if (description.contains('Haze')) {
  //     return BoxedIcon(isDaytime ? WeatherIcons.day_haze : WeatherIcons.night_fog, size: 127);
  //   } else if (description.contains('Thunderstorm')) {
  //     return const BoxedIcon(WeatherIcons.thunderstorm, size: 127);
  //   } else if (description.contains('Drizzle')) {
  //     return const BoxedIcon(WeatherIcons.sprinkle, size: 127);
  //   } else if (description.contains('Fog')) {
  //     return BoxedIcon(isDaytime ? WeatherIcons.day_fog : WeatherIcons.night_fog, size: 127);
  //   } else if (description.contains('Mist')) {
  //     return BoxedIcon(isDaytime ? WeatherIcons.day_fog : WeatherIcons.night_fog, size: 127);
  //   } else if (description.contains('Smoke')) {
  //     return const BoxedIcon(WeatherIcons.smoke, size: 127);
  //   } else if (description.contains('Dust')) {
  //     return const BoxedIcon(WeatherIcons.dust, size: 127);
  //   } else if (description.contains('Sand')) {
  //     return const BoxedIcon(WeatherIcons.sandstorm, size: 127);
  //   } else if (description.contains('Ash')) {
  //     return const BoxedIcon(WeatherIcons.volcano, size: 127);
  //   } else if (description.contains('Squall')) {
  //     return const BoxedIcon(WeatherIcons.strong_wind, size: 127);
  //   } else if (description.contains('Tornado')) {
  //     return const BoxedIcon(WeatherIcons.tornado, size: 127);
  //   } else if (description.contains('Clear Sky') || description.contains('Sun')) {
  //     // changed from 'sun' to 'clear sky'
  //     return BoxedIcon(isDaytime ? WeatherIcons.day_sunny : WeatherIcons.night_clear, size: 127);
  //   } else {
  //     return BoxedIcon(isDaytime ? WeatherIcons.day_sunny_overcast : WeatherIcons.night_alt_partly_cloudy, size: 127);
  //   }
  // }

  String getWeatherIcon(String description, int sunrise, int sunset) {
    DateTime now = DateTime.now();
    bool isDaytime =
        now.isAfter(DateTime.fromMillisecondsSinceEpoch(sunrise * 1000)) && now.isBefore(DateTime.fromMillisecondsSinceEpoch(sunset * 1000));

    if (description.contains('heavy intensity rain')) {
      //return const BoxedIcon(WeatherIcons.rain_wind, size: 127);
      return isDaytime ? "assets/icon/4801-weather-partly-shower.json" : "assets/icon/4797-weather-rainynight.json";
    } else if (description.contains('moderate rain')) {
      return isDaytime ? "assets/icon/4801-weather-partly-shower.json" : "assets/icon/4797-weather-rainynight.json";
    } else if (description.contains('light rain') || description.contains('Drizzle') || description.contains('Showers')) {
      return isDaytime ? "assets/icon/4801-weather-partly-shower.json" : "assets/icon/4797-weather-rainynight.json";
    } else if (description.contains('cloud') || description.contains('overcast Clouds') || description.contains('Scattered Clouds')) {
      return isDaytime ? "assets/icon/4800-weather-partly-cloudy.json" : "assets/icon/4796-weather-cloudynight.json";
    } else if (description.contains('wind')) {
      return "assets/icon/4806-weather-windy.json";
    } else if (description.contains('snow')) {
      return isDaytime ? "assets/icon/4802-weather-snow-sunny.json" : "assets/icon/4798-weather-snownight.json";
    } else if (description.contains('haze')) {
      return "assets/icon/4795-weather-mist.json";
    } else if (description.contains('thunderstorm')) {
      return "assets/icon/4805-weather-thunder.json";
    } else if (description.contains('drizzle')) {
      return isDaytime ? "assets/icon/4801-weather-partly-shower.json" : "assets/icon/4797-weather-rainynight.json";
    } else if (description.contains('fog')) {
      return "assets/icon/4795-weather-mist.json";
    } else if (description.contains('mist')) {
      return "assets/icon/4795-weather-mist.json";
    } else if (description.contains('tornado')) {
      return isDaytime ? "assets/icon/4792-weather-stormshowersday.json" : "assets/icon/4803-weather-storm.json";
    } else if (description.contains('clear sky') || description.contains('Sun')) {
      // changed from 'sun' to 'clear sky'
      return isDaytime ? "assets/icon/4804-weather-sunny.json" : "assets/icon/4799-weather-night.json";
    } else {
      return isDaytime ? "assets/icon/4804-weather-sunny.json" : "assets/icon/4799-weather-night.json";
      ;
    }
  }
}
