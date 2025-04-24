import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';
import '../config/api_config.dart';

// Service class responsible for fetching news data from the News API
class NewsService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  // API key is now imported from api_config.dart
  final String _apiKey = ApiConfig.newsApiKey;

  // Fetches top headlines based on country (defaults to 'us')
  // Returns a List of Article objects parsed from the API response
  Future<List<Article>> fetchTopHeadLines({String country = 'us'}) async {
    // Construct the API URL with parameters
    final response = await http.get(
      Uri.parse('$_baseUrl/top-headlines?country=$country&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articlesJson = data['articles'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
