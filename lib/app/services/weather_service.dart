import 'package:http/http.dart' as http;

import '../api/api_key.dart';


// final String url = "https://api.weatherapi.com/v1/current.json?key=${apiKey}";
final String urlFore = "https://api.weatherapi.com/v1/forecast.json?key=${apiKey}&days=3";

class WeatherService {
  static var client = http.Client();
  static Future<dynamic> getDataWeather(String latlong) async {
    var response = await client.get(Uri.parse("$urlFore&q=$latlong"), headers: {'Content-Type': 'application/json; charset=UTF-8'});
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}
