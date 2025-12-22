import 'package:flutter/material.dart';

class DetalleHeader extends StatelessWidget {
  final String imagenUrl;
  final String id;

  const DetalleHeader({super.key, required this.imagenUrl, required this.id});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: id,
          child: Image.network(
            imagenUrl,
            fit: BoxFit.cover,
            // Importante: No ponemos caché aquí para que en detalle se vea a máxima calidad
          ),
        ),
      ),
    );
  }
}
