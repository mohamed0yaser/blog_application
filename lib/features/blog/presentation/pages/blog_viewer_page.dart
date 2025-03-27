import 'package:blog_application/core/theme/pallete.dart';
import 'package:blog_application/core/utils/calculate_reading_time.dart';
import 'package:blog_application/core/utils/formate_date.dart';
import 'package:blog_application/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  final Blog blog;
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'By ${blog.postername}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  '${formateDateBydMMMYYYY(blog.updateddAt)} . ${calculateReadingTime(blog.content)} min read',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Pallete.greyColor,
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    blog.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                Text(
                  blog.content,
                  style: const TextStyle(fontSize: 16,height: 2),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
