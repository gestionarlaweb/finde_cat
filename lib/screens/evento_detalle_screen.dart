import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/evento_model.dart';

class EventoDetalleScreen extends StatelessWidget {
  final Evento evento;

  const EventoDetalleScreen({super.key, required this.evento});

  // Función para abrir Google Maps
  Future<void> _abrirMapa() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${evento.latitud},${evento.longitud}';
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('No se pudo abrir el mapa');
    }
  }

  // Función para abrir la web del evento
  Future<void> _abrirWeb() async {
    if (!await launchUrl(Uri.parse(evento.url))) {
      throw Exception('No se pudo abrir la web');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Barra superior con imagen que se expande
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                evento.titulo,
                style: const TextStyle(
                  shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                ),
              ),
              background: Image.network(evento.imagenUrl, fit: BoxFit.cover),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Fila de Info Rápida
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.deepOrange),
                        const SizedBox(width: 5),
                        Text(
                          "${evento.municipio} (${evento.comarca})",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.grey),
                        const SizedBox(width: 5),
                        Text(
                          DateFormat(
                            'dd MMMM yyyy',
                            'es',
                          ).format(evento.fechaInicio),
                        ),
                      ],
                    ),

                    const Divider(height: 40),

                    const Text(
                      "Sobre este evento",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      evento.descripcion,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),

                    const SizedBox(height: 30),

                    // BOTONES DE ACCIÓN
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _abrirMapa,
                            icon: const Icon(Icons.map),
                            label: const Text("Cómo llegar"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[50],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _abrirWeb,
                            icon: const Icon(Icons.language),
                            label: const Text("Web Oficial"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50), // Espacio final
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
