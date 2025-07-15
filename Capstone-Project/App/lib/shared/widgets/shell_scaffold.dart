import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../../core/theme/app_theme.dart';
import '../../core/constants/app_routes.dart';

class ShellScaffold extends StatelessWidget {
  final Widget child;
  final String location;

  const ShellScaffold({super.key, required this.child, required this.location});

  int _getSelectedIndex(String location) {
    switch (location) {
      case AppRoutes.home:
        return 0;
      case AppRoutes.detectionHistory:
        return 1;
      case AppRoutes.careGuide:
        return 2;
      case AppRoutes.settings:
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: WaterDropNavBar(
          backgroundColor: Theme.of(context).cardColor,
          waterDropColor: AppTheme.accentGreen,
          selectedIndex: _getSelectedIndex(location),
          onItemSelected: (index) {
            switch (index) {
              case 0:
                context.go(AppRoutes.home);
                break;
              case 1:
                context.go(AppRoutes.detectionHistory);
                break;
              case 2:
                context.go(AppRoutes.careGuide);
                break;
              case 3:
                context.go(AppRoutes.settings);
                break;
            }
          },
          barItems: [
            BarItem(
              filledIcon: Icons.home_rounded,
              outlinedIcon: Icons.home_outlined,
            ),
            BarItem(
              filledIcon: Icons.history_rounded,
              outlinedIcon: Icons.history_outlined,
            ),
            BarItem(
              filledIcon: Icons.book_rounded,
              outlinedIcon: Icons.book_outlined,
            ),
            BarItem(
              filledIcon: Icons.settings_rounded,
              outlinedIcon: Icons.settings_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
