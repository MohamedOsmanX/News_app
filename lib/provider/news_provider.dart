import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/article.dart';
import '../services/news_service.dart';

// Provider that creates and exposes a NewsService instance to the app

final newsServiceProvider = Provider<NewsService>((ref) => NewsService());

// AsyncNotifier to handle the async loading of articles
class NewsNotifier extends AsyncNotifier<List<Article>> {
  @override
  Future<List<Article>> build() async {
    // Initial loading of articles
    return fetchArticles();
  }

  // Method to fetch or refresh articles
  Future<List<Article>> fetchArticles() async {
    final newsService = ref.read(newsServiceProvider);
    return await newsService.fetchTopHeadLines();
  }

  // Public method to refresh articles
  Future<void> refreshArticles() async {
    // Set state to loading before fetching
    state = const AsyncValue.loading();
    // Fetch and update state
    state = await AsyncValue.guard(() => fetchArticles());
  }
}

// Provider for the news notifier
final newsProvider = AsyncNotifierProvider<NewsNotifier, List<Article>>(() {
  return NewsNotifier();
});
