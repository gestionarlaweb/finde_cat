import 'dart:convert';
import 'package:http/http.dart' as http;
import '../secrets.dart'; // Asegúrate de que este archivo exista y tenga la variable apiKey

class WeatherService {
  // Usamos la clave que tienes en secrets.dart
  final String _apiKey = apiKey;

  // Base URL para la API de OpenWeatherMap
  final String _baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<String> getWeatherPrediction(
    double lat,
    double lon,
    DateTime date,
  ) async {
    // OpenWeatherMap usa UNIX timestamps (segundos)
    final int timestamp = date.millisecondsSinceEpoch ~/ 1000;

    // Construimos la URL con los parámetros necesarios
    // Nota: 'units=metric' es para grados Celsius
    final url = Uri.parse(
      '$_baseUrl?lat=$lat&lon=$lon&dt=$timestamp&appid=$_apiKey&units=metric&lang=es',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extraemos la descripción y la temperatura
        final description = data['weather'][0]['description'];
        final temp = (data['main']['temp']).toStringAsFixed(0);

        // Devolvemos el texto formateado (ej: "Cielo claro, 14°C")
        return "${description[0].toUpperCase()}${description.substring(1)}, $temp°C";
      } else {
        print(">>> API Error: ${response.body}");
        return "Clima no disponible";
      }
    } catch (e) {
      print(">>> ERROR DE RED: $e");
      return "Sin conexión al clima";
    }
  }
}
