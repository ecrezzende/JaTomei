import 'package:flutter/material.dart';

class Medication {
  final String name;
  final String dosage;
  final TimeOfDay firstDose;
  final int frequencyHours;
  final int? durationDays; // Pode ser nulo se for uso contínuo
  final int stock;
  final bool isContinuous;

  Medication({
    required this.name,
    required this.dosage,
    required this.firstDose,
    required this.frequencyHours,
    this.durationDays,
    required this.stock,
    required this.isContinuous,
  });
}