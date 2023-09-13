import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather/current_weather_model.dart';
import '../services/weather_api.dart';

class WeatherProvider with ChangeNotifier {
  Position? _currentPosition;
  CurrentWeather? _weatherResponse;

  Position? get getCurrentPosition => _currentPosition;

  CurrentWeather? get getWeatherResponse {
    return _weatherResponse;
  }

  void updatePosition(Position position) {
    _currentPosition = position;
  }

  Future<CurrentWeather?> fetchWeatherResponse() async {
     _weatherResponse = await WeatherAPiServices.getWeatherResponse(_currentPosition);
    return _weatherResponse;
  }

  Future<void> getCurrentWeatherResponse(Position position) async {
    _weatherResponse = await WeatherAPiServices.getWeatherResponse(_currentPosition);
    notifyListeners();
  }

}
