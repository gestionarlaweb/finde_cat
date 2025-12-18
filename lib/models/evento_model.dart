class Evento {
  final String id;
  final String titulo;
  final String descripcion;
  final String comarca;
  final String municipio;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String imagenUrl;
  final double latitud; // Campo necesario para el clima
  final double longitud; // Campo necesario para el clima
  final String categoria;
  final String url;

  Evento({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.comarca,
    required this.municipio,
    required this.fechaInicio,
    required this.fechaFin,
    required this.imagenUrl,
    required this.latitud,
    required this.longitud,
    required this.categoria,
    required this.url,
  });

  // Convertir de Firestore (Map) a Objeto Evento
  factory Evento.fromFirestore(Map<String, dynamic> data, String id) {
    return Evento(
      id: id,
      titulo: data['titulo'] ?? '',
      descripcion: data['descripcion'] ?? '',
      comarca: data['comarca'] ?? '',
      municipio: data['municipio'] ?? '',
      // Convertimos los Timestamps de Firestore a DateTime de Dart
      fechaInicio:
          (data['fecha_inicio'] as dynamic)?.toDate() ?? DateTime.now(),
      fechaFin: (data['fecha_fin'] as dynamic)?.toDate() ?? DateTime.now(),
      imagenUrl: data['imagen_url'] ?? '',
      // Convertimos a double por si acaso en Firestore se guardaron como int
      latitud: (data['latitud'] as num?)?.toDouble() ?? 0.0,
      longitud: (data['longitud'] as num?)?.toDouble() ?? 0.0,
      categoria: data['categoria'] ?? '',
      url: data['url'] ?? '',
    );
  }

  // Opcional: Para enviar datos a Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'comarca': comarca,
      'municipio': municipio,
      'fecha_inicio': fechaInicio,
      'fecha_fin': fechaFin,
      'imagen_url': imagenUrl,
      'latitud': latitud,
      'longitud': longitud,
      'categoria': categoria,
      'url': url,
    };
  }
}
