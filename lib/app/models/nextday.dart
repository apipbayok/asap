// To parse this JSON data, do
//
//     final nextday = nextdayFromJson(jsonString);

import 'dart:convert';

Nextday nextdayFromJson(String str) => Nextday.fromJson(json.decode(str));

String nextdayToJson(Nextday data) => json.encode(data.toJson());

class Nextday {
  Forecast forecast;

  Nextday({
    required this.forecast,
  });

  factory Nextday.fromJson(Map<String, dynamic> json) => Nextday(
        forecast: Forecast.fromJson(json["forecast"]),
      );

  Map<String, dynamic> toJson() => {
        "forecast": forecast.toJson(),
      };
}

class Forecast {
  List<Forecastday> forecastday;

  Forecast({
    required this.forecastday,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        forecastday: List<Forecastday>.from(
            json["forecastday"].map((x) => Forecastday.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "forecastday": List<dynamic>.from(forecastday.map((x) => x.toJson())),
      };
}

class Forecastday {
  DateTime date;

  Day day;
  List<Hour> hour;

  Forecastday({
    required this.date,
    required this.day,
    required this.hour,
  });

  factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
        date: DateTime.parse(json["date"]),
        day: Day.fromJson(json["day"]),
        hour: List<Hour>.from(json["hour"].map((x) => Hour.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "day": day.toJson(),
        "hour": List<dynamic>.from(hour.map((x) => x.toJson())),
      };
}

class Day {
  String maxtempC;
  String maxtempF;
  String mintempC;
  String mintempF;
  String avgtempC;
  String avgtempF;
  String maxwindMph;
  String maxwindKph;
  Condition condition;

  Day({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.maxwindMph,
    required this.maxwindKph,
    required this.condition,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        maxtempC: json["maxtemp_c"].toString(),
        maxtempF: json["maxtemp_f"].toString(),
        mintempC: json["mintemp_c"].toString(),
        mintempF: json["mintemp_f"].toString(),
        avgtempC: json["avgtemp_c"].toString(),
        avgtempF: json["avgtemp_f"].toString(),
        maxwindMph: json["maxwind_mph"].toString(),
        maxwindKph: json["maxwind_kph"].toString(),
        condition: Condition.fromJson(json["condition"]),
      );

  Map<String, dynamic> toJson() => {
        "maxtemp_c": maxtempC,
        "maxtemp_f": maxtempF,
        "mintemp_c": mintempC,
        "mintemp_f": mintempF,
        "avgtemp_c": avgtempC,
        "avgtemp_f": avgtempF,
        "maxwind_mph": maxwindMph,
        "maxwind_kph": maxwindKph,
        "condition": condition.toJson(),
      };
}

class Condition {
  String text;
  String icon;
  int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "icon": icon,
        "code": code,
      };
}

class Hour {
  String time;
  String tempC;
  String tempF;
  Condition condition;
  String windKph;
  String windMph;
  String windDir;
  String humidity;
  String cloud;

  Hour({
    required this.time,
    required this.tempC,
    required this.tempF,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDir,
    required this.humidity,
    required this.cloud,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        time: json["time"],
        tempC: json["temp_c"].toString(),
        tempF: json["temp_f"].toString(),
        condition: Condition.fromJson(json["condition"]),
        windMph: json["wind_mph"].toString(),
        windKph: json["wind_kph"].toString(),
        windDir: json["wind_dir"].toString(),
        humidity: json["humidity"].toString(),
        cloud: json["cloud"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "temp_c": tempC,
        "temp_f": tempF,
        "condition": condition.toJson(),
        "wind_mph": windMph,
        "wind_kph": windKph,
        "wind_dir": windDir,
        "humidity": humidity,
        "cloud": cloud,
      };
}
