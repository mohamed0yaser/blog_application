import 'dart:io';

import 'package:blog_application/core/usecase/usecase.dart';
import 'package:blog_application/features/blog/domain/entities/blog.dart';
import 'package:blog_application/features/blog/domain/usecases/get_blogs.dart';
import 'package:blog_application/features/blog/domain/usecases/upload_blog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetBlogs _getBlogs;
  BlogBloc({
    required GetBlogs getBlogs,
    required UploadBlog uploadBlog,
  }) : _getBlogs = getBlogs,
    _uploadBlog = uploadBlog,
  super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });
    on<BlogUpload>(
      _onBlogUpload
    );
    on<BlogFetchBlogs>(
      _onBlogFetchBlogs
    );
  }

  void _onBlogFetchBlogs(BlogFetchBlogs event, Emitter<BlogState> emit) async {
    final result = await _getBlogs(NoParams());
    result.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogDisplaySuccess(blogs)),
    );
  }
  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
      final result = await _uploadBlog(
      UploadBlogParams(
      title: event.title,
      content: event.content,
      posterId: event.posterId,
      topics: event.topics,
      image: event.image,
    ));
    result.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogUploadSuccess()),
    );
  }
}
