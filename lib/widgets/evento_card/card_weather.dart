import 'package:flutter/material.dart';
import '../../services/weather_service.dart';

class CardWeather extends StatelessWidget {
  final double lat;
  final double lon;

  const CardWeather({super.key, required this.lat, required this.lon});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: WeatherService().getClima(lat, lon),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 20);
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              const Icon(Icons.wb_sunny_outlined, size: 16, color: Colors.blue),
              const SizedBox(width: 5),
              Text(
                snapshot.data!,
                style: const TextStyle(fontSize: 12, color: Colors.blue),
              ),
            ],
          ),
        );
      },
    );
  }
}
