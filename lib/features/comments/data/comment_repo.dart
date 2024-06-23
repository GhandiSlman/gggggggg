import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/comments/model/add_comment_model.dart';
import 'package:lms/features/comments/model/get_comment_model.dart';

abstract class CommentRepo {
  Future<DataState> addComment(
      {required AddCommentData addCommentModel, required int postId});

  Future<DataState> getComment(
      {required GetCommentModel comments, required int postId});

  Future<DataState> addCommentWeekPlane(
      {required AddCommentWeekPlane addCommentWeekPlane,
      required int weekPlaneId});

  Future<DataState> getCommentWeekPlane( {required GetCommentWeekPlane getCommentWeekPlane , required int weekPlaneId});
}
