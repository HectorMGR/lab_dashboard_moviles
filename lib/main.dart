import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/theme_provider.dart';
import 'controllers/navigation_provider.dart';
import 'controllers/dashboard_provider.dart';
import 'controllers/appointment_provider.dart';
import 'controllers/barber_shop_provider.dart';
import 'controllers/barber_provider.dart';
import 'controllers/client_provider.dart';
import 'controllers/service_provider.dart';
import 'controllers/report_provider.dart';
import 'app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => BarberShopProvider()),
        ChangeNotifierProvider(create: (_) => BarberProvider()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
      ],
      child: const BarberlyAdminApp(),
    ),
  );
}
