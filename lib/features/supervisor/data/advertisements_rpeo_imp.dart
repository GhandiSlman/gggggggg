import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/supervisor/data/advertisements_repo.dart';
import 'package:lms/features/supervisor/model/advertisements_model.dart';

class AdvertisementsRepoImp implements AdvertisementsRepo {
  final DataService _dataService;
  AdvertisementsRepoImp(this._dataService);

  @override
  Future<DataState> getAdvertisements({required Advertisements advertisements}) async {
    final response = await _dataService.getData<Advertisements>(
      endPoint: 'supervisor/advertisements/index', 
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => Advertisements.fromJson(json),
    );
    return response;
  }
}
