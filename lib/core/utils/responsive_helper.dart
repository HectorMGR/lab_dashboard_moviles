import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveHelper {
  ResponsiveHelper._();

  static bool isMobile(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isMobile;

  static bool isTablet(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isTablet;

  static bool isDesktop(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isDesktop;

  static bool isLargeDesktop(BuildContext context) =>
      ResponsiveBreakpoints.of(context).largerThan(DESKTOP);

  static bool isSmallScreen(BuildContext context) =>
      ResponsiveBreakpoints.of(context).smallerThan(TABLET);

  static int cardGridColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    if (isDesktop(context)) return 3;
    return 4;
  }

  static double sidebarWidth(BuildContext context) {
    if (isMobile(context)) return 72;
    if (isTablet(context)) return 72;
    return 260;
  }

  static EdgeInsets contentPadding(BuildContext context) {
    if (isMobile(context)) return const EdgeInsets.all(16);
    return const EdgeInsets.all(24);
  }
}
