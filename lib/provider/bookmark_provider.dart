import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/article.dart';

// StateNotifier to manage the list of bookmarked articles
class BookmarkNotifier extends StateNotifier<List<Article>> {
  BookmarkNotifier() : super([]);

  // Toggle bookmark status using URL-based comparison
  void toggleBookmark(Article article) {
    final index = state.indexWhere((a) => a.url == article.url);
    if (index >= 0) {
      // Remove article if already bookmarked
      final newState = [...state];
      newState.removeAt(index);
      state = newState;
    } else {
      // Add article if not bookmarked
      state = [...state, article];
    }
  }

  // Check if an article is bookmarked
  bool isBookmarked(Article article) {
    return state.any((a) => a.url == article.url);
  }

  // Clear all bookmarks
  void clearAll() {
    state = [];
  }
}

// Provider for the bookmark state notifier
final bookmarkProvider = StateNotifierProvider<BookmarkNotifier, List<Article>>(
  (ref) {
    return BookmarkNotifier();
  },
);
