import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/evento_model.dart';
import '../services/weather_service.dart';
import '../screens/evento_detalle_screen.dart'; // Importante para la navegación

class EventoCard extends StatelessWidget {
  final Evento evento;

  const EventoCard({super.key, required this.evento});

  // --- LÓGICA DEL CLIMA ---
  Widget _buildClimaSection() {
    final ahora = DateTime.now();
    final diferencia = evento.fechaInicio.difference(ahora).inDays;

    if (evento.fechaInicio.isBefore(ahora) && diferencia != 0) {
      return const Text(
        "Evento finalizado",
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    if (diferencia > 5) {
      return const Row(
        children: [
          Icon(Icons.info_outline, size: 14, color: Colors.orange),
          SizedBox(width: 4),
          Text(
            "Predicción disponible 5 días antes",
            style: TextStyle(fontSize: 12, color: Colors.orange),
          ),
        ],
      );
    }

    return FutureBuilder<String>(
      future: WeatherService().getWeatherPrediction(
        evento.latitud,
        evento.longitud,
        evento.fechaInicio,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 14,
            width: 14,
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Text(
            "Clima no disponible",
            style: TextStyle(fontSize: 12),
          );
        }

        return Row(
          children: [
            const Icon(
              Icons.wb_cloudy_outlined,
              size: 16,
              color: Colors.blueAccent,
            ),
            const SizedBox(width: 4),
            Text(
              snapshot.data!,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      // EL INKWELL HACE QUE TODA LA TARJETA SEA CLICABLE
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventoDetalleScreen(evento: evento),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PARTE SUPERIOR: IMAGEN Y COMARCA
            Stack(
              children: [
                Image.network(
                  evento.imagenUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  // Mientras carga la imagen del servidor:
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  // Si la URL es inválida o falla la red:
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image, size: 50, color: Colors.grey),
                        SizedBox(height: 8),
                        Text(
                          "Imagen no disponible",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      evento.comarca,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),

            // PARTE INFERIOR: TEXTOS E INFO
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evento.titulo,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Fila de Ubicación y Fecha
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.deepOrange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        evento.municipio,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.calendar_month,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('dd/MM/yyyy').format(evento.fechaInicio),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),

                  const Divider(height: 24),

                  // SECCIÓN DE CLIMA
                  _buildClimaSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
