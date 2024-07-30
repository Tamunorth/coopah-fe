part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

final class GetWeatherEvent extends WeatherEvent {}
