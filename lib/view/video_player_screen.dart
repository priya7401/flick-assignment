import 'package:flick_assignment/bloc/home/home_bloc.dart';
import 'package:flick_assignment/bloc/home/home_state.dart';
import 'package:flick_assignment/models/video_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_player_page.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String? initialVideoId; // first video to play

  const VideoPlayerScreen({super.key, this.initialVideoId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.videos.isEmpty) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: const Center(
              child: Text(
                'No videos available',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Colors.black,
          body: PageView.builder(
            scrollDirection: Axis.vertical,
            controller: PageController(initialPage: _getInitialIndex(state.videos, initialVideoId)),
            itemCount: state.videos.length,
            itemBuilder: (context, index) {
              return VideoPlayerPage(video: state.videos[index]);
            },
          ),
        );
      },
    );
  }

  int _getInitialIndex(List<VideoContent> videos, String? initialVideoId) {
    int initialIdx = videos.indexWhere((video) => video.id == initialVideoId);
    // if the current video id is not found, return the first video
    return initialIdx != -1 ? initialIdx : 0;
  }
}
