

import '../../data/models/medical_data.dart';
import '../../data/models/section_data.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final MedicalData data;
  final Map<String, SectionData> sectionData;

  HomeLoaded({required this.data, required this.sectionData});
}


class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}

