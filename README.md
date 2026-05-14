![Flutter](https://img.shields.io/badge/Flutter-3.41-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.11-blue?logo=dart)
![Web](https://img.shields.io/badge/Plataforma-Web-orange)
![Licencia](https://img.shields.io/badge/Licencia-Acad%C3%A9mica-green)

Dashboard administrativo web desarrollado en Flutter que simula el centro de gestión de una plataforma de barberías. Proyecto académico elaborado para la asignatura **Laboratorio Programado Integrador**.

---

## Características principales

- Panel de control con 8 tarjetas de indicadores clave (KPIs)
- 8 módulos administrativos con navegación lateral
- Tablas de datos con búsqueda y filtros
- Gráficos interactivos (barras, pastel y líneas)
- Modo oscuro / claro
- Diseño responsive adaptable a múltiples dispositivos
- Datos simulados (mock data) — sin conexión a backend
- Animaciones de entrada en dashboard y reportes
- Estructura preparada para integración futura con Firebase o API REST

---

## Tecnologías utilizadas

| Paquete | Versión | Uso |
|---|---|---|
| `provider` | ^6.1 | Gestión de estado |
| `go_router` | ^14.8 | Navegación web declarativa |
| `fl_chart` | ^0.70 | Gráficos de barras, pastel y líneas |
| `data_table_2` | ^2.6 | Tablas de datos con scroll |
| `responsive_framework` | ^1.5 | Puntos de quiebre responsive |
| `flutter_animate` | ^4.5 | Animaciones de entrada |
| `google_fonts` | ^6.2 | Tipografía Poppins |
| `intl` | ^0.19 | Formateo de fechas |

---

## Arquitectura del proyecto

```
lib/
├── main.dart                          # Punto de entrada
├── app.dart                           # Configuración de MaterialApp.router
├── core/
│   ├── constants/                     # Constantes de la app
│   ├── router/                        # Configuración de go_router
│   ├── theme/                         # Tema claro y oscuro
│   └── utils/                         # Helpers responsive
├── models/                            # 7 modelos de datos
├── services/
│   └── mock/                          # 7 archivos de datos simulados
├── controllers/                       # 9 providers (ChangeNotifier)
├── screens/
│   ├── dashboard/                     # Pantalla principal con KPIs
│   ├── appointments/                  # Gestión de citas
│   ├── barber_shops/                  # Barberías registradas
│   ├── barbers/                       # Barberos activos
│   ├── clients/                       # Clientes registrados
│   ├── services/                      # Servicios disponibles
│   ├── reports/                       # Reportes y analíticas
│   └── settings/                      # Configuración y perfil
└── widgets/
    ├── layout/                        # Sidebar, Topbar, Shell
    ├── cards/                         # Tarjetas métricas
    ├── charts/                        # Gráficos (fl_chart)
    ├── tables/                        # Tablas de datos (data_table_2)
    └── common/                        # Badges, botones, headers
```

**Total: 49 archivos Dart**

---

## Módulos del dashboard

| # | Módulo | Ruta | Descripción |
|---|---|---|---|
| 1 | Dashboard | `/dashboard` | 8 tarjetas KPI + tabla de citas recientes |
| 2 | Citas | `/appointments` | Tabla con filtro por estado y búsqueda |
| 3 | Barberías | `/barber-shops` | Tabla de barberías registradas |
| 4 | Barberos | `/barbers` | Tabla con especialidad y calificación |
| 5 | Clientes | `/clients` | Tabla con historial de citas |
| 6 | Servicios | `/services` | Tabla de servicios y precios |
| 7 | Reportes | `/reports` | Gráficos + resumen + botones de exportación |
| 8 | Configuración | `/settings` | Perfil, tema, notificaciones, permisos |

---

## Requisitos del sistema

- Flutter SDK 3.41 o superior
- Dart 3.11 o superior
- Chrome (para ejecución web)
- PowerShell (para comandos en scripts)

---

## Instalación y ejecución

```bash
# 1. Clonar el repositorio
git clone <url-del-repositorio>
cd barberly_admin

# 2. Instalar dependencias
flutter pub get

# 3. Ejecutar en Chrome
flutter run -d chrome

# 4. Compilar para producción
flutter build web
```

La aplicación se abrirá en `http://localhost:8080` (o el puerto asignado por Flutter).

---

## Datos simulados

Toda la información mostrada es **mock data** generada estáticamente. No se requiere conexión a internet ni configuración de base de datos.

Los datos incluyen:
- **18 citas** con diferentes estados (pendiente, confirmada, completada, cancelada)
- **12 clientes** con historial de citas
- **10 barberos** con especialidades y calificaciones
- **5 barberías** con ubicaciones y dueños
- **10 servicios** con precios y duraciones

Los datos se cargan con un retraso simulado de 300-500ms para emular una carga desde API.

---

## Diseño responsive

| Punto de quiebre | Ancho | Comportamiento |
|---|---|---|
| Móvil | < 600px | Sidebar oculta, 1 columna de tarjetas |
| Tablet | 600 – 839px | Sidebar colapsada (solo iconos), 2 columnas |
| Escritorio | 840 – 1199px | Sidebar expandida, 3 columnas |
| 4K | ≥ 1200px | Sidebar completa, 4 columnas |

---

## Roles de usuario

El dashboard simula el rol de **Administrador**, con acceso completo a todos los módulos y permisos de lectura/escritura en cada sección. El panel de configuración muestra visualmente los permisos asignados al rol.

---

## Posibles integraciones futuras

- **Firebase**: Conexión a Firestore para sincronización en tiempo real
- **Autenticación**: Firebase Auth con roles diferenciados (admin, dueño, barbero)
- **API REST**: Backend personalizado con Node.js, Django o Spring Boot
- **Exportaciones reales**: Generación de PDF con `pdf` package y Excel con `excel`
- **Notificaciones push**: Firebase Cloud Messaging para alertas de nuevas citas

---

## Documentación técnica

El manual técnico del proyecto debe incluir:

1. **Portada** — Nombre del proyecto, integrantes, curso, fecha
2. **Introducción** — Propósito del dashboard y relación con el proyecto grupal de barbería
3. **Arquitectura** — Diagrama de carpetas y explicación de cada capa
4. **Módulos implementados** — Captura de pantalla y descripción de cada módulo
5. **Navegación** — Configuración de go_router y tabla de rutas
6. **Datos mock** — Estructura y justificación del uso de datos simulados
7. **Gráficos** — Librerías utilizadas y datos representados
8. **Diseño responsive** — Puntos de quiebre y adaptaciones
9. **Librerías** — Listado completo con justificación
10. **Integración futura** — Roadmap para conexión con backend real
11. **Conclusiones** — Aprendizajes y posibles mejoras
12. **Anexo** — Código fuente completo o enlace al repositorio

---

## Créditos

Proyecto desarrollado como parte del curso **Laboratorio Programado Integrador**.

**Tecnología**: Flutter Web | **Lenguaje**: Dart | **Año**: 2026
