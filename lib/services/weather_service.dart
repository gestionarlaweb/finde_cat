import 'dart:convert';
import 'package:http/http.dart' as http;
import '../secrets.dart';

class WeatherService {
  static final WeatherService _instance = WeatherService._internal();
  factory WeatherService() => _instance;
  WeatherService._internal();

  final String _baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<String> getClima(double lat, double lon) async {
    final url = Uri.parse(
      '$_baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=es',
    );

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final temp = data['main']['temp'].toStringAsFixed(0);
        final desc = data['weather'][0]['description'];
        return "${desc[0].toUpperCase()}${desc.substring(1)}, $temp°C";
      }
    } catch (e) {
      print("Error Clima: $e");
    }
    return "Clima no disponible";
  }
}
