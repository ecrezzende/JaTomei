import 'package:flutter/material.dart';
import 'package:jatomei/screens/home_screen.dart';
// Importaremos as telas aqui em breve

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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A90E2), // Azul Moderno
          primary: const Color(0xFF4A90E2),
          surface: const Color(0xFFF8FAFC), // Fundo quase branco (Premium)
        ),
        // Estilo dos cards que vamos usar muito
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
        ),
      ),
      home: const HomeScreen(), // Remova o PlaceholderHome
    );
  }
}

// Tela temporária só para o app rodar agora
class PlaceholderHome extends StatelessWidget {
  const PlaceholderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Dashboard vindo aí...')));
  }
}
