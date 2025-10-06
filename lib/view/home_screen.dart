import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../models/category.dart';
import '../models/video_content.dart';
import 'helper_widgets/category_carousel.dart';
import 'helper_widgets/home_page_video.dart';
import 'helper_widgets/loading_widget.dart';
import '../utils/error_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingWidget(
              message: 'Loading content...',
              isFullScreen: true,
            );
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    ErrorHandler.getErrorMessage(state.error!),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(const LoadHomeDataEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(const LoadHomeDataEvent());
            },
            color: Colors.red,
            backgroundColor: Colors.black,
            child: CustomScrollView(
              slivers: [
                // App Bar
                SliverAppBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  pinned: true,
                  expandedHeight: 60,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Flick',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                      ),
                    ),
                    centerTitle: false,
                    titlePadding: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        // TODO: Implement search functionality
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // TODO: Implement profile functionality
                      },
                    ),
                  ],
                ),

                if (state.categories.isNotEmpty)
                  SliverToBoxAdapter(
                    child: HomePageVideo(
                      video: _getFeaturedVideo(state.categories),
                    ),
                  ),

                SliverToBoxAdapter(child: SizedBox(height: 20.h,)),

                // Categories
                ...state.categories.map((category) {
                  return SliverToBoxAdapter(
                    child: CategoryCarousel(category: category),
                  );
                }),

                // Bottom padding
                SliverToBoxAdapter(child: SizedBox(height: 100.h)),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Gets the first trending video as featured content
  VideoContent? _getFeaturedVideo(List<Category> categories) {
    for (final category in categories) {
      try {
        final trendingVideo = category.videos.firstWhereOrNull(
          (video) => video.isTrending,
        );
        return trendingVideo;
      } catch (e) {
        // No trending video found in this category, continue to next
        continue;
      }
    }

    // No trending video found in any category, return the first video
    return categories.first.videos.first;
  }
}
