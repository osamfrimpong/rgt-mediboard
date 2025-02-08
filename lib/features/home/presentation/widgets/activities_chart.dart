import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartScreen extends StatelessWidget {
  const PieChartScreen({super.key, required this.activities});
  final List<String> activities;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          height: 250,
          width: 250,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 3,
                  centerSpaceRadius: 100, 
                  sections: [
                    PieChartSectionData(
                      color: Colors.cyan,
                      value: 33,
                      radius: 25,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      color: Colors.amber,
                      value: 33,
                      radius: 25,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      color: Colors.pink,
                      value: 33,
                      radius: 25,
                      showTitle: false,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Upcoming",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  Text(
                    "${activities.length} Activities",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
  
    );
  }
}