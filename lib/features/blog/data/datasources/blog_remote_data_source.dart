import 'dart:io';

import 'package:blog_application/core/error/exceptions.dart';
import 'package:blog_application/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
  Future <List<BlogModel>> getBlogs();
}
class BlogRemoteDataSourceImplimentation implements BlogRemoteDataSource {
      final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImplimentation(this.supabaseClient);
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async{
    try{

      final blogData = 
      await supabaseClient.from('blogs').insert(
        blog.toJson()
      ).select();
      return BlogModel.fromJson(blogData.first);
    }catch(message){
      throw ServerException(message: message.toString());
    }

}

  @override
  Future<String> uploadBlogImage({required File image, required BlogModel blog}) async {
    try{
      await supabaseClient.storage.from('blog_images').upload(
        blog.id,
        image,
      );
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    }catch(message){
      throw ServerException(message: message.toString());
    }
  }
  
  @override
  Future<List<BlogModel>> getBlogs()async{
    try{
      final blogsData = await supabaseClient.from('blogs').select('*, profiles(name)');
      return blogsData.map((e) => BlogModel.fromJson(e).copyWith(
        posterName: e['profiles']['name'] as String
      ))
      .toList();
    }catch(message){
      throw ServerException(message: message.toString());
    }
    
  }
}