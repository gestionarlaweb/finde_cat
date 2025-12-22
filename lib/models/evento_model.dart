class Evento {
  final String id;
  final String titulo;
  final String descripcion;
  final String comarca;
  final String municipio;
  final DateTime fechaInicio;
  final String imagenUrl;
  final double latitud;
  final double longitud;
  final String url;

  Evento({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.comarca,
    required this.municipio,
    required this.fechaInicio,
    required this.imagenUrl,
    required this.latitud,
    required this.longitud,
    required this.url,
  });

  factory Evento.fromFirestore(Map<String, dynamic> data, String id) {
    return Evento(
      id: id,
      titulo: data['titulo'] ?? 'Sin título',
      descripcion: data['descripcion'] ?? 'Sin descripción',
      comarca: data['comarca'] ?? 'Catalunya',
      municipio: data['municipio'] ?? 'Desconocido',
      fechaInicio:
          (data['fecha_inicio'] as dynamic)?.toDate() ?? DateTime.now(),
      imagenUrl: data['imagen_url'] ?? '',
      latitud: (data['latitud'] as num?)?.toDouble() ?? 0.0,
      longitud: (data['longitud'] as num?)?.toDouble() ?? 0.0,
      url: data['url'] ?? '',
    );
  }
}
