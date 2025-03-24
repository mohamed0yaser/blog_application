import 'package:blog_application/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updateddAt,
    super.postername,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      posterId: json['poster_id'] as String,
      title: json['title'] as String,
      content: json['context'] as String,
      imageUrl: json['image_url'] as String,
      topics: List<String>.from(json['topics'] ?? []),
      updateddAt: json['updated_at'] == null 
      ? DateTime.now()
      :DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poster_id': posterId,
      'title': title,
      'context': content,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at': updateddAt.toIso8601String(),
    };
  }

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updateddAt,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updateddAt: updateddAt ?? this.updateddAt,
      postername: posterName ?? this.postername,
    );
  }

}