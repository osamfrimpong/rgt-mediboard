import 'notification_item.dart';

class SectionData {
  final List<NotificationItem> items;
  final int notificationCount;

  SectionData({
    required this.items,
    this.notificationCount = 0,
  });
}