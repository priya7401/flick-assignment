import 'package:flick_assignment/models/video_content.dart';

import '../../models/category.dart';

class HomeState {
  final List<Category> categories;
  final List<VideoContent> videos;
  final bool isLoading;
  final String? error;

  const HomeState({
    this.categories = const [],
    this.videos = const [],
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    List<Category>? categories,
    List<VideoContent>? videos,
    bool? isLoading,
    String? error,
  }) {  
    return HomeState(
      categories: categories ?? this.categories,
      videos: videos ?? this.videos,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
