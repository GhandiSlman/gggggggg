import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/supervisor/model/add_advertisements_model.dart';
import 'package:lms/features/supervisor/model/advertisements_model.dart';
import 'package:lms/features/supervisor/model/news_model.dart';
import 'package:lms/features/supervisor/model/update_ad_model.dart';

abstract class AdvertisementsRepo {
  Future<DataState> getAdvertisements({required Advertisements advertisements});
  Future<DataState> getMyAdvertisements(
      {required Advertisements advertisements});
  Future<DataState> addAdvertisement(
      {required AddAdvertisementModel addAdvertisementModel});
  Future<DataState> updateAdvertisement(
      {required UpdateAdvertisementModel updateAdvertisementModel});
       Future<DataState> deleteAdvertisement(
      {required int id});

   Future<DataState> getNews({required NewsModel newsModel});
}
