import 'package:flutter/material.dart';
import 'expandable_section.dart';
import '../../data/models/section_data.dart';


class HomeSections extends StatelessWidget {
  const HomeSections({super.key, required this.sectionData});

  final Map<String, SectionData> sectionData;

  @override
  Widget build(BuildContext context) {
    return Padding( padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
      spacing: 8,
      children: [
        ExpandableSection(
          title: 'Medications',
          icon: Icons.medication,
          iconColor: Colors.orange,
          items: sectionData['medications']?.items ?? [],
          notificationCount: sectionData['medications']?.notificationCount ?? 0,
        ),
       
        ExpandableSection(
          title: 'Visits',
          icon: Icons.calendar_today,
          iconColor: Colors.cyan,
          items: sectionData['visits']?.items ?? [],
          notificationCount: sectionData['visits']?.notificationCount ?? 0,
        ),
        ExpandableSection(
          title: 'Tests',
          icon: Icons.science,
          iconColor: Colors.pink,
          items: sectionData['tests']?.items ?? [],
          notificationCount: sectionData['tests']?.notificationCount ?? 0,
        ),
      ],
    ));
  }
}