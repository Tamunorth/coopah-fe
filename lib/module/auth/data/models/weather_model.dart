class Weather {
  Weather({
    this.temp,
    this.location,
    this.tempFarenhiet,
    this.tempCelsius,
  });

  Weather.fromJson(dynamic json) {
    if (json['main'] != null) {
      temp = json['main']['temp'];
      if (temp != null) {
        tempCelsius = _kelvinToCelsius(temp!);
        tempFarenhiet = _kelvinToFahrenheit(temp!);
      }
    }
    location = json['name'];
  }

  num? temp;
  String? location;
  num? tempFarenhiet;
  num? tempCelsius;

  Weather copyWith({
    num? temp,
    String? location,
  }) =>
      Weather(
        temp: temp ?? this.temp,
        location: location ?? this.location,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['temp'] = temp;
    map['location'] = location;
    return map;
  }
}

// Convert Kelvin to Celsius
num _kelvinToCelsius(num kelvin) {
  return kelvin - 273.15;
}

// Convert Kelvin to Fahrenheit
num _kelvinToFahrenheit(num kelvin) {
  return (kelvin - 273.15) * 9 / 5 + 32;
}
