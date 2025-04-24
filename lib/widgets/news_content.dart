import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/article.dart';

class NewsContent extends StatefulWidget {
  final Article article;
  final bool isBookmarked;
  final VoidCallback? onBookmarkToggle;

  const NewsContent({
    super.key,
    required this.article,
    this.isBookmarked = false,
    this.onBookmarkToggle,
  });

  @override
  State<NewsContent> createState() => _NewsContentState();
}

class _NewsContentState extends State<NewsContent> {
  // Track local bookmark state for immediate visual feedback
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();

    // Initialize local bookmark state
    _isBookmarked = widget.isBookmarked;
  }

  @override
  void didUpdateWidget(NewsContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update local state when parent widget changes
    _isBookmarked = widget.isBookmarked;
  }

  // Handle bookmark toggle with immediate feedback
  void _handleBookmarkToggle() {
    if (widget.onBookmarkToggle != null) {
      // Update local state immediately for visual feedback
      setState(() {
        _isBookmarked = !_isBookmarked;
      });
      // Call the parent's callback
      widget.onBookmarkToggle!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.article.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  DateFormat.yMMMMd().format(widget.article.publishedAt),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          if (widget.onBookmarkToggle != null)
            IconButton(
              icon: Icon(
                _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                color:
                    _isBookmarked
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                size: 28,
              ),
              onPressed: _handleBookmarkToggle,
              splashRadius: 24,
            ),
        ],
      ),
    );
  }
}
