import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/stats_provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => StatsProvider()),
      ],
      child: const TasslimApp(),
    ),
  );
}

class TasslimApp extends StatelessWidget {
  const TasslimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasslim Parts Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if (auth.isInitialLoading) {
            return const SplashScreen();
          }
          return auth.isAuthenticated 
              ? DashboardScreen() 
              : const LoginScreen();
        },
      ),
    );
  }
}
