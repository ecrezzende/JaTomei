import 'package:flutter/material.dart';
import 'package:jatomei/screens/medications_screen.dart';
import 'package:jatomei/screens/history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Controla qual aba está ativa

  // Lista das telas que vamos navegar
  final List<Widget> _screens = [
    const DashboardView(), // O conteúdo que já tínhamos criado
    const MedicationsScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Mostra a tela baseada no índice
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Muda a tela quando clicamos no ícone
          });
        },
        selectedItemColor: const Color(0xFF4A90E2), // Nosso Azul Sereno
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.medication_rounded), label: 'Remédios'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'Histórico'),
        ],
      ),
    );
  }
}

// Coloque o código antigo da sua Dashboard aqui embaixo para ele não sumir!
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Bom dia,", style: TextStyle(fontSize: 18, color: Colors.black54)),
            const Text("Eduardo Rezende", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            // ... (Aquele card azul que já fizemos continua aqui dentro)
            _buildProgressCard(), 
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF4A90E2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Text("Seu progresso: 75%", style: TextStyle(color: Colors.white)),
    );
  }
}