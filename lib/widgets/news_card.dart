import 'package:flutter/material.dart';
import '../models/article.dart';
import 'news_image.dart';
import 'news_content.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  final Widget Function(BuildContext)? contentBuilder;

  const NewsCard({super.key, required this.article, this.contentBuilder});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.urlToImage.isNotEmpty)
            NewsImage(imageUrl: article.urlToImage),
          // Use custom content if provided, otherwise use default NewsContent
          contentBuilder != null
              ? contentBuilder!(context)
              : NewsContent(article: article),
        ],
      ),
    );
  }
}
