import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../consts/api_consts.dart';
import '../models/weather/current_weather_model.dart';


class WeatherAPiServices {
  static Future<CurrentWeather?> getWeatherResponse(Position? position) async {
    try {
      var response = await http.get(
        Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?lat=${position?.latitude}&lon=${position?.longitude}&appid=$WEATHER_API&units=metric',
        ),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        return CurrentWeather.fromJson(data);
      } else {
        print('Error: ${response.statusCode}');
        // Handle the error condition here, e.g., throw an exception or return null
        return null;
      }
    } catch (error) {
      throw error.toString();
    }
  }

}