import 'package:bloc_test/bloc_test.dart';
import 'package:coopah_task/module/auth/bloc/weather_bloc.dart';
import 'package:coopah_task/module/auth/data/models/weather_model.dart';
import 'package:coopah_task/module/auth/data/repositories/weather_repository/weather_imp_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherImpRepo extends Mock implements WeatherImpRepo {}

void main() {
  late MockWeatherImpRepo mockWeatherImpRepo;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockWeatherImpRepo = MockWeatherImpRepo();
    weatherBloc = WeatherBloc(mockWeatherImpRepo);
  });

  tearDown(() {
    weatherBloc.close();
  });

  group('WeatherBloc Tests', () {
    final mockWeatherData = Weather(
      temp: 32,
      location: "London",
    );

    test('initial state is WeatherInitial', () {
      expect(weatherBloc.state, isA<WeatherInitial>());
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherSuccess] when GetWeatherEvent is added and weather data is fetched successfully',
      build: () {
        when(() => mockWeatherImpRepo.getWeather())
            .thenAnswer((_) async => mockWeatherData);
        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherEvent()),
      expect: () => [isA<WeatherLoading>(), isA<WeatherSuccess>()],
    );

    // Test for the error case
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherError] when GetWeatherEvent is added and an error occurs',
      build: () {
        when(() => mockWeatherImpRepo.getWeather())
            .thenThrow(Exception('Failed to fetch weather data'));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherEvent()),
      expect: () => [isA<WeatherLoading>(), isA<WeatherError>()],
    );
  });
}
