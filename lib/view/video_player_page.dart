import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import '../models/video_content.dart';

class VideoPlayerPage extends StatefulWidget {
  final VideoContent video;

  const VideoPlayerPage({super.key, required this.video});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void didUpdateWidget(VideoPlayerPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update player state when video changes
    if (oldWidget.video.id != widget.video.id) {
      _initializePlayer();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  /// Initializes the video player controller
  Future<void> _initializePlayer() async {
    _controller?.dispose();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.videoUrl),
    );

    await _controller?.initialize();

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });

      _controller?.play();
    }
  }

  void _togglePlayPause() {
    if (_controller != null) {
      if (_controller?.value.isPlaying ?? false) {
        _controller?.pause();
      } else {
        _controller?.play();
      }
      setState(() {});
    }
  }

  /// Builds the video player widget with proper aspect ratio handling
  Widget _buildVideoPlayer(BuildContext context) {
    if (_controller == null) return Container();

    final videoAspectRatio = _controller!.value.aspectRatio;
    final screenSize = MediaQuery.of(context).size;

    // Determine if video is landscape or portrait
    final isLandscapeVideo = videoAspectRatio > 1.0;
    final isPortraitVideo = videoAspectRatio <= 1.0;

    if (isLandscapeVideo) {
      // For landscape videos: center them and maintain aspect ratio
      return Center(
        child: AspectRatio(
          aspectRatio: videoAspectRatio,
          child: VideoPlayer(_controller!),
        ),
      );
    } else if (isPortraitVideo) {
      // For portrait videos: fill the screen
      return FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: VideoPlayer(_controller!),
        ),
      );
    } else {
      // Square videos: center them
      return Center(
        child: AspectRatio(
          aspectRatio: videoAspectRatio,
          child: VideoPlayer(_controller!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Video player
        Positioned.fill(
          child: _isInitialized && _controller != null
              ? _buildVideoPlayer(context)
              : Container(
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                ),
        ),

        _buildTopControls(),

        if (_isInitialized && _controller != null)
          Center(
            child: GestureDetector(
              onTap: _togglePlayPause,
              child: Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _controller?.value.isPlaying == true
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),

        Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomControls()),
      ],
    );
  }

  Widget _buildTopControls() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BackButton(),
            const Spacer(),

            GestureDetector(
              onTap: () {
                // TODO: Implement more options
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Video title
            Text(
              widget.video.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8),

            // Video description
            Text(
              widget.video.description,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                // Like button
                _buildActionButton(
                  icon: Icons.thumb_up_outlined,
                  label: 'Like',
                  onTap: () {
                    // TODO: Implement like functionality
                  },
                ),

                const SizedBox(width: 24),

                // Dislike button
                _buildActionButton(
                  icon: Icons.thumb_down_outlined,
                  label: 'Dislike',
                  onTap: () {
                    // TODO: Implement dislike functionality
                  },
                ),

                const SizedBox(width: 24),

                // Share button
                _buildActionButton(
                  icon: Icons.share,
                  label: 'Share',
                  onTap: () {
                    // TODO: Implement share functionality
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
