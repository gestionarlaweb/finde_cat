import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardInfo extends StatelessWidget {
  final String titulo;
  final String municipio;
  final DateTime fecha;

  const CardInfo({
    super.key,
    required this.titulo,
    required this.municipio,
    required this.fecha,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.deepOrange),
              const SizedBox(width: 4),
              Text(municipio),
              const Spacer(),
              Text(DateFormat('dd/MM/yyyy').format(fecha)),
            ],
          ),
        ],
      ),
    );
  }
}
