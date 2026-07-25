class WeatherModel {
  final double temperature;
  final double maxTemperature;
  final double minTemperature;
  final int rainChance;
  final String condition;
  final int weatherCode;

  const WeatherModel({
    required this.temperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.rainChance,
    required this.condition,
    required this.weatherCode,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current_weather'] as Map<String, dynamic>;
    final daily = json['daily'] as Map<String, dynamic>;

    return WeatherModel(
      temperature: (current['temperature'] as num).toDouble(),
      maxTemperature:
          (daily['temperature_2m_max'][0] as num).toDouble(),
      minTemperature:
          (daily['temperature_2m_min'][0] as num).toDouble(),
      rainChance:
          (daily['precipitation_probability_max'][0] as num).toInt(),
      weatherCode:
          (current['weathercode'] as num).toInt(),
      condition: _weatherDescription(
        (current['weathercode'] as num).toInt(),
      ),
    );
  }

  static String _weatherDescription(int code) {
    switch (code) {
      case 0:
        return 'Clear';

      case 1:
        return 'Mainly Clear';

      case 2:
        return 'Partly Cloudy';

      case 3:
        return 'Overcast';

      case 45:
      case 48:
        return 'Fog';

      case 51:
      case 53:
      case 55:
        return 'Drizzle';

      case 56:
      case 57:
        return 'Freezing Drizzle';

      case 61:
      case 63:
      case 65:
        return 'Rain';

      case 66:
      case 67:
        return 'Freezing Rain';

      case 71:
      case 73:
      case 75:
        return 'Snow';

      case 77:
        return 'Snow Grains';

      case 80:
      case 81:
      case 82:
        return 'Rain Showers';

      case 85:
      case 86:
        return 'Snow Showers';

      case 95:
        return 'Thunderstorm';

      case 96:
      case 99:
        return 'Thunderstorm & Hail';

      default:
        return 'Unknown';
    }
  }

  bool get isSunny =>
      weatherCode == 0 ||
      weatherCode == 1;

  bool get isCloudy =>
      weatherCode == 2 ||
      weatherCode == 3;

  bool get isRainy =>
      rainChance >= 60 ||
      condition.contains('Rain') ||
      condition.contains('Drizzle');

  bool get isSnow =>
      condition.contains('Snow');

  bool get isCold =>
      temperature < 8;

  bool get isHot =>
      temperature > 22;

  String get hospitalityInsight {
    if (isSnow) {
      return 'Snow expected. Allow extra time for staff travel and expect fewer walk-ins.';
    }

    if (isRainy) {
      return 'Wet conditions expected. Anticipate stronger food trade and reduced outdoor seating.';
    }

    if (isHot) {
      return 'Warm weather expected. Increase cold drinks stock and prepare outdoor seating.';
    }

    if (isSunny) {
      return 'Good weather expected. Beer garden and drinks sales are likely to increase.';
    }

    return 'Typical trading conditions expected today.';
  }
}