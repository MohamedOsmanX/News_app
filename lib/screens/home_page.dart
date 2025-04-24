import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'news_screen.dart';
import 'bookmark_manager.dart';
import '../provider/navigation_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current tab index from the provider
    final selectedIndex = ref.watch(navigationProvider);

    // List of screens to display based on selected tab
    final pages = [
      // News tab - displays fetched articles
      const NewsScreen(),
      // Bookmarks tab - displays saved articles
      const BookmarkManager(),
    ];

    return Scaffold(
      // Display the selected page based on the current tab index
      body: pages[selectedIndex],
      // Bottom navigation bar with News and Bookmarks tabs
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        // Update the selected tab using the provider
        onTap: (index) => ref.read(navigationProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
        ],
      ),
    );
  }
}
