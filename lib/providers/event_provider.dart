import 'package:flutter/material.dart';
import '../models/evento_model.dart';
import '../services/database_service.dart';

class EventProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();

  // Controlador para el buscador (lo manejamos desde aquí para ultra limpieza)
  final TextEditingController searchController = TextEditingController();

  List<Evento> _todosLosEventos = [];
  String _searchQuery = "";

  /// Lógica de índices actualizada:
  /// 0: Próximos 15 días (Por defecto)
  /// 1: Próximo Mes
  /// 2: Todos
  int _filtroTemporal = 0;

  EventProvider() {
    // Escuchamos cambios en el texto del buscador
    searchController.addListener(() {
      _searchQuery = searchController.text;
      notifyListeners();
    });

    // Escuchamos el Stream de Firebase
    _db.getEventos().listen((eventos) {
      // Ordenamos por fecha de más cercano a más lejano por defecto
      eventos.sort((a, b) => a.fechaInicio.compareTo(b.fechaInicio));
      _todosLosEventos = eventos;
      notifyListeners();
    });
  }

  // Getters para la UI
  String get searchQuery => _searchQuery;
  int get filtroTemporal => _filtroTemporal;

  /// Este es el motor de búsqueda y filtrado
  List<Evento> get eventosFiltrados {
    final ahora = DateTime.now();
    // Normalizamos a las 00:00 de hoy
    final hoy = DateTime(ahora.year, ahora.month, ahora.day);

    return _todosLosEventos.where((evento) {
      // 1. Filtro de búsqueda por texto (Título)
      final cumpleBusqueda = evento.titulo.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );

      // 2. Filtro temporal según el nuevo orden solicitado
      final cumpleFecha = switch (_filtroTemporal) {
        // Próximos 15 días: desde hoy (00:00) hasta hoy + 15 días
        0 =>
          evento.fechaInicio.isAfter(
                hoy.subtract(const Duration(seconds: 1)),
              ) &&
              evento.fechaInicio.isBefore(hoy.add(const Duration(days: 15))),

        // Próximo Mes: desde hoy (00:00) hasta hoy + 30 días
        1 =>
          evento.fechaInicio.isAfter(
                hoy.subtract(const Duration(seconds: 1)),
              ) &&
              evento.fechaInicio.isBefore(hoy.add(const Duration(days: 30))),

        // Todos los eventos
        2 => true,

        _ => true,
      };

      return cumpleBusqueda && cumpleFecha;
    }).toList();
  }

  // Setters
  void setFiltroTemporal(int index) {
    _filtroTemporal = index;
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear(); // Esto dispara el listener automáticamente
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
