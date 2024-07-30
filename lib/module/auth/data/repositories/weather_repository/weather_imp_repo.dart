import 'package:coopah_task/module/auth/data/models/weather_model.dart';
import 'package:coopah_task/module/auth/data/repositories/weather_repository/weather_repo.dart';
import 'package:flutter/foundation.dart';

import '../../datasources/network/network_datasource/network_datasource.dart';
import '../../datasources/network/url_config.dart';

class WeatherImpRepo implements WeatherRepo {
  WeatherImpRepo(this._networkService);

  final NetworkDataSource _networkService;

  @override
  Future<Weather> getWeather() async {
    try {
      final response = await _networkService.get(
        UrlConfig.weather,
        queryParameters: {
          'lat': 51.51494225418024,
          'lon': -0.12363193061883422,
          'appid': UrlConfig.apiKey,
        },
      );

      return Weather.fromJson(response?.data);
    } catch (e, trace) {
      if (kDebugMode) {
        print(trace);
      }
      rethrow;
    }
  }
}
