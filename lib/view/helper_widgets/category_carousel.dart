import 'package:flick_assignment/view/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/category.dart';
import '../../models/video_content.dart';
import 'loading_widget.dart';

class CategoryCarousel extends StatelessWidget {
  final Category category;

  const CategoryCarousel({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Text(
            category.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Horizontal scrollable video list
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            itemCount: category.videos.length,
            itemBuilder: (context, index) {
              final video = category.videos[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: VideoThumbnail(
                  video: video,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            VideoPlayerScreen(initialVideoId: video.id),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}

class VideoThumbnail extends StatelessWidget {
  final VideoContent video;
  final VoidCallback onTap;

  const VideoThumbnail({super.key, required this.video, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 140.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail image
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              child: CachedNetworkImage(
                imageUrl: video.thumbnailUrl,
                fit: BoxFit.cover,
                width: 250.h,
                height: 150.h,
                placeholder: (context, url) => const ThumbnailLoadingWidget(),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[900],
                  child: const Icon(
                    Icons.error,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    video.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
            
                  SizedBox(height: 2.h),
            
                  // Meta info
                  Row(
                    children: [
                      Text(
                        '${video.year}',
                        style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '•',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        video.rating,
                        style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
