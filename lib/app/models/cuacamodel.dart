// To parse this JSON data, do
//
//     final cuacamodel = cuacamodelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Cuacamodel cuacamodelFromJson(String str) => Cuacamodel.fromJson(json.decode(str));

String cuacamodelToJson(Cuacamodel data) => json.encode(data.toJson());

class Cuacamodel {
  Location location;
  Current current;

  Cuacamodel({
    required this.location,
    required this.current,
  });

  factory Cuacamodel.fromJson(Map<String, dynamic> json) => Cuacamodel(
    location: Location.fromJson(json["location"]),
    current: Current.fromJson(json["current"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "current": current.toJson(),
  };
}

class Current {
  int lastUpdatedEpoch;
  String lastUpdated;
  double tempC;
  double tempF;
  int isDay;
  Condition condition;
  double windMph;
  double windKph;
  int windDegree;
  String windDir;
  int humidity;
  int cloud;

  Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.humidity,
    required this.cloud,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    lastUpdatedEpoch: json["last_updated_epoch"],
    lastUpdated: json["last_updated"],
    tempC: json["temp_c"]?.toDouble(),
    tempF: json["temp_f"]?.toDouble(),
    isDay: json["is_day"],
    condition: Condition.fromJson(json["condition"]),
    windMph: json["wind_mph"]?.toDouble(),
    windKph: json["wind_kph"]?.toDouble(),
    windDegree: json["wind_degree"],
    windDir: json["wind_dir"],
    humidity: json["humidity"],
    cloud: json["cloud"],
  );

  Map<String, dynamic> toJson() => {
    "last_updated_epoch": lastUpdatedEpoch,
    "last_updated": lastUpdated,
    "temp_c": tempC,
    "temp_f": tempF,
    "is_day": isDay,
    "condition": condition.toJson(),
    "wind_mph": windMph,
    "wind_kph": windKph,
    "wind_degree": windDegree,
    "wind_dir": windDir,
    "humidity": humidity,
    "cloud": cloud,
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

class Location {
  String name;
  String region;
  String country;
  double lat;
  double lon;
  String tzId;
  String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
    region: json["region"],
    country: json["country"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    tzId: json["tz_id"],
    localtime: json["localtime"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "region": region,
    "country": country,
    "lat": lat,
    "lon": lon,
    "tz_id": tzId,
    "localtime": localtime,
  };
}
