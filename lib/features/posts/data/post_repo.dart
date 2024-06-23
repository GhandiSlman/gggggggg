import 'package:lms/core/data/data_state.dart';

import 'package:lms/features/posts/model/add_post_model.dart';
import 'package:lms/features/posts/model/like_model.dart';
import 'package:lms/features/posts/model/post_model.dart';
import 'package:lms/features/posts/model/update_post_model.dart';

abstract class PostRepo {
  Future<DataState> addPost({required Homework addPostModel});
  Future<DataState> getPosts(
      {required PostModel postModel, required int page, required int gradeId});
  Future<DataState> deletePost({required int postId});
  Future<DataState> updatePost(
      {required UpdatePostData updatePostData, required int id});
        Future<DataState> like(
      {required LikeModel addCommentModel, required int postId});

}
