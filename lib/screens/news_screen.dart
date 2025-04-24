// screens/news_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/news_title.dart';
import '../provider/news_provider.dart';
import '../provider/bookmark_provider.dart';

// Screen that displays the list of news articles
class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the news provider to get the article loading state
    final articlesAsync = ref.watch(newsProvider);
    // Get the bookmark notifier to handle bookmarks
    final bookmarkNotifier = ref.watch(bookmarkProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("News")),
      body: articlesAsync.when(
        // Show loading indicator while fetching data
        loading: () => const Center(child: CircularProgressIndicator()),

        // Show error message and retry button if fetch failed
        error:
            (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Failed to load news: $error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        () => ref.read(newsProvider.notifier).refreshArticles(),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),

        // Show the news list with articles
        data:
            (articles) =>
                articles.isEmpty
                    ? const Center(child: Text('No articles found'))
                    : RefreshIndicator(
                      onRefresh:
                          () =>
                              ref.read(newsProvider.notifier).refreshArticles(),
                      child: ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          final isBookmarked = bookmarkNotifier.isBookmarked(
                            article,
                          );
                          // Use NewsTitle widget to display each article
                          return NewsTitle(
                            article: article,
                            isBookmarked: isBookmarked,
                            onBookmarkToggle:
                                () => bookmarkNotifier.toggleBookmark(article),
                          );
                        },
                      ),
                    ),
      ),
    );
  }
}
