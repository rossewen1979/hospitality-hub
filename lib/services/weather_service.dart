import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {
  const WeatherService();

  static const double latitude = 57.4778;
  static const double longitude = -4.2247;

  Future<WeatherModel> getWeather() async {
    final uri = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&current_weather=true'
      '&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max'
      '&timezone=auto',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Weather API returned ${response.statusCode}',
      );
    }

    debugPrint(response.body);

    final Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;

    return WeatherModel.fromJson(json);
  }
}