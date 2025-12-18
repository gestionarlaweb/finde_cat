import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/evento_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Obtener todos los eventos ordenados por fecha
  Stream<List<Evento>> getEventos() {
    return _db
        .collection('eventos')
        .orderBy(
          'fecha_inicio',
          descending: false,
        ) // Cambiado de 'fecha' a 'fecha_inicio'
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Evento.fromFirestore(doc.data(), doc.id))
              .toList(),
        );
  }

  // Ejemplo: Función para que tú (admin) añadas un evento rápido
  Future<void> addEvento(Evento evento) async {
    await _db.collection('eventos').add({
      'titulo': evento.titulo,
      'comarca': evento.comarca,
      'fecha_inicio': evento.fechaInicio,
      'imagen_url': evento.imagenUrl,
    });
  }
}
