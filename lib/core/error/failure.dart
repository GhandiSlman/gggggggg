import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{}

class OfflineFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure{
  @override
  List<Object?> get props => [];
}

// class EmptyCacheFailure extends Failure{
//   @override
//   List<Object?> get props => [];
// }

class WrongInfoFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnExpectedFailure extends Failure {
  @override
  List<Object?> get props => [];
}