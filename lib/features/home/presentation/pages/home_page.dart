import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rgt/features/home/data/repositories/home_repository.dart';
import '../widgets/home_sections.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/action_icons.dart';
import '../widgets/home_header.dart';
import '../widgets/active_medications.dart';
import '../widgets/tracking_measures.dart';
import '../widgets/activities_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        repository: HomeRepository(),
      )..add(FetchHomeDataEvent()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HomeLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    spacing: 24,
                    children: [
                      HomeHeader(data: state.data),
                      ActionIcons(notificationCount: {
                        'reports': state.sectionData['reports']?.notificationCount ?? 0,
                        'tests': state.sectionData['tests']?.notificationCount ?? 0,
                        'medications': state.sectionData['medications']?.notificationCount ?? 0,
                        'medicalProfile': state.sectionData['medicalProfile']?.notificationCount ?? 0,
                        'visits': state.sectionData['visits']?.notificationCount ?? 0,
                        'wearables': state.sectionData['wearables']?.notificationCount ?? 0,
                      }),
                      PieChartScreen(activities: state.data.upcomingActivities),
                      HomeSections(sectionData: state.sectionData),
                      ActiveMedicationsSlider(medications: state.data.activeMedications),
                      TrackingMeasuresSlider(measures: state.data.trackingMeasures),
                    ],
                  ),
                );
              }
              if (state is HomeError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const SizedBox();
            },
          ),
        ),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }


  
  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'For You'),
        BottomNavigationBarItem(icon: Icon(Icons.grid_view,), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Reports'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: 0,
      onTap: (_) {},
    );
  }
}
