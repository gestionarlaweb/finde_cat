import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/evento_model.dart';
import '../widgets/evento_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseService db = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Finde Cat 🐾',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Evento>>(
        stream: db.getEventos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final eventos = snapshot.data ?? [];

          if (eventos.isEmpty) {
            return const Center(
              child: Text('No hay eventos próximos. ¡Vuelve pronto!'),
            );
          }

          return ListView.builder(
            itemCount: eventos.length,
            itemBuilder: (context, index) {
              return EventoCard(evento: eventos[index]);
            },
          );
        },
      ),
    );
  }
}
