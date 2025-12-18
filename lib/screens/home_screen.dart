import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/evento_model.dart';
import '../widgets/evento_card.dart';

// Cambiamos a StatefulWidget para poder cambiar el filtro dinámicamente
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Filtro por defecto: 0 = Todos, 1 = 15 días, 2 = 30 días
  int _filtroSeleccionado = 0;

  List<Evento> _aplicarFiltro(List<Evento> eventos) {
    final ahora = DateTime.now();

    if (_filtroSeleccionado == 1) {
      // Próximos 15 días
      final limite = ahora.add(const Duration(days: 15));
      return eventos
          .where(
            (e) =>
                e.fechaInicio.isAfter(ahora) && e.fechaInicio.isBefore(limite),
          )
          .toList();
    } else if (_filtroSeleccionado == 2) {
      // Próximo mes
      final limite = ahora.add(const Duration(days: 30));
      return eventos
          .where(
            (e) =>
                e.fechaInicio.isAfter(ahora) && e.fechaInicio.isBefore(limite),
          )
          .toList();
    }
    return eventos; // Todos
  }

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
      body: Column(
        children: [
          // BARRA DE FILTROS (CHIPS)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                _filtroChip(0, "Todos"),
                const SizedBox(width: 8),
                _filtroChip(1, "Próximos 15 días"),
                const SizedBox(width: 8),
                _filtroChip(2, "Próximo mes"),
              ],
            ),
          ),

          // LISTA DE EVENTOS
          Expanded(
            child: StreamBuilder<List<Evento>>(
              stream: db.getEventos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final todosLosEventos = snapshot.data ?? [];
                final eventosFiltrados = _aplicarFiltro(todosLosEventos);

                if (eventosFiltrados.isEmpty) {
                  return const Center(
                    child: Text('No hay eventos para este filtro.'),
                  );
                }

                return ListView.builder(
                  itemCount: eventosFiltrados.length,
                  itemBuilder: (context, index) =>
                      EventoCard(evento: eventosFiltrados[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para los botoncitos de filtro
  Widget _filtroChip(int index, String label) {
    bool seleccionado = _filtroSeleccionado == index;
    return ChoiceChip(
      label: Text(label),
      selected: seleccionado,
      selectedColor: Colors.deepOrange.withOpacity(0.2),
      onSelected: (bool selected) {
        setState(() {
          _filtroSeleccionado = index;
        });
      },
    );
  }
}
