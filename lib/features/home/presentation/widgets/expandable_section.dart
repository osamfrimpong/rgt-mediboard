import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rgt/core/shared/widgets/elevated_button.dart';
import '../../data/models/notification_item.dart';

class ExpandableSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<NotificationItem> items;
  final int notificationCount;

  const ExpandableSection({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.items,
    required this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ExpansionTile(
          collapsedShape: RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          leading: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(icon, color: Colors.white, size: 16),
          ),
          title: Text(title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (notificationCount > 0)
                CircleAvatar(
                  backgroundColor: iconColor,
                  radius: 10,
                  child: Text(
                    notificationCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const Icon(Icons.expand_more),
            ],
          ),
          children:
              items.map((item) => _buildNotificationItem(item, title)).toList(),
        ));
  }

  Widget _buildNotificationItem(NotificationItem item, String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(color: Colors.grey[300]!),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          if (item.highPriority)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'High Priority',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...switch (title) {
            'Visits' => [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Visited at '),
                      TextSpan(
                        text: DateFormat('MMM dd, yyyy').format(item.date),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text("Doctor"),
                    Text(item.referredBy ?? ''),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Visit Type"),
                    Text(item.visitType ?? ''),
                  ],
                ),
              ],
            'Tests' => [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Conducted on '),
                      TextSpan(
                        text: DateFormat('MMM dd, yyyy').format(item.date),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' at ${item.location}'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Referred by"),
                    Text(item.referredBy ?? ''),
                  ],
                ),
              ],
            'Medications' => [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Last renewed at '),
                      TextSpan(text: DateFormat('MMM dd, yyyy').format(item.date), style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Referred by"),
                    Text(item.referredBy ?? ''),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Diagnosis"),
                    Text(item.diagnosis ?? ''),
                  ],
                ),
              ],
            _ => <Widget>[] 
          },
          CustomElevatedButton(
            text: _getActionButtonText(title),
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: () => {},
            fullWidth: true,
          )
        ],
      ),
    );
  }

  String _getActionButtonText(String section) {
    switch (section) {
      case 'Medications':
        return 'Renew';
      case 'Tests':
        return 'Upload Results';
      case 'Visits':
        return 'View Details';
      default:
        return 'View';
    }
  }
}
