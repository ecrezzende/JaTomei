import 'package:flutter/material.dart';
import 'package:jatomei/models/medication_model.dart';

class AddMedicationScreen extends StatefulWidget {
  final Function(Medication) onSave;
  const AddMedicationScreen({super.key, required this.onSave});

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final nameController = TextEditingController();
  final dosageController = TextEditingController();
  final stockController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isContinuous = false;
  int frequencyHours = 8;
  int durationDays = 7;

Future<void> _selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: selectedTime,
    initialEntryMode: TimePickerEntryMode.inputOnly, // Força a digitação
    useRootNavigator: true, // ABRE FORA DO POPUP para ter espaço total
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        // Garante que o relógio não tente herdar restrições do popup
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      );
    },
  );
  if (picked != null) setState(() => selectedTime = picked);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Usar Scaffold dentro do popup resolve 90% dos erros de layout
      backgroundColor: Colors.transparent,
      body: Container(
        margin: const EdgeInsets.only(top: 50), // Espaço para não colar no topo
        decoration: const BoxDecoration(
          color: Color(0xFFF8FAFC),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          children: [
            // Barra de arrastar
            const SizedBox(height: 12),
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(10)))),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text("Novo Medicamento", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 25),
                  _buildLabel("Nome"),
                  _buildTextField("Ex: Amoxicilina", Icons.medication, nameController),
                  const SizedBox(height: 20),
                  _buildLabel("Dosagem"),
                  _buildTextField("Ex: 500mg", Icons.straighten, dosageController),
                  const SizedBox(height: 20),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Hora"),
                            _buildSelectorTile(
                              text: selectedTime.format(context),
                              icon: Icons.access_time_filled,
                              onTap: () => _selectTime(context),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildFrequencyDropdown(),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  _buildLabel("Estoque"),
                  _buildTextField("Qtd", Icons.inventory, stockController, isNumber: true),
                  const SizedBox(height: 20),
                  _buildUsageToggle(),
                  const SizedBox(height: 30),
                  _buildSaveButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Métodos auxiliares (Label, TextField, etc - mantidos conforme você já tem)
  Widget _buildLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)));
  
  Widget _buildTextField(String hint, IconData icon, TextEditingController controller, {bool isNumber = false}) => TextField(
    controller: controller,
    keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF4A90E2)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
    ),
  );

  Widget _buildSelectorTile({required String text, required IconData icon, required VoidCallback onTap}) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.black12)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(text), Icon(icon, color: const Color(0xFF4A90E2))]),
    ),
  );

  Widget _buildFrequencyDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Intervalo"),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.black12)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: frequencyHours,
              isExpanded: true,
              items: [4, 6, 8, 12, 24].map((i) => DropdownMenuItem(value: i, child: Text("$i h"))).toList(),
              onChanged: (v) => setState(() => frequencyHours = v!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsageToggle() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.black12)),
      child: SwitchListTile(
        title: const Text("Uso Contínuo?"),
        value: isContinuous,
        onChanged: (v) => setState(() => isContinuous = v),
        activeColor: const Color(0xFF4A90E2),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          final newMed = Medication(
            name: nameController.text,
            dosage: dosageController.text,
            firstDose: selectedTime,
            frequencyHours: frequencyHours,
            stock: int.tryParse(stockController.text) ?? 0,
            isContinuous: isContinuous,
          );
          widget.onSave(newMed);
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A90E2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        child: const Text("Salvar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}