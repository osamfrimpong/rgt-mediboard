class NotificationItem {
  final String title;
  final String? subtitle;
  final DateTime date;
  final String? location;
  final String? visitType;
  final bool highPriority;
  final String? referredBy;
  final String? diagnosis;
  
  NotificationItem({
    required this.title,
    this.subtitle,
    required this.date,
    this.location,
    this.visitType,
    this.highPriority = false,
    this.referredBy,
    this.diagnosis,
  });
}