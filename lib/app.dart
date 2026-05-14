import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'controllers/theme_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class BarberlyAdminApp extends StatelessWidget {
  const BarberlyAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      title: 'Barberly Admin',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeMode,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: const [
            Breakpoint(start: 0, end: 599, name: MOBILE),
            Breakpoint(start: 600, end: 839, name: TABLET),
            Breakpoint(start: 840, end: 1199, name: DESKTOP),
            Breakpoint(start: 1200, end: double.infinity, name: '4K'),
          ],
        );
      },
    );
  }
}
