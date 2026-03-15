import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Importante para o relógio
import 'package:jatomei/screens/home_screen.dart';

void main() {
  runApp(const JaTomeiApp());
}

class JaTomeiApp extends StatelessWidget {
  const JaTomeiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Já Tomei?!',
      debugShowCheckedModeBanner: false,
      
      // CONFIGURAÇÃO DE IDIOMA (Resolve o problema do teclado no relógio)
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'), // Define o idioma como Português do Brasil
      ],
      locale: const Locale('pt', 'BR'), // Força o app a usar PT-BR

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A90E2),
          primary: const Color(0xFF4A90E2),
          surface: const Color(0xFFF8FAFC),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}