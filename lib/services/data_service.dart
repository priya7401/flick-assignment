import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/category.dart';
import '../models/video_content.dart';

/// Service class for handling data operations
/// Handles loading and parsing of mock JSON data
class DataService {
  static const String _mockDataPath = 'assets/data/mock_data.json';

  /// Loads categories from the mock JSON file
  /// Returns a list of Category objects with their associated videos
  Future<List<Category>> getCategories() async {
    try {
      final String jsonString = await rootBundle.loadString(_mockDataPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      final List<dynamic> categoriesJson = jsonData['categories'] as List<dynamic>;
      
      return categoriesJson
          .map((categoryJson) => Category.fromJson(categoryJson as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  /// Gets all videos from all categories as a flat list
  Future<List<VideoContent>> getAllVideos() async {
    try {
      final categories = await getCategories();
      final List<VideoContent> allVideos = [];
      
      for (final category in categories) {
        allVideos.addAll(category.videos);
      }
      
      return allVideos;
    } catch (e) {
      throw Exception('Failed to load videos: $e');
    }
  }
}
