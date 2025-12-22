import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/evento_model.dart';

class DetalleInfo extends StatelessWidget {
  final Evento evento;

  const DetalleInfo({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          evento.titulo,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildInfoRow(
          Icons.location_on,
          "${evento.municipio} (${evento.comarca})",
        ),
        _buildInfoRow(
          Icons.calendar_today,
          DateFormat('dd MMMM yyyy', 'es').format(evento.fechaInicio),
        ),
        const Divider(height: 40),
        Text("Descripción", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Text(
          evento.descripcion,
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icono, String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icono, size: 20, color: Colors.deepOrange),
          const SizedBox(width: 10),
          Text(texto, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
