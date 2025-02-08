import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc({required this.repository}) : super(HomeInitial()){
    on<FetchHomeDataEvent>(_onFetchHomeData);
  }

  void _onFetchHomeData(FetchHomeDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final medicalData = await repository.fetchMedicalData();
      final sectionData = await repository.fetchSectionData();
      emit(HomeLoaded(data: medicalData, sectionData: sectionData));
    } catch (e) {
        emit(HomeError(message: e.toString()));
    }
  }
}

