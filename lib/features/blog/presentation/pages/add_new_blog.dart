import 'dart:io';

import 'package:blog_application/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_application/core/common/widgets/loader.dart';
import 'package:blog_application/core/theme/pallete.dart';
import 'package:blog_application/core/utils/pick_image.dart';
import 'package:blog_application/core/utils/show_snackbar.dart';
import 'package:blog_application/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_application/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_application/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState != null) {
      bool isValid = formKey.currentState!.validate();
      if (isValid &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
                BlogUpload(
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          topics: selectedTopics,
          image: image!,
          posterId: posterId,
        ),
      );
    }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.done_rounded),
            onPressed: uploadBlog,
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure){
            showSnackBar(context, state.message);
          }else if (state is BlogUploadSuccess){
            Navigator.pushAndRemoveUntil(context, BlogPage.route(), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }else{
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                          onTap: () {
                            selectImage();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              image!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                        : GestureDetector(
                          onTap: () {
                            selectImage();
                          },
                          child: DottedBorder(
                            color: Pallete.borderColor,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(12),
                            dashPattern: [10, 5],
                            strokeCap: StrokeCap.round,
                            // ignore: sized_box_for_whitespace
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.folder_open_rounded, size: 50),
                                  SizedBox(height: 15),
                                  Text(
                                    "Select your image",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    SizedBox(height: 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            [
                                  'Nature',
                                  'Technology',
                                  'Food',
                                  'Travel',
                                  'Fashion',
                                  'Music',
                                  'Sports',
                                  'Education',
                                  'Health',
                                  'Lifestyle',
                                  'Business',
                                  'Art',
                                  'Science',
                                  'Politics',
                                  'Religion',
                                  'History',
                                  'Entertainment',
                                  'Others',
                                ]
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedTopics.contains(e)) {
                                          selectedTopics.remove(e);
                                        } else {
                                          selectedTopics.add(e);
                                        }
                                        setState(() {});
                                      },
                                      child: Chip(
                                        color:
                                            selectedTopics.contains(e)
                                                ? WidgetStatePropertyAll(
                                                  Pallete.gradient1,
                                                )
                                                : WidgetStatePropertyAll(
                                                  Pallete.backgroundColor,
                                                ),
                                        label: Text(e),
                                        side:
                                            selectedTopics.contains(e)
                                                ? null
                                                : BorderSide(
                                                  color: Pallete.borderColor,
                                                ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    SizedBox(height: 15),
                    BlogEditor(
                      controller: titleController,
                      hintText: 'Blog Title',
                    ),
                    SizedBox(height: 15),
                    BlogEditor(
                      controller: contentController,
                      hintText: 'Blog Content',
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        }
      ),
    );
  }
}
