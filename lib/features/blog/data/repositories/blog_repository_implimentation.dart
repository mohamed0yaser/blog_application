// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import 'package:blog_application/core/error/exceptions.dart';
import 'package:blog_application/core/error/failures.dart';
import 'package:blog_application/core/network/connection_chacker.dart';
import 'package:blog_application/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_application/features/blog/data/models/blog_model.dart';
import 'package:blog_application/features/blog/domain/entities/blog.dart';
import 'package:blog_application/features/blog/domain/repositories/blog_repository.dart';

class BlogRepositoryImplimentation implements BlogRepository {
  final BlogRemoteDataSource blogremoteDataSource;
  final ConnectionChecker connectionChecker;
  BlogRepositoryImplimentation(
    this.blogremoteDataSource,
    this.connectionChecker,
  );
  @override
  Future<Either<Failure, Blog>> upladBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await connectionChecker.isConnected()) {
        return left(Failure( 'No Internet Connection'));
      }
      BlogModel blogModel = BlogModel(
        id:const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        topics: topics,
        imageUrl: '',
        updateddAt: DateTime.now(),
      );
      final imageUrl = await blogremoteDataSource.uploadBlogImage(
        blog: blogModel,
        image: image,
      );
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog = await blogremoteDataSource.uploadBlog(blogModel);
      return Right(uploadedBlog);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, List<Blog>>> getBlogs() async {
    try {
      final blogs = await blogremoteDataSource.getBlogs();
      return Right(blogs);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
