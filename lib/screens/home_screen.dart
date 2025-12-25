import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // ¡No olvides este import!
import '../providers/event_provider.dart';
import 'home/widgets/home_search_bar.dart';
import 'home/widgets/home_filters.dart';
import '../../widgets/evento_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos context.watch para que se redibuje cuando el Provider cambie
    final eventProvider = context.watch<EventProvider>();
    final eventos = eventProvider.eventosFiltrados;

    return Scaffold(
      appBar: AppBar(title: const Text('Finde Cat'), elevation: 0),
      body: Column(
        children: [
          HomeSearchBar(
            controller: eventProvider
                .searchController, // <--- Aquí pasamos el parámetro requerido
            query: eventProvider.searchQuery,
            onChanged: (val) {
              // Ya no hace falta hacer nada aquí porque el Provider tiene un listener
            },
            onClear: () => eventProvider.clearSearch(),
          ),
          HomeFilters(
            filtroTemporal: eventProvider.filtroTemporal,
            onFilterSelected: (index) => eventProvider.setFiltroTemporal(index),
          ),
          Expanded(
            child: eventos.isEmpty
                ? const Center(child: Text("No hay eventos en estas fechas"))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: eventos.length,
                    itemBuilder: (context, index) {
                      // Mantenemos tu animación pero la simplificamos visualmente
                      return AnimationItem(
                        index: index,
                        child: EventoCard(evento: eventos[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para mantener el HomeScreen ultra limpio
class AnimationItem extends StatelessWidget {
  final int index;
  final Widget child;
  const AnimationItem({super.key, required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + (index * 50)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
