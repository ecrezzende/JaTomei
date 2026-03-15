import 'package:flutter/material.dart';
import '../models/medication_model.dart';
import 'add_medication_screen.dart';

class MedicationsScreen extends StatefulWidget {
  const MedicationsScreen({super.key});

  @override
  State<MedicationsScreen> createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  // Esta é a nossa "memória" temporária dos remédios
  List<Medication> myMedications = [];

  void _addNewMedication(Medication med) {
    setState(() {
      myMedications.add(med);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text("Meus Remédios", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // Se a lista estiver vazia, mostra o ícone de vazio. Se não, mostra os nomes!
      body: myMedications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: myMedications.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final item = myMedications[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.medication, color: Color(0xFF4A90E2)),
                    title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${item.dosage} - Próxima: ${item.firstDose.format(context)}"),
                    trailing: Text("Estoque: ${item.stock}"),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Mantém isso para o teclado não cobrir o popup
            backgroundColor: Colors.transparent,
            builder: (context) => AddMedicationScreen(onSave: _addNewMedication),
          );
        },
        backgroundColor: const Color(0xFF4A90E2),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.medication_liquid_rounded, size: 100, color: Colors.blue.withAlpha(50)),
          const SizedBox(height: 20),
          const Text("Nenhum remédio cadastrado.", style: TextStyle(color: Colors.black54, fontSize: 16)),
        ],
      ),
    );
  }
}