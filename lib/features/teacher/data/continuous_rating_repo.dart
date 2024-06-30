import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/teacher/model/add_continuous_rate.dart';
import 'package:lms/features/teacher/model/add_continuous_rate_student.dart';
import 'package:lms/features/teacher/model/coninuous_rating_student.dart';
import 'package:lms/features/teacher/model/continuous_rating.dart';

import 'package:lms/features/teacher/model/update_continuous_rate.dart';

abstract class ContinuousRatingRepo{
  Future<DataState> getContinuousRating({required ContinuousRating continuousRating});
  Future<DataState> addContinuousRate({required AddContinuousRating addContinuousRating});
  Future<DataState> getContinuousRateStudent({required GetContinuousRateStudent getContinuousRateStudent , required int rateId});
  Future<DataState> addContinuousRateStudent({required AddContinuousRateStudent addContinuousRateStudent});
  Future<DataState> updateContinuousRateStudent({required UpdateContinuousRate updateContinuousRate ,required int id});
  Future<DataState> deleteContinuousRate({required int id});
  Future<DataState> deleteContinuousRateStudent({required int id});

    Future<DataState> getSubjects(
      {required StudentAttendance studentAttendance});
 }