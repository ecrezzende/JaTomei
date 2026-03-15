import 'package:flutter/material.dart';
import 'package:jatomei/models/medication_model.dart';

class AddMedicationScreen extends StatefulWidget {
  final Function(Medication) onSave; 

  const AddMedicationScreen({super.key, required this.onSave}); 

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  // Controladores para capturar o texto digitado
  final nameController = TextEditingController();
  final dosageController = TextEditingController();
  final stockController = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();
  bool isContinuous = false;
  int frequencyHours = 8; 
  int durationDays = 7; 

  @override
  void dispose() {
    // Boa prática: limpar os controladores quando fechar a tela
    nameController.dispose();
    dosageController.dispose();
    stockController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial, 
    );
    if (picked != null) setState(() => selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20, left: 20, right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 20),
            const Text("Novo Medicamento", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            
            const SizedBox(height: 25),
            _buildLabel("Nome do Medicamento"),
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
                      _buildLabel("Primeira Dose"),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Intervalo (Horas)"),
                      _buildFrequencyDropdown(),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            _buildLabel("Estoque Inicial"),
            _buildTextField("Qtd comprimidos", Icons.inventory, stockController, isNumber: true),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.black12)),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text("Uso Contínuo?"),
                    subtitle: const Text("Sem data de término"),
                    value: isContinuous,
                    onChanged: (v) => setState(() => isContinuous = v),
                    activeColor: const Color(0xFF4A90E2),
                    contentPadding: EdgeInsets.zero,
                  ),
                  if (!isContinuous) ...[
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Duração do tratamento:", style: TextStyle(fontWeight: FontWeight.w500)),
                        Row(
                          children: [
                            IconButton(onPressed: () => setState(() => durationDays > 1 ? durationDays-- : null), icon: const Icon(Icons.remove_circle_outline)),
                            Text("$durationDays dias", style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(onPressed: () => setState(() => durationDays++), icon: const Icon(Icons.add_circle_outline)),
                          ],
                        )
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // MÁGICA: Captura os dados e envia para a lista
                  final newMed = Medication(
                    name: nameController.text,
                    dosage: dosageController.text,
                    firstDose: selectedTime,
                    frequencyHours: frequencyHours,
                    stock: int.tryParse(stockController.text) ?? 0,
                    isContinuous: isContinuous,
                    durationDays: isContinuous ? null : durationDays,
                  );

                  widget.onSave(newMed); // Envia o remédio
                  Navigator.pop(context); // Fecha o popup
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A90E2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("Salvar Medicamento", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrequencyDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.black12)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: frequencyHours,
          isExpanded: true,
          items: [4, 6, 8, 12, 24].map((int val) => DropdownMenuItem(value: val, child: Text("$val em $val h"))).toList(),
          onChanged: (v) => setState(() => frequencyHours = v!),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, left: 4),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
  );

  Widget _buildTextField(String hint, IconData icon, TextEditingController controller, {bool isNumber = false}) => TextField(
    controller: controller,
    keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF4A90E2), size: 20),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.black12)),
    ),
  );

  Widget _buildSelectorTile({required String text, required IconData icon, required VoidCallback onTap}) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.black12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Icon(icon, color: const Color(0xFF4A90E2), size: 20),
        ],
      ),
    ),
  );
}