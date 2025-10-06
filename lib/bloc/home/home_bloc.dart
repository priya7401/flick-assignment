import 'package:bloc/bloc.dart';
import '../../services/data_service.dart';
import 'home_event.dart';
import 'home_state.dart';

/// BLoC for managing home screen state
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DataService _dataService;

  HomeBloc({required DataService dataService})
      : _dataService = dataService,
        super(const HomeState()) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
  }

  /// Handles loading home page data
  Future<void> _onLoadHomeData(
    LoadHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final categories = await _dataService.getCategories();
      final videos = await _dataService.getAllVideos();
      emit(state.copyWith(
        categories: categories,
        isLoading: false,
        error: null,
        videos: videos,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load content: ${e.toString()}',
      ));
    }
  }
}
