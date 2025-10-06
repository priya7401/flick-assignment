class VideoContent {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  final int duration;
  final String category;
  final int year;
  final String rating;
  final bool isTrending;

  const VideoContent({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.duration,
    required this.category,
    required this.year,
    required this.rating,
    this.isTrending = false,
  });

  factory VideoContent.fromJson(Map<String, dynamic> json) {
    return VideoContent(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      videoUrl: json['videoUrl'] as String,
      duration: json['duration'] as int,
      category: json['category'] as String,
      year: json['year'] as int,
      rating: json['rating'] as String,
      isTrending: json['isTrending'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'duration': duration,
      'category': category,
      'year': year,
      'rating': rating,
      'isTrending': isTrending,
    };
  }
}
