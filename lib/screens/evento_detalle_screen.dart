import 'package:flutter/material.dart';
import '../models/evento_model.dart';
import 'detalle/widgets/detalle_header.dart';
import 'detalle/widgets/detalle_info.dart';
import 'detalle/widgets/detalle_actions.dart';

class EventoDetalleScreen extends StatelessWidget {
  final Evento evento;

  const EventoDetalleScreen({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Widget 1: Cabecera
          DetalleHeader(imagenUrl: evento.imagenUrl, id: evento.id),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Widget 2: Información principal
                  DetalleInfo(evento: evento),

                  const SizedBox(height: 30),

                  // Widget 3: Botones inferiores
                  DetalleActions(
                    urlWeb: evento.url,
                    lat: evento.latitud,
                    lon: evento.longitud,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
