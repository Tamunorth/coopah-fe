import 'package:coopah_task/module/auth/bloc/weather_bloc.dart';
import 'package:coopah_task/module/auth/presentation/widgets/weather_detial_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<bool> isFahrenheit = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width;
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          body: (state is WeatherError)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.message}',
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        AspectRatio(
                          aspectRatio: size > 300 ? 16 / 9 : 4 / 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).hintColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:
                                Image.asset('assets/images/weather_icon.png'),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                            child: Text(
                          'THIS IS MY WEATHER APP',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Futura'),
                        )),
                        const SizedBox(height: 24),
                        ValueListenableBuilder(
                            valueListenable: isFahrenheit,
                            builder: (context, isFahrenheitValue, _) {
                              return WeatherDetailItem(
                                title: 'Temperature',
                                value: (state is WeatherSuccess)
                                    ? '${isFahrenheitValue ? state.weather.tempFarenhiet?.toStringAsFixed(2) : state.weather.tempCelsius?.toStringAsFixed(2)} degrees'
                                    : 'temp_value',
                              );
                            }),
                        WeatherDetailItem(
                          title: 'Location',
                          value: (state is WeatherSuccess)
                              ? '${state.weather.location}'
                              : 'temp_value',
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Celsius/Fahrenheit',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 16),
                            ValueListenableBuilder(
                                valueListenable: isFahrenheit,
                                builder: (context, isFahrenheitValue, _) {
                                  return Switch.adaptive(
                                    value: isFahrenheit.value,
                                    onChanged: (value) {
                                      isFahrenheit.value = !isFahrenheit.value;
                                    },
                                  );
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SafeArea(
              child: SizedBox(
                width: size > 500 ? 400 : double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    context.read<WeatherBloc>().add(GetWeatherEvent());
                  },
                  child: Text(
                    'Refresh',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
