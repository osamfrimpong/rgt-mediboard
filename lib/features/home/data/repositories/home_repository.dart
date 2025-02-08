

import '../models/medical_data.dart';
import '../models/notification_item.dart';
import '../models/section_data.dart';

class HomeRepository {
  Future<Map<String, SectionData>> fetchSectionData() async {
 
    await Future.delayed(const Duration(seconds: 1));

    return {
      'medications': SectionData(
        notificationCount: 1,
        items: [
          NotificationItem(
            title: 'Your subscription to Creon is about to expire',
            date: DateTime(2022, 12, 28),
            referredBy: 'Dr. Boaz',
            highPriority: true,
            diagnosis: 'Food digestion',
          ),
        ],
      ),
      'visits': SectionData(
        notificationCount: 1,
        items: [
          NotificationItem(
            title: 'Your visit to Dr. David Q. Cochran is coming soon',
            date: DateTime(2023, 3, 15),
            referredBy: 'Dr. David Q. Cochran',
            visitType: 'Follow Up',
          ),
        ],
      ),
      'tests': SectionData(
        notificationCount: 1,
        items: [
          NotificationItem(
            title: 'Upload your Blood test results',
            date: DateTime(2023, 2, 27),
            location: 'Assuta Medical Center',
            referredBy: 'Dr. David Q. Cochran',
            highPriority: true,
          ),
        ],
      ),
      'reports': SectionData(
        notificationCount: 0,
        items: [],
      ),
      'wearables': SectionData(
        notificationCount: 0,
        items: [],
      ),
      'medicalProfile': SectionData(
        notificationCount: 0,
        items: [],
      ),
    };
  }
 Future<MedicalData> fetchMedicalData() async {
   
    await Future.delayed(const Duration(seconds: 1));
    
    return MedicalData(
      userName: 'Shmuel',
      activeMedications: [
        Medication(
          name: 'ENTRESTO',
          dosage: '100 mg',
          frequency: '2/day',
        ),
        Medication(
          name: 'Spironolactone',
          dosage: '25mg',
          frequency: '1/day',
        ),
        Medication(
          name: 'Creon',
          dosage: '1g',
          frequency: '3/day',
          lastRenewed: DateTime(2022, 12, 28),
          referredBy: 'Dr. Boaz',
          diagnosis: 'Food digestion',
        ),
      ],
      trackingMeasures: [
        TrackingMeasure(
          name: 'B12',
          value: 173,
          unit: 'pg/ml',
          date: DateTime(2023, 2, 15),
          rating: 'Off Track',
          type: 'Range',
          extraValue: 0,
          provider: 'Last test result: 173 pg/ml (90 days ago)',
        ),
        TrackingMeasure(
          name: 'Glucose levels',
          value: 154,
          unit: 'mg/dL',
          rating: 'Good',
          date: DateTime(2023, 2, 15),
          type: 'Fixed',
          extraValue: 1,
          provider: 'Oura',
        ),
        TrackingMeasure(
          name: 'Sleep Score',
          value: 75,
          unit: '%',
          rating: 'Good',
          date: DateTime(2023, 2, 15),
          type: 'Fixed',
          extraValue: 1,
          provider: 'Oura',
        ),
        TrackingMeasure(
          name: 'Avg. Heart Rate',
          value: 75,
          unit: 'bpm',
          rating: 'Good',
          date: DateTime(2023, 2, 15),
          type: 'Fixed',
          extraValue: 0,
          provider: 'Oura',
        ),
      ],
      upcomingActivities: ['Activity 1', 'Activity 2', 'Activity 3'],
      hasNewVisits: true,
      hasNewTests: true,
    );
  }
}