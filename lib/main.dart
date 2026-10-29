import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/neobrutalism.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatatanKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: NeoColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: NeoColors.primary,
          primary: NeoColors.black,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: NeoColors.black,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
          iconTheme: IconThemeData(color: NeoColors.black),
        ),
        dividerTheme: const DividerThemeData(
          color: NeoColors.black,
          thickness: 1.5,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
