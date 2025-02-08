import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class ActionIcons extends StatelessWidget {
  final Map<String, int> notificationCount;
  
  const ActionIcons({super.key, required this.notificationCount});
  
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 32,
            crossAxisSpacing: 32,
            childAspectRatio: 1,
            children: [
              _buildDashboardItem(
                icon: Icons.calendar_today,
                label: 'Visits',
                color: Colors.cyan,
                notifications: notificationCount['visits']!,
              ),
              _buildDashboardItem(
                icon: Icons.bar_chart,
                label: 'Reports',
                color: Colors.purple,
                notifications: notificationCount['reports']!,
              ),
              _buildDashboardItem(
                icon: Icons.medical_services_outlined,
                label: 'Medical Profile',
                color: Colors.cyan,
                notifications: notificationCount['medicalProfile']!,
              ),
              _buildDashboardItem(
                icon: Icons.medication_outlined,
                label: 'Medications',
                color: Colors.amber,
                notifications: notificationCount['medications']!,
              ),
              _buildDashboardItem(
                icon: Icons.science,
                label: 'Tests',
                color: Colors.pink,
                notifications: notificationCount['tests']!,
              ),
              _buildDashboardItem(
                icon: Icons.watch,
                label: 'Wearables',
                color: Colors.deepPurple,
                notifications: notificationCount['wearables']!,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem({
    required IconData icon,
    required String label,
    required Color color,
    int notifications = 0,
  }) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              badges.Badge(
                showBadge: notifications > 0,
                badgeStyle: badges.BadgeStyle(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  padding: EdgeInsets.all(7),
                ),
                onTap: () {},
                badgeContent: Text(
                  '$notifications',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                child: Container(
                  padding: EdgeInsets.all(12),
                  
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[350]!, 
                        offset: const Offset(2, 2),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                    
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
