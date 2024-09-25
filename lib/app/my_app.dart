import 'package:flutter/material.dart';
import 'package:wall_app/module/home/screens/home_screens.dart';
import '../config/routes/nav_router.dart';
import '../config/themes/light_theme.dart';

class WallApp extends StatelessWidget {
  const WallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavRouter.navigationKey,
      title: 'Wall App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: const HomeScreens(),

    );
  }
}
