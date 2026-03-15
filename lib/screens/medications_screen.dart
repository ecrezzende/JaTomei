import 'package:flutter/material.dart';
import 'add_medication_screen.dart';

class MedicationsScreen extends StatelessWidget {
  const MedicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      // AppBar é a barra do topo
      appBar: AppBar(
        title: const Text("Meus Remédios", 
          style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.medication_liquid_rounded, 
                 size: 100, color: Colors.blue.withAlpha(50)),
            const SizedBox(height: 20),
            const Text("Nenhum remédio cadastrado.", 
              style: TextStyle(color: Colors.black54, fontSize: 16)),
          ],
        ),
      ),
      // O botão de adicionar (+)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Permite que o popup suba com o teclado
             backgroundColor: Colors.transparent,
             builder: (context) => const AddMedicationScreen(),
          );
        },
        backgroundColor: const Color(0xFF4A90E2),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}