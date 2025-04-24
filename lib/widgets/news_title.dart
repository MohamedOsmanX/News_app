// widgets/news_title.dart
import 'package:flutter/material.dart';
import '../models/article.dart';
import '../widgets/article_detailed_page.dart';
import '../widgets/news_card.dart';
import 'news_content.dart';

// Widget that displays a single news article in a card format
class NewsTitle extends StatelessWidget {
  final Article article;
  final bool isBookmarked;
  final VoidCallback onBookmarkToggle;

  const NewsTitle({
    super.key,
    required this.article,
    required this.isBookmarked,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, double opacity, child) {
        return Opacity(opacity: opacity, child: child);
      },
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailPage(article: article),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: NewsCard(
          article: article,
          // Override the default NewsContent with one that includes bookmark button
          contentBuilder:
              (context) => NewsContent(
                article: article,
                isBookmarked: isBookmarked,
                onBookmarkToggle: onBookmarkToggle,
              ),
        ),
      ),
    );
  }
}
