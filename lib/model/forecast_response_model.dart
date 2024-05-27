class ForecastWeatherResponse {
  String cod;
  int message;
  int cnt;
  List<WeatherData> list;
  City city;

  ForecastWeatherResponse({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory ForecastWeatherResponse.fromJson(Map<String, dynamic> json) {
    var listFromJson = json['list'] as List;
    List<WeatherData> weatherList =
        listFromJson.map((i) => WeatherData.fromJson(i)).toList();

    return ForecastWeatherResponse(
      cod: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      list: weatherList,
      city: City.fromJson(json['city']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': list.map((v) => v.toJson()).toList(),
      'city': city.toJson(),
    };
  }
}

class WeatherData {
  int dt;
  MainWeather main;
  List<WeatherDescription> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;
  Rain? rain;
  Sys sys;
  String dtTxt;

  WeatherData({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.rain,
    required this.sys,
    required this.dtTxt,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    var weatherFromJson = json['weather'] as List;
    List<WeatherDescription> weatherList =
        weatherFromJson.map((i) => WeatherDescription.fromJson(i)).toList();

    return WeatherData(
      dt: json['dt'],
      main: MainWeather.fromJson(json['main']),
      weather: weatherList,
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: json['pop'].toDouble(),
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      sys: Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'main': main.toJson(),
      'weather': weather.map((v) => v.toJson()).toList(),
      'clouds': clouds.toJson(),
      'wind': wind.toJson(),
      'visibility': visibility,
      'pop': pop,
      'rain': rain?.toJson(),
      'sys': sys.toJson(),
      'dt_txt': dtTxt,
    };
  }
}

class MainWeather {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  MainWeather({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory MainWeather.fromJson(Map<String, dynamic> json) {
    return MainWeather(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: json['temp_kf'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
      'humidity': humidity,
      'temp_kf': tempKf,
    };
  }
}

class WeatherDescription {
  int id;
  String main;
  String description;
  String icon;

  WeatherDescription({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherDescription.fromJson(Map<String, dynamic> json) {
    return WeatherDescription(
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

class Clouds {
  int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all': all,
    };
  }
}

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
      gust: json['gust'].toDouble(),
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
  double? threeH;

  Rain({this.threeH});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      threeH: json['3h'] != null ? json['3h'].toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '3h': threeH,
    };
  }
}

class Sys {
  String pod;

  Sys({required this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: json['pod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pod': pod,
    };
  }
}

class City {
  int id;
  String name;
  Coord coord;
  String country;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: Coord.fromJson(json['coord']),
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coord': coord.toJson(),
      'country': country,
      'population': population,
      'timezone': timezone,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}

class Coord {
  double lat;
  double lon;

  Coord({required this.lat, required this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}
