import 'package:flutter/material.dart';
import '../models/evento_model.dart';
import '../screens/evento_detalle_screen.dart';
import 'evento_card/card_image.dart';
import 'evento_card/card_info.dart';
import 'evento_card/card_weather.dart';

class EventoCard extends StatelessWidget {
  final Evento evento;

  const EventoCard({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _navigateToDetail(context),
        child: Column(
          children: [
            CardImage(
              imagenUrl: evento.imagenUrl,
              comarca: evento.comarca,
              id: evento.id,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  CardInfo(
                    titulo: evento.titulo,
                    municipio: evento.municipio,
                    fecha: evento.fechaInicio,
                  ),
                  const Divider(),
                  CardWeather(lat: evento.latitud, lon: evento.longitud),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EventoDetalleScreen(evento: evento)),
    );
  }
}
