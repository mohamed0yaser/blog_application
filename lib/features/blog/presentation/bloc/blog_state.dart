part of 'blog_bloc.dart';

@immutable
sealed class BlogState extends Equatable {
  @override
  List<Object> get props => [];
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String message;
  BlogFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class BlogSuccess extends BlogState {}
