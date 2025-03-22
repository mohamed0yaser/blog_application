import 'dart:io';

import 'package:blog_application/core/error/exceptions.dart';
import 'package:blog_application/core/error/failures.dart';
import 'package:blog_application/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_application/features/blog/data/models/blog_model.dart';
import 'package:blog_application/features/blog/domain/entities/blog.dart';
import 'package:blog_application/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImplimentation implements BlogRepository {
  final BlogRemoteDataSource blogremoteDataSource;
  BlogRepositoryImplimentation(this.blogremoteDataSource);
  @override
  Future<Either<Failure, Blog>> upladBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
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
      await blogremoteDataSource.uploadBlog(blogModel);
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      return Right(blogModel);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
