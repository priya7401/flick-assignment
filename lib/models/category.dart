import 'video_content.dart';

class Category {
  final String id;
  final String name;
  final List<VideoContent> videos;

  const Category({
    required this.id,
    required this.name,
    required this.videos,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      videos: (json['videos'] as List<dynamic>)
          .map((videoJson) => VideoContent.fromJson(videoJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'videos': videos.map((video) => video.toJson()).toList(),
    };
  }
}
