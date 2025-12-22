import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../../models/evento_model.dart';
import '../../widgets/evento_card.dart';
// IMPORTANTE: Importa tus nuevos widgets fragmentados
import 'home/widgets/home_search_bar.dart';
import 'home/widgets/home_filters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _db = DatabaseService();
  late Stream<List<Evento>> _eventosStream;

  // Aquí es donde vive el controlador
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  int _filtroTemporal = 0;

  @override
  void initState() {
    super.initState();
    _eventosStream = _db.getEventos();
  }

  @override
  void dispose() {
    _searchController.dispose(); // Limpieza de memoria
    super.dispose();
  }

  // ... lógica de _aplicarFiltros (igual que antes) ...
  List<Evento> _aplicarFiltros(List<Evento> lista) {
    List<Evento> resultados = lista;
    if (_filtroTemporal != 0) {
      final ahora = DateTime.now();
      final dias = _filtroTemporal == 1 ? 15 : 30;
      final fechaLimite = ahora.add(Duration(days: dias));
      resultados = resultados
          .where((e) => e.fechaInicio.isBefore(fechaLimite))
          .toList();
    }
    if (_searchQuery.isNotEmpty) {
      resultados = resultados
          .where(
            (e) => e.titulo.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }
    return resultados;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finde Cat 🐾')),
      body: Column(
        children: [
          // USAMOS EL WIDGET FRAGMENTADO
          HomeSearchBar(
            controller: _searchController, // Pasamos el controlador
            query: _searchQuery,
            onChanged: (val) => setState(() => _searchQuery = val),
            onClear: () {
              _searchController.clear();
              setState(() => _searchQuery = "");
            },
          ),
          // USAMOS EL WIDGET FRAGMENTADO
          HomeFilters(
            filtroTemporal: _filtroTemporal,
            onFilterSelected: (index) =>
                setState(() => _filtroTemporal = index),
          ),
          Expanded(
            child: StreamBuilder<List<Evento>>(
              stream: _eventosStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return const Center(child: CircularProgressIndicator());
                final eventos = _aplicarFiltros(snapshot.data!);
                return ListView.builder(
                  itemCount: eventos.length,
                  itemBuilder: (context, index) =>
                      EventoCard(evento: eventos[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
