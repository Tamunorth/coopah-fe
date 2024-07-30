import 'package:coopah_task/module/auth/bloc/weather_bloc.dart';
import 'package:coopah_task/module/auth/data/datasources/network/dio_client/dio_client.dart';
import 'package:coopah_task/module/auth/data/datasources/network/network_datasource/network_datasource.dart';
import 'package:coopah_task/module/auth/data/repositories/weather_repository/weather_imp_repo.dart';
import 'package:coopah_task/module/auth/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final WeatherImpRepo _weatherImpRepo =
      WeatherImpRepo(NetworkDataSource(DioClient()));
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _weatherImpRepo,
      child: BlocProvider(
        lazy: false,
        create: (_) => WeatherBloc(_weatherImpRepo)..add(GetWeatherEvent()),
        child: MaterialApp(
          title: 'Coopah FE Task',
          theme: ThemeData(
            //global font family
            fontFamily: 'Circular',
            scaffoldBackgroundColor: Colors.white,
            hintColor: const Color(0xffF6F6F6),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xffFF5700),
              primary: const Color(0xffFF5700),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ).apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
