import 'package:animal_app/onboard/data/models/ob_all_request_model.dart';
import 'package:animal_app/onboard/domain/entities/ob_registration_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:share_module/core/errors/failures.dart';

abstract class ObRepository {
  Future<Either<Failure, UserRegistrationEntity>> register({
    required ObRegRequestModel request,
  });
}
