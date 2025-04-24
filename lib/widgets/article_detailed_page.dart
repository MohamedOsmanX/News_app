import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';
import '../provider/bookmark_provider.dart';

// Screen that displays a detailed view of a selected article
class ArticleDetailPage extends ConsumerStatefulWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  ConsumerState<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends ConsumerState<ArticleDetailPage> {
  // Track local bookmark state for immediate visual feedback
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    // Initial state will be set in the build method
    _isBookmarked = false;
  }

  // Launch the article URL in an in-app browser
  void _launchURL(BuildContext context) async {
    try {
      final Uri url = Uri.parse(widget.article.url);
      if (!await launchUrl(
        url,
        mode: LaunchMode.inAppWebView, // Use in-app browser for better UX
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      )) {
        // Show error message if URL launch fails
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open the article")),
        );
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  // Handle bookmark toggle with immediate feedback
  void _handleBookmarkToggle() {
    // Toggle local state immediately for visual feedback
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    // Update actual state in provider
    ref.read(bookmarkProvider.notifier).toggleBookmark(widget.article);
  }

  @override
  Widget build(BuildContext context) {
    // Get bookmark state from provider
    final bookmarkNotifier = ref.watch(bookmarkProvider.notifier);
    _isBookmarked = bookmarkNotifier.isBookmarked(widget.article);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Article Detail"),
        actions: [
          // Simple bookmark button with immediate feedback
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
              color:
                  _isBookmarked ? Theme.of(context).colorScheme.primary : null,
              size: 28,
            ),
            onPressed: _handleBookmarkToggle,
          ),
        ],
      ),
      // Use SingleChildScrollView to allow scrolling if content is too long
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display article image if available, using Hero animation
            if (widget.article.urlToImage.isNotEmpty)
              Hero(
                tag:
                    widget
                        .article
                        .urlToImage, // Same tag as in the list view for smooth transition
                child: Image.network(
                  widget.article.urlToImage,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article title in larger font
                  Text(
                    widget.article.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Publication date
                  Text(
                    DateFormat.yMMMMd().format(widget.article.publishedAt),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  // Article description or fallback message
                  Text(
                    widget.article.description.isNotEmpty
                        ? widget.article.description
                        : 'No description available.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  // Button to open full article in browser
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => _launchURL(context),
                      icon: const Icon(Icons.open_in_browser),
                      label: const Text("Read Full Article"),
                    ),
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
