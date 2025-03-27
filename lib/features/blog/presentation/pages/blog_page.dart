import 'package:blog_application/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_application/core/common/widgets/loader.dart';
import 'package:blog_application/core/theme/pallete.dart';
import 'package:blog_application/core/utils/show_snackbar.dart';
import 'package:blog_application/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_application/features/blog/presentation/pages/add_new_blog.dart';
import 'package:blog_application/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchBlogs());
  }

  @override
  Widget build(BuildContext context) {
    final userName =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.name;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Welcome $userName')),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add_circled),
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogDisplaySuccess){
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(
                  blog: blog, 
                  color: index %3 ==0 ? Pallete.gradient1
                  : index %3 ==1 ? Pallete.gradient2
                  : Pallete.gradient3,
                  );
              }, 
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
