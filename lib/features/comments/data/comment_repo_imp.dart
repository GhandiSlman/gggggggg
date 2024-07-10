import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/comments/data/comment_repo.dart';
import 'package:lms/features/comments/model/add_comment_model.dart';
import 'package:lms/features/comments/model/get_comment_model.dart';

class CommentRepoImp implements CommentRepo {
  final DataService _dataService;
  CommentRepoImp(this._dataService);

  @override
  Future<DataState> addComment(
      {required AddCommentData addCommentModel, required int postId}) async {
    final response = await _dataService.postData(
      endPoint:box.read('userType') == 'teacher'
          ? 'teacher/dailyUpdatePost/addComment'
          : box.read('userType') == 'supervisor'
              ? 'supervisor/dailyUpdatePost/addComment'
              : box.read('userType') == 'guardian'
                  ? 'parent/dailyUpdatePost/addComment'
                  : 'student/dailyUpdatePost/addComment',
      data: addCommentModel.toJson(),
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => AddCommentData.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> getComment(
      {required GetCommentModel comments, required int postId}) async {
    final response = await _dataService.getData<GetCommentModel>(
      endPoint: box.read('userType') == 'teacher'
          ? 'teacher/dailyUpdatePost/getComments/$postId'
          : box.read('userType') == 'supervisor'
              ? 'supervisor/dailyUpdatePost/getComments/$postId'
              : box.read('userType') == 'guardian'
                  ? 'parent/dailyUpdatePost/getComments/$postId'
                  : 'student/dailyUpdatePost/getComments/$postId',
      baseUrl: baseUrl, 
      fromJson: (json) => GetCommentModel.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> addCommentWeekPlane(
      {required AddCommentWeekPlane addCommentWeekPlane,
      required int weekPlaneId}) async {
    final response = await _dataService.postData(
      endPoint: 'teacher/weekPlan/addComment',
      data: addCommentWeekPlane.toJson(),
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => AddCommentData.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> getCommentWeekPlane(
      {required GetCommentWeekPlane getCommentWeekPlane,
      required int weekPlaneId}) async {
    final response = await _dataService.getData<GetCommentWeekPlane>(
      endPoint: 'teacher/weekPlan/getComments/$weekPlaneId',
      baseUrl: baseUrl,
      fromJson: (json) => GetCommentWeekPlane.fromJson(json),
    );
    return response;
  }
}
