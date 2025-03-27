import 'package:blog_application/core/utils/calculate_reading_time.dart';
import 'package:blog_application/features/blog/domain/entities/blog.dart';
import 'package:blog_application/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16).copyWith(bottom: 0),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        blog.topics
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Chip(label: Text(e)),
                              ),
                            )
                            .toList(),
                  ),
                ),
                Text(
              blog.title,
              style: const TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                ),
            ),],
            ),
            Text(
              '${calculateReadingTime(blog.content)} min read',
            ),
          ],
        ),
      ),
    );
  }
}
