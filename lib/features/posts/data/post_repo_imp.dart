import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/posts/data/post_repo.dart';
import 'package:lms/features/posts/model/add_post_model.dart';

import 'package:lms/features/posts/model/like_model.dart';
import 'package:lms/features/posts/model/post_model.dart';
import 'package:lms/features/posts/model/update_post_model.dart';

class PostRepoImp implements PostRepo {
  final DataService _dataService;

  PostRepoImp(this._dataService);

  @override
  Future<DataState> addPost({required Homework addPostModel}) async {
    final response = await _dataService.postDataWithPhoto(
      endPoint: 'teacher/dailyUpdatePost/store',
      data: addPostModel.toJson(),
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => Homework.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> getPosts({
    required PostModel postModel,
    required int page,
    required int gradeId,
  }) async {
    final response = await _dataService.getData<PostModel>(
      endPoint: box.read('userType') == 'supervisor'
          ? 'supervisor/dailyUpdatePost/index/$gradeId?page=$page'
          : box.read('userType') == 'guardian'
              ? 'parent/dailyUpdatePost/index/$gradeId?page=$page'
              : box.read('userType') == 'teacher'
                  ? 'teacher/dailyUpdatePost/index/$gradeId?page=$page'
                  : box.read('userType') == 'student'
                      ? 'student/dailyUpdatePost/index'
                      : '',
      baseUrl: baseUrl,
      queryParameters: {'page': '$page'},
      fromJson: (Map<String, dynamic> json) => PostModel.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> deletePost({required int postId}) async {
    final response = await _dataService.getData(
      endPoint: 'teacher/dailyUpdatePost/delete/$postId',
      baseUrl: baseUrl,
      fromJson: (json) => PostModel.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> updatePost(
      {required UpdatePostData updatePostData, required int id}) async {
    final response = await _dataService.postData(
      endPoint: 'teacher/dailyUpdatePost/update',
      data: updatePostData.toJson(),
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => UpdatePostData.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> like(
      {required LikeModel addCommentModel, required int postId}) async {
    final response = await _dataService.getData<LikeModel>(
      endPoint: box.read('userType') == 'teacher'
          ? 'teacher/dailyUpdatePost/like/$postId'
          : box.read('userType') == 'supervisor'
              ? 'supervisor/dailyUpdatePost/like/$postId'
              : box.read('userType') == 'guardian'
                  ? 'parent/dailyUpdatePost/like/$postId'
                  : 'student/dailyUpdatePost/like/$postId',
      baseUrl: baseUrl,
      fromJson: (json) => LikeModel.fromJson(json),
    );
    return response;
  }
}
