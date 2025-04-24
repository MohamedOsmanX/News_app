import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/news_title.dart';
import '../provider/bookmark_provider.dart';

// Screen that manages and displays bookmarked articles
class BookmarkManager extends ConsumerWidget {
  const BookmarkManager({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the list of bookmarked articles from the provider
    final bookmarks = ref.watch(bookmarkProvider);
    // Get the bookmark notifier to toggle bookmarks
    final bookmarkNotifier = ref.watch(bookmarkProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        actions: [
          if (bookmarks.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Clear all bookmarks',
              onPressed: () {
                // Show confirmation dialog
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Clear Bookmarks'),
                        content: const Text(
                          'Are you sure you want to remove all bookmarks?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('CANCEL'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Clear all bookmarks and close dialog
                              ref.read(bookmarkProvider.notifier).clearAll();
                              Navigator.pop(context);
                            },
                            child: const Text('CLEAR ALL'),
                          ),
                        ],
                      ),
                );
              },
            ),
        ],
      ),
      body:
          bookmarks.isEmpty
              // Display a message when no bookmarks exist
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.bookmark_outline,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No bookmarks added yet',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tap the bookmark icon on news articles to save them here',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              )
              // Display the list of bookmarked articles
              : ListView.builder(
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final article = bookmarks[index];
                  // Use the same NewsTitle widget that's used in NewsScreen,
                  // but always set isBookmarked to true
                  return NewsTitle(
                    article: article,
                    isBookmarked: true,
                    onBookmarkToggle:
                        () => bookmarkNotifier.toggleBookmark(article),
                  );
                },
              ),
    );
  }
}
