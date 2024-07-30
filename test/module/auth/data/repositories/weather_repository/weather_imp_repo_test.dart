import 'package:coopah_task/module/auth/data/datasources/network/network_datasource/network_datasource.dart';
import 'package:coopah_task/module/auth/data/datasources/network/url_config.dart';
import 'package:coopah_task/module/auth/data/models/weather_model.dart';
import 'package:coopah_task/module/auth/data/repositories/weather_repository/weather_imp_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// mock class for NetworkDataSource
class MockNetworkDataSource extends Mock implements NetworkDataSource {}

//utility function to create mock Dio responses
Response<dynamic> mockResponse(Map<String, dynamic> data) {
  return Response<dynamic>(
    data: data,
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );
}

void main() {
  late MockNetworkDataSource mockNetworkDataSource;
  late WeatherImpRepo weatherImpRepo;

  setUp(() {
    mockNetworkDataSource = MockNetworkDataSource();
    weatherImpRepo = WeatherImpRepo(mockNetworkDataSource);
  });

  group('WeatherImpRepo', () {
    test('returns Weather model when getWeather is successful', () async {
      // Openweather sample response`
      final sampleWeatherData = {
        "coord": {"lon": 10.99, "lat": 44.34},
        "weather": [
          {
            "id": 501,
            "main": "Rain",
            "description": "moderate rain",
            "icon": "10d"
          }
        ],
        "base": "stations",
        "main": {
          "temp": 298.48,
          "feels_like": 298.74,
          "temp_min": 297.56,
          "temp_max": 300.05,
          "pressure": 1015,
          "humidity": 64,
          "sea_level": 1015,
          "grnd_level": 933
        },
        "visibility": 10000,
        "wind": {"speed": 0.62, "deg": 349, "gust": 1.18},
        "rain": {"1h": 3.16},
        "clouds": {"all": 100},
        "dt": 1661870592,
        "sys": {
          "type": 2,
          "id": 2075663,
          "country": "IT",
          "sunrise": 1661834187,
          "sunset": 1661882248
        },
        "timezone": 7200,
        "id": 3163858,
        "name": "Zocca",
        "cod": 200
      };

      when(() => mockNetworkDataSource.get(
            UrlConfig.weather,
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => mockResponse(sampleWeatherData));

      final weather = await weatherImpRepo.getWeather();

      expect(weather, isA<Weather>());
      expect(weather.temp, equals(298.48));
      expect(weather.location, equals("Zocca"));
    });

    test('throws an exception when getWeather fails', () async {
      when(() => mockNetworkDataSource.get(
            UrlConfig.weather,
            queryParameters: any(named: 'queryParameters'),
          )).thenThrow(Exception('Network error'));

      expect(() async => await weatherImpRepo.getWeather(), throwsException);
    });
  });
}
