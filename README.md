# Finde Cat -📍

**Finde Cat** es una Progressive Web App (PWA) de alto rendimiento desarrollada con **Flutter**. Su objetivo es conectar a los usuarios con los mejores eventos y actividades culturales en Cataluña mediante una interfaz intuitiva, rápida y funcional.

---

## 🚀 Características Principales

* **Gestión de Estado Profesional:** Arquitectura basada en `Provider` para separar la lógica de negocio de la UI.
* **Filtrado Inteligente:** Búsqueda por texto y filtros temporales (15 días, Próximo Mes, Todos).
* **Backend Escalable:** Integración total con **Firebase** (Firestore y Storage).
* **Experiencia PWA:** Optimizado para web, instalable y con renderizado de alta fidelidad (**CanvasKit**).
* **Ultra Limpieza:** Implementación de Dart 3.x (Patterns y Null Safety).

---

## 🛠️ Stack Tecnológico

* **Frontend:** Flutter 3.38.3 / Dart 3.10.1
* **Gestión de Estado:** `provider: ^6.1.2`
* **Base de Datos:** Cloud Firestore
* **Hosting & Storage:** Firebase Hosting & Storage

---

## 📂 Estructura del Proyecto

```text
lib/
├── models/          # Modelos de datos (Evento)
├── providers/       # Lógica y filtros (EventProvider)
├── screens/         # Pantallas y widgets fragmentados
├── services/        # Conexión Firebase (DatabaseService)
├── theme/           # Estilos globales (AppTheme)
└── widgets/         # Componentes reutilizables (EventoCard)
```


###  1- 🔧 Clonar el repositorio:

* git clone [https://github.com/gestionarlaweb/finde_cat.git](https://github.com/gestionarlaweb/finde_cat.git)

###  2-  Instalar dependencias:

* flutter pub get

###  3-  Ejecutar en modo Debug:

* flutter run


### 🌍 Despliegue en Producción (PWA)
* Para compilar y subir la aplicación a Firebase Hosting:

### 1- Limpiar compilaciones previas:

* flutter clean

### 2- Compilar para la web:

* flutter build web --release --web-renderer canvaskit

### 3- Subir a Firebase:

* firebase deploy --only hosting

**Nota Importante**: Tras el despliegue, asegúrate de tener configurado el archivo cors.json en Firebase Storage para que las imágenes se rendericen correctamente en el dominio web.

### 📝 Autor

**Proyecto desarrollado y mantenido por**:

Desarrollador: David Rabassa

Web: https://gestionarlaweb.com

LinkedIn: https://www.linkedin.com/in/david-rabassa-planas-687abb170/

© 2025 Finde Cat - Eventos en Cataluña.