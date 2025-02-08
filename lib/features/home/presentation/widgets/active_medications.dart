import 'package:flutter/material.dart';
import '../../data/models/medical_data.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ActiveMedicationsSlider extends StatefulWidget {
  final List<Medication> medications;

  const ActiveMedicationsSlider({
    super.key,
    required this.medications,
  });

  @override
  State<ActiveMedicationsSlider> createState() =>
      _ActiveMedicationsSliderState();
}

class _ActiveMedicationsSliderState extends State<ActiveMedicationsSlider> {
  final PageController _pageController =
      PageController(viewportFraction: 0.65, initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.toInt() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Active medications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: PageView.builder(
            padEnds: false,
            controller: _pageController,
            itemCount: widget.medications.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: MedicationCard(
                  medication: widget.medications[index],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        DotsIndicator(
          dotsCount: widget.medications.length,
          position: _currentPage,
          decorator: DotsDecorator(
            activeColor: Colors.deepPurple,
            size: const Size.square(8.0),
            activeSize: const Size.square(8.0),
            spacing: const EdgeInsets.all(4),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class MedicationCard extends StatelessWidget {
  final Medication medication;

  const MedicationCard({
    super.key,
    required this.medication,
  });

  @override
  Widget build(BuildContext context) {
    final medicationTimes =
        FrequencyParser.getTimesFromFrequency(medication.frequency);

    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${medication.name}, ${medication.dosage}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              medication.frequency,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
           
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIcon(
                  Icons.wb_sunny_outlined,
                  isActive: medicationTimes.contains(MedicationTime.morning),
                ),
                const SizedBox(width: 16),
                _buildIcon(
                  Icons.wb_sunny,
                  isActive: medicationTimes.contains(MedicationTime.afternoon),
                ),
                const SizedBox(width: 16),
                _buildIcon(
                  Icons.nightlight_outlined,
                  isActive: medicationTimes.contains(MedicationTime.evening),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isActive ? Colors.deepPurple[50] : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: isActive ? Colors.deepPurple : Colors.grey,
        size: 20,
      ),
    );
  }
}

enum MedicationTime { morning, afternoon, evening }

class FrequencyParser {
  static Set<MedicationTime> getTimesFromFrequency(String frequency) {
    final times = frequency.split('/').first;
    final timesPerDay = int.tryParse(times) ?? 0;

    switch (timesPerDay) {
      case 1:
        return {MedicationTime.morning};
      case 2:
        return {MedicationTime.morning, MedicationTime.evening};
      case 3:
        return {
          MedicationTime.morning,
          MedicationTime.afternoon,
          MedicationTime.evening
        };
      default:
        return {};
    }
  }
}
