import 'package:blog_application/features/blog/presentation/pages/add_new_blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Center(child: const Text("Blog Application")),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add_circled),
            onPressed: (){
              Navigator.push(context, AddNewBlogPage.route());
            },
          ),
        ],
      ) ,
    );
  }
}