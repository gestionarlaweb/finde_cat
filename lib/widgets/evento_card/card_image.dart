import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final String imagenUrl;
  final String comarca;
  final String id;

  const CardImage({
    super.key,
    required this.imagenUrl,
    required this.comarca,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: id,
          child: Image.network(
            imagenUrl,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            cacheWidth: 300,
            filterQuality: FilterQuality.low,
            loadingBuilder: (_, child, progress) {
              if (progress == null) return child;
              return Container(
                height: 180,
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            },
            errorBuilder: (_, __, ___) => Container(
              height: 180,
              color: Colors.grey[300],
              child: const Icon(
                Icons.broken_image,
                size: 40,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Positioned(top: 10, right: 10, child: _buildBadge()),
      ],
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        comarca,
        style: const TextStyle(color: Colors.white, fontSize: 11),
      ),
    );
  }
}
