import 'package:bloc/bloc.dart';
import 'package:coopah_task/module/auth/data/repositories/weather_repository/weather_imp_repo.dart';
import 'package:meta/meta.dart';

import '../data/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._weatherImpRepo) : super(WeatherInitial()) {
    on<GetWeatherEvent>(_onGetWeatherCalled);
  }

  final WeatherImpRepo _weatherImpRepo;

  Future<void> _onGetWeatherCalled(
    GetWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(WeatherLoading());
      final result = await _weatherImpRepo.getWeather();

      emit(WeatherSuccess(result));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
