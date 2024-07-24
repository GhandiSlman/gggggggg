import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/supervisor/data/advertisements_repo.dart';
import 'package:lms/features/supervisor/model/add_advertisements_model.dart';
import 'package:lms/features/supervisor/model/advertisements_model.dart';
import 'package:lms/features/supervisor/model/update_ad_model.dart';

class AdvertisementsRepoImp implements AdvertisementsRepo {
  final DataService _dataService;
  AdvertisementsRepoImp(this._dataService);

  @override
  Future<DataState> getAdvertisements(
      {required Advertisements advertisements}) async {
    String endPoint = "";
    switch (box.read("userType")) {
      case 'supervisor':
        endPoint = 'supervisor/advertisements/index';
      case 'student':
        endPoint = 'student/advertisements/index';
      case 'teacher':
        endPoint = 'teacher/advertisements/index';
      case 'parent':
        endPoint = 'parent/advertisements/index';
    }
    final response = await _dataService.getData<Advertisements>(
      endPoint: endPoint,
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => Advertisements.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> getMyAdvertisements(
      {required Advertisements advertisements}) async {
    final response = await _dataService.getData<Advertisements>(
      endPoint: 'supervisor/advertisements/authIndex',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => Advertisements.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> addAdvertisement(
      {required AddAdvertisementModel addAdvertisementModel}) async {
    final response =
        await _dataService.postDataWithPhoto<AddAdvertisementModel>(
      endPoint: 'supervisor/advertisements/store',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) =>
          AddAdvertisementModel.fromJson(json),
      data: addAdvertisementModel.toJson(),
    );
    return response;
  }

  @override
  Future<DataState> updateAdvertisement(
      {required UpdateAdvertisementModel updateAdvertisementModel}) async {
    final response =
        await _dataService.postDataWithPhoto<UpdateAdvertisementModel>(
      endPoint: 'supervisor/advertisements/update',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) =>
          UpdateAdvertisementModel.fromJson(json),
      data: updateAdvertisementModel.toJson(),
    );
    return response;
  }

  @override
  Future<DataState> deleteAdvertisement({required int id}) async {
    final response = await _dataService.getData<Advertisements>(
      endPoint: 'supervisor/advertisements/delete/$id',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => Advertisements.fromJson(json),
    );
    return response;
  }
}
