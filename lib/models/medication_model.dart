enum Frequency { daily, weekly, interval }

class Medication {
  final String id;
  final String name;
  final String dosage;
  final DateTime time;
  final Frequency frequency;
  final int totalPills;
  final int remainingPills;
  final bool isTaken; // Novo: para o checklist do dashboard

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.time,
    required this.frequency,
    this.totalPills = 0,
    this.remainingPills = 0,
    this.isTaken = false,
  });
}
