class MedicalData {
  final String userName;
  final List<Medication> activeMedications;
  final List<TrackingMeasure> trackingMeasures;
  final List<String> upcomingActivities;
  final bool hasNewVisits;
  final bool hasNewTests;
  final bool hasUnreadNotifications;
  final bool hasUpcomingAppointment;
  final int daysUntilNextAppointment;

  MedicalData({
    required this.userName,
    required this.activeMedications,
    required this.trackingMeasures,
    required this.upcomingActivities,
    this.hasNewVisits = false,
    this.hasNewTests = false,
    this.hasUnreadNotifications = false,
    this.hasUpcomingAppointment = false,
    this.daysUntilNextAppointment = 0,
  });
}

class Medication {
  final String name;
  final String dosage;
  final String frequency;
  final DateTime? lastRenewed;
  final String? referredBy;
  final String? diagnosis;

  Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    this.lastRenewed,
    this.referredBy,
    this.diagnosis,
  });
}

class TrackingMeasure {
  final String name;
  final double value;
  final String unit;
  final String rating;
  final DateTime date;
  final String type;
  final double extraValue;
  final String provider;

  TrackingMeasure({
    required this.name,
    required this.value,
    required this.unit,
    required this.rating,
    required this.date,
    required this.type,
    required this.extraValue,
    required this.provider,
  });
}
