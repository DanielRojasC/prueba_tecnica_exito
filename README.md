
# Prueba Técnica Éxito

Este es un proyecto Flutter desarrollado como parte de una prueba técnica. Se ha construido con una arquitectura limpia, empleando buenas prácticas modernas y un enfoque modular para facilitar el mantenimiento y la escalabilidad.

---

## 🚀 Tecnologías utilizadas

- **Flutter**: `3.32.7 (stable)`
- **Dart**: `3.8.1`

---

## 📦 Dependencias principales

| Paquete           | Versión      | Descripción breve                              |
|-------------------|--------------|-----------------------------------------------|
| `dio`             | ^5.8.0+1     | Cliente HTTP                                  |
| `equatable`       | ^2.0.7       | Comparación de objetos por valor              |
| `flutter_bloc`    | ^9.1.1       | Implementación de BLoC (Business Logic)       |
| `flutter_dotenv`  | ^5.2.1       | Manejo de variables de entorno `.env`         |
| `get_it`          | ^8.0.3       | Inyección de dependencias (Injector)         |
| `go_router`       | ^16.0.0      | Navegación declarativa                        |
| `intl`            | ^0.20.2      | Internacionalización y manejo de fechas       |

---

## 🧪 Dependencias de desarrollo

| Paquete              | Versión      | Descripción breve                        |
|----------------------|--------------|------------------------------------------|
| `dart_code_linter`   | ^3.0.0       | Reglas avanzadas de análisis de código   |

---

## 🖼️ Recursos

- **Fuentes personalizadas**: Roboto y Roboto Condensed
- **Activos estáticos**: Imágenes, íconos, etc. ubicados en `assets/`

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/
  fonts:
    - family: Roboto
      fonts:
        - asset: assets/fonts/Roboto-Regular.ttf
        - asset: assets/fonts/Roboto-Medium.ttf
        - asset: assets/fonts/Roboto-Bold.ttf
        - asset: assets/fonts/Roboto-Italic.ttf
          style: italic
        - asset: assets/fonts/Roboto-BoldItalic.ttf
          weight: 700
          style: italic
    - family: RobotoCondensed
      fonts:
        - asset: assets/fonts/Roboto_Condensed-Regular.ttf
        - asset: assets/fonts/Roboto_Condensed-Bold.ttf
        - asset: assets/fonts/Roboto_Condensed-Italic.ttf
          style: italic
        - asset: assets/fonts/Roboto_Condensed-BoldItalic.ttf
          weight: 700
          style: italic
````

---

## 📁 Estructura seleccionada

El proyecto sigue una clean architecture, separando las capas:

```
lib/
│
├── core/
│   └── constants/
│   └── utils/
│
├── features/
│   └── categories/
│       ├── domain/
│       ├── data/
│       └── presentation/
│
├── shared/
│   └── widgets/
│
└── main.dart
```

---

## 🧹 Linter y análisis estático

Se utilizan reglas avanzadas de linting con `dart_code_linter` y `flutter_lints`, para garantizar un código limpio, seguro y mantenible.

---

## ✅ Cómo ejecutar el proyecto

1. Clona el repositorio:

   ```bash
   git clone https://github.com/tu_usuario/prueba_tecnica_exito.git
   cd prueba_tecnica_exito
   ```

2. Cargar las variables de entorno en un archivo `.env`.

3. Instalación de dependencias:

   ```bash
   flutter pub get
   ```

4. Ejecutar la aplicación:

   ```bash
   flutter run
   ```

---

