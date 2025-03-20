import 'dart:io';

import 'package:blog_application/core/theme/pallete.dart';
import 'package:blog_application/core/utils/pick_image.dart';
import 'package:blog_application/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List< String> selectedTopics = [];
  File? image;
  void selectImage()async{
    final pickedImage = await pickImage();
    if(pickedImage != null){
      setState(() {
        image = pickedImage;
      });
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
          IconButton(icon: const Icon(Icons.done_rounded), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                  :
              GestureDetector(
                onTap: (){
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
                        Text("Select your image", style: TextStyle(fontSize: 15)),
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
                                  color: selectedTopics.contains(e)
                                      ? WidgetStatePropertyAll(Pallete.gradient1,)
                                      : WidgetStatePropertyAll(Pallete.backgroundColor),
                                  label: Text(e),
                                  side: selectedTopics.contains(e)
                                      ?null
                                      :BorderSide(
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
              BlogEditor(controller: titleController, hintText: 'Blog Title'),
              SizedBox(height: 15),
              BlogEditor(controller: contentController, hintText: 'Blog Content'),
            ],
          ),
        ),
      ),
    );
  }
}
