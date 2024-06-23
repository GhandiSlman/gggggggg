import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/supervisor/model/advertisements_model.dart';


abstract class AdvertisementsRepo {
  Future<DataState> getAdvertisements({required Advertisements advertisements});
}
