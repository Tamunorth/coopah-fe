import '../../models/weather_model.dart';

abstract class WeatherRepo {
  Future<Weather> getWeather();
}
