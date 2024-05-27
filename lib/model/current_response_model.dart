class CurrentWeatherModel {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Rain? rain;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  CurrentWeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      weather: json['weather'] != null
          ? List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x)))
          : null,
      base: json['base'],
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      visibility: json['visibility'],
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
      dt: json['dt'],
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coord': coord?.toJson(),
      'weather': weather != null
          ? List<dynamic>.from(weather!.map((x) => x.toJson()))
          : null,
      'base': base,
      'main': main?.toJson(),
      'visibility': visibility,
      'wind': wind?.toJson(),
      'rain': rain?.toJson(),
      'clouds': clouds?.toJson(),
      'dt': dt,
      'sys': sys?.toJson(),
      'timezone': timezone,
      'id': id,
      'name': name,
      'cod': cod,
    };
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'],
      lat: json['lat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lon': lon,
      'lat': lat,
    };
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'humidity': humidity,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
    };
  }
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({this.speed, this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'],
      deg: json['deg'],
      gust: json['gust'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }
}

class Rain {
  double? oneHour;

  Rain({this.oneHour});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(oneHour: json['1h']);
  }

  Map<String, dynamic> toJson() {
    return {'1h': oneHour};
  }
}

class Clouds {
  int? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all']);
  }

  Map<String, dynamic> toJson() {
    return {'all': all};
  }
}

class Sys {
  String? country;
  int? sunrise;
  int? sunset;

  Sys({this.country, this.sunrise, this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}
