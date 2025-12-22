import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalleActions extends StatelessWidget {
  final String urlWeb;
  final double lat;
  final double lon;

  const DetalleActions({
    super.key,
    required this.urlWeb,
    required this.lat,
    required this.lon,
  });

  Future<void> _abrirUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _abrirUrl(
              "https://www.google.com/maps/search/?api=1&query=$lat,$lon",
            ),
            icon: const Icon(Icons.map),
            label: const Text("Mapa"),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _abrirUrl(urlWeb),
            icon: const Icon(Icons.language),
            label: const Text("Web"),
          ),
        ),
      ],
    );
  }
}
